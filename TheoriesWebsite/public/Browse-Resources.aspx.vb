Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess


Partial Class BrowseResources
    Inherits System.Web.UI.Page

    Private _pagenumber As Int32 = 1
    Private _maxpagecount As Int32
    Private _alpCurrent As String = "all"
  Private _sortcolumn As String = String.Empty
  Private _sortorder As String = String.Empty

    Public Property MaxPageCount() As Int32
        Get
            Return _maxpagecount
        End Get
        Set(ByVal value As Int32)
            _maxpagecount = value
        End Set
    End Property
    Public Property AlpCurrent() As String
        Get
            Return _alpCurrent
        End Get
        Set(ByVal value As String)
            _alpCurrent = value
        End Set
    End Property

    Public Property PageNumber() As Int32
        Get
            Return _pagenumber
        End Get
        Set(ByVal value As Int32)
            _pagenumber = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim pn As Int32

    If Not IsPostBack Then
      Dim queryPN As String = Request.QueryString("pagenum")
      Dim queryAC As String = Request.QueryString("alp")
      Dim sc As String = Request.QueryString("sc")
      Dim so As String = Request.QueryString("so")

      If Integer.TryParse(queryPN, pn) Then
        PageNumber = pn
      End If
      If Not String.IsNullOrEmpty(queryAC) Then
        If queryAC.Length = 1 And queryAC <> "all" Then
          AlpCurrent = queryAC
        Else
          AlpCurrent = "all"
        End If
      End If
      If Not String.IsNullOrEmpty(sc) Then
        ViewState("sortcolumn") = sc
      Else
        ViewState("sortcolumn") = "ResourceName"
      End If

      If Not String.IsNullOrEmpty(so) Then
        ViewState("sortorder") = so
      Else
        ViewState("sortorder") = "asc"
      End If
      'Me.GenerateAlphabets()
      Me.BindRepeater()
      Me.BindResourcesTypeFilterDropDown()

    End If

    End Sub

    Sub BindRepeater()
    Dim parameters() As SqlParameter = New SqlParameter() _
    {
      New SqlParameter("@UserID", SqlDbType.VarChar, 50) With {.Value = Nothing},
      New SqlParameter("@ResourceTypeID", SqlDbType.Int),
      New SqlParameter("@SearchKeyword", SqlDbType.NVarChar, 150)
    }

    If ddlResourceType_Filter.SelectedValue = "all" Then
      parameters(1).Value = Nothing
    Else
      parameters(1).Value = Convert.ToInt32(ddlResourceType_Filter.SelectedValue)
    End If
    
    If String.IsNullOrEmpty(txtSearch.Text().Trim) Then
      parameters(2).Value = Nothing
    Else
      parameters(2).Value = txtSearch.Text().Trim
    End If

    Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResourceList", parameters)

        Dim pgitems As New PagedDataSource()
        Dim pagesize As Int32 = Int32.Parse(ConfigurationManager.AppSettings("PageSize"))
    Dim dv As New DataView(dt1)
    'dv.Sort = ViewState("sortcolumn") + " " + ViewState("sortorder")
        pgitems.DataSource = dv
        pgitems.AllowPaging = True
        pgitems.PageSize = pagesize
        MaxPageCount = pgitems.PageCount
        If PageNumber > MaxPageCount Then
            PageNumber = MaxPageCount
        End If
        pgitems.CurrentPageIndex = PageNumber - 1
        If pgitems.PageCount > 1 Then
            rptPaging.Visible = True
            Dim pages As New ArrayList()
            For i As Integer = 0 To pgitems.PageCount - 1
                pages.Add((i + 1).ToString())
            Next
            rptPaging.DataSource = pages
            rptPaging.DataBind()
        Else
            rptPaging.Visible = False
        End If
        rptResourcesList.DataSource = pgitems
    rptResourcesList.DataBind()


    End Sub
    Protected Sub rptPaging_OnItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim hl As HyperLink
        Dim navurl As String = String.Empty

        If (e.Item.ItemType = ListItemType.Header) Then
            hl = e.Item.FindControl("hlPagingPrev")
            If Not hl Is Nothing Then
                navurl = hl.NavigateUrl
                hl.NavigateUrl = navurl.Replace("{alp}", AlpCurrent)
                If PageNumber = 1 Then
                    hl.Visible = False
                Else
                    hl.NavigateUrl += (PageNumber - 1).ToString()
                End If
            End If
        End If
        If (e.Item.ItemType = ListItemType.Footer) Then
            hl = e.Item.FindControl("hlPagingNext")
            If Not hl Is Nothing Then
                navurl = hl.NavigateUrl
                hl.NavigateUrl = navurl.Replace("{alp}", AlpCurrent)
                If PageNumber = MaxPageCount Then
                    hl.Visible = False
                Else
                    hl.NavigateUrl += (PageNumber + 1).ToString()
                End If
            End If
        End If

        If (e.Item.ItemType = ListItemType.Item) Or _
              (e.Item.ItemType = ListItemType.AlternatingItem) Then
            hl = e.Item.FindControl("hlPaging")
            If Not hl Is Nothing Then
                navurl = hl.NavigateUrl
                hl.NavigateUrl = navurl.Replace("{alp}", AlpCurrent)
                If hl.Text = PageNumber.ToString() Then
                    hl.NavigateUrl = String.Empty
                    hl.CssClass = "active"
                End If
            End If
        End If

    End Sub

    Private Sub rptResourcesList_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptResourcesList.ItemDataBound
        Dim rptTheoryList As Repeater
        'Dim AlltheoriesLink As HyperLink

        If rptResourcesList.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If

        If (e.Item.ItemType = ListItemType.Item) Or
              (e.Item.ItemType = ListItemType.AlternatingItem) Then

            rptTheoryList = e.Item.FindControl("rptTheoriesList")
            'AlltheoriesLink = e.Item.FindControl("AlltheoriesLink")

            Dim DI As Object = e.Item.DataItem
            Dim strTheory As String = DataBinder.Eval(DI, "TheoryList").ToString()
            'Dim TheoryCount As Int32 = Int32.Parse(DataBinder.Eval(DI, "ConstructCount"))

            'If ConstructCount > 3 Then
            '    AllConstructsLink.Text = "View all " & ConstructCount.ToString & " Constructs"
            'Else
            '    AllConstructsLink.Visible = False
            'End If


            If Not String.IsNullOrEmpty(strTheory) Then
                Dim xmlDoc = XDocument.Parse("<prow>" + strTheory + "</prow>")
                Dim rowList = From p In xmlDoc.Descendants("row")
                              Select New With {.TheoryName = p.Attribute("TheoryName").Value,
                                               .TheoryID = p.Attribute("TheoryID").Value}

                Dim PList = rowList.ToList()

                rptTheoryList.DataSource = PList
                rptTheoryList.DataBind()
            End If
        End If
  End Sub
  Sub BindResourcesTypeFilterDropDown()
    Dim parameters() As SqlParameter = {}

    Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResoureTypeList", parameters)

    ddlResourceType_Filter.DataSource = dt1.DefaultView
    ddlResourceType_Filter.DataBind()

  End Sub
  Protected Sub rptTheoriesList_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
    If e.CommandName.ToLower() = ViewState("sortcolumn") Then
      If ViewState("sortorder") = "asc" Then
        ViewState("sortorder") = "desc"
      Else
        ViewState("sortorder") = "asc"
      End If
    Else
      ViewState("sortcolumn") = e.CommandName.ToLower()
      ViewState("sortorder") = "asc"
    End If
    BindRepeater()
  End Sub
  Protected Sub btngo_Click(sender As Object, e As EventArgs) Handles btnGo.Click
    txtSearch.Text = String.Empty
    BindRepeater()
  End Sub

  Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
    ddlResourceType_Filter.SelectedValue = "all"
    BindRepeater()
  End Sub
End Class
