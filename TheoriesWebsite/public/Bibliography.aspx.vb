Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Partial Class public_Bibliography
    Inherits System.Web.UI.Page
    Private _pagenumber As Int32 = 1
    Private _maxpagecount As Int32
    Private _alpCurrent As String = "all"

    Public Property MaxPageCount() As Int32
        Get
            Return _MaxPageCount
        End Get
        Set(ByVal value As Int32)
            _MaxPageCount = value
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
            Dim sortcolumn As String = Request.QueryString("sc")
            Dim sortorder As String = Request.QueryString("so")
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

            If Not String.IsNullOrEmpty(sortcolumn) Then
                ViewState("column") = sortcolumn
            Else
                ViewState("column") = "DateAdded"
            End If

            If Not String.IsNullOrEmpty(sortorder) Then
                ViewState("sortorder") = sortorder
            Else
                ViewState("sortorder") = "DESC"
            End If
            'Me.GenerateAlphabets()

            Me.BindRepeater()
            Me.BindPubTypeFilterDropDown()
            Me.BindPubYearFilterDropDown()
        End If

    End Sub
    Sub BindRepeater()

        '       @RecCnt smallint = null
        ',@LetterGroup char(1) = null
        ',@UserID varchar(75) = null
        ',@PubTypeID int = null
        ',@YearPublished int = null
        ',@SearchKeyword nvarchar(150) = null
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@RecCnt", SqlDbType.Int, 50) With {.Value = Nothing},
          New SqlParameter("@LetterGroup", SqlDbType.Char, 1),
          New SqlParameter("@UserID", SqlDbType.VarChar, 50) With {.Value = Nothing},
          New SqlParameter("@PubTypeID", SqlDbType.Int),
          New SqlParameter("@YearPublished", SqlDbType.Int),
          New SqlParameter("@SearchKeyword", SqlDbType.NVarChar, 150)
        }
        If AlpCurrent.Length = 1 And AlpCurrent.ToLower() <> "all" Then
            parameters(1).Value = AlpCurrent
        Else
            parameters(1).Value = Nothing
        End If
        If ddlPubType_filter.SelectedValue = "all" Then
            parameters(3).Value = Nothing
        Else
            parameters(3).Value = Convert.ToInt32(ddlPubType_filter.SelectedValue)
        End If
        If ddlPubYear_Filter.SelectedValue = "all" Then
            parameters(4).Value = Nothing
        Else
            parameters(4).Value = Convert.ToInt32(ddlPubYear_Filter.SelectedValue)
        End If
        If String.IsNullOrEmpty(txtSearch.Text().Trim) Then
            parameters(5).Value = Nothing
        Else
            parameters(5).Value = txtSearch.Text().Trim
        End If

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetBibliography", parameters)

        Dim pgitems As New PagedDataSource()
        Dim pagesize As Int32 = Int32.Parse(ConfigurationManager.AppSettings("PageSize"))
        Dim dv As New DataView(dt1)
        dv.Sort = ViewState("column") + " " + ViewState("sortorder")
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
        rptBibliography.DataSource = pgitems
        rptBibliography.DataBind()
        GenerateAlphabets()
    End Sub

    Private Sub GenerateAlphabets()
        Dim alppages As New ArrayList()
        Dim alp As String = String.Empty


        For i As Integer = 65 To 90
            alp = [Char].ConvertFromUtf32(i)
            alppages.Add(alp)
        Next
        alppages.Add("View All")

        rptAlpPaging.DataSource = alppages
        rptAlpPaging.DataBind()
    End Sub
    Protected Sub rptPaging_OnItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim hl As HyperLink
        Dim navurl As String = String.Empty

        If (e.Item.ItemType = ListItemType.Header) Then
            hl = e.Item.FindControl("hlPagingPrev")
            If Not hl Is Nothing Then
                navurl = hl.NavigateUrl
                navurl = navurl.Replace("{alp}", AlpCurrent)
                navurl = navurl.Replace("{sortcolumn}", ViewState("column").ToString())
                navurl = navurl.Replace("{sortorder}", ViewState("sortorder").ToString())
                hl.NavigateUrl = navurl
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
                navurl = navurl.Replace("{alp}", AlpCurrent)
                navurl = navurl.Replace("{sortcolumn}", ViewState("column").ToString())
                navurl = navurl.Replace("{sortorder}", ViewState("sortorder").ToString())
                hl.NavigateUrl = navurl
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
                navurl = navurl.Replace("{alp}", AlpCurrent)
                navurl = navurl.Replace("{sortcolumn}", ViewState("column").ToString())
                navurl = navurl.Replace("{sortorder}", ViewState("sortorder").ToString())
                hl.NavigateUrl = navurl
                If hl.Text = PageNumber.ToString() Then
                    hl.NavigateUrl = String.Empty
                    hl.CssClass = "active"
                End If
            End If
        End If

    End Sub

    Protected Sub rptAlpPaging_OnItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim hl As HyperLink
        Dim navurl As String = String.Empty

        If (e.Item.ItemType = ListItemType.Item) Or _
           (e.Item.ItemType = ListItemType.AlternatingItem) Then
            hl = e.Item.FindControl("hlAlpPaging")
            If Not hl Is Nothing Then
                navurl = hl.NavigateUrl
                hl.NavigateUrl = navurl.Replace("{pagenum}", PageNumber)
                If hl.Text.ToLower() = AlpCurrent.ToLower() Then
                    hl.NavigateUrl = String.Empty
                    hl.CssClass = "active"
                End If
            End If
        End If
    End Sub

    Protected Sub rptBibliography_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptBibliography.ItemDataBound
        Dim rptTheoriesList As Repeater
        Dim AllTheoriesLink As HyperLink
        Dim hlCitation As Label
        Dim hlPubMed As HyperLink

        If e.Item.ItemType = ListItemType.Header Then
            Dim lnbCitation As LinkButton = CType(e.Item.FindControl("lnbCitation"), LinkButton)
            Dim lnbPubType As LinkButton = CType(e.Item.FindControl("lnbPubType"), LinkButton)
            Dim lnbYearPublished As LinkButton = CType(e.Item.FindControl("lnbYearPublished"), LinkButton)
            Dim lnbDateAdded As LinkButton = CType(e.Item.FindControl("lnbDateAdded"), LinkButton)

            If ViewState("column").ToString() = "Title" Then
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbCitation.CssClass = "sort_up"
                Else
                    lnbCitation.CssClass = "sort_down"
                End If
            ElseIf ViewState("column").ToString() = "PubType" Then
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbPubType.CssClass = "sort_up"
                Else
                    lnbPubType.CssClass = "sort_down"
                End If
            ElseIf ViewState("column").ToString() = "YearPublished" Then
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbYearPublished.CssClass = "sort_up"
                Else
                    lnbYearPublished.CssClass = "sort_down"
                End If
            Else
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbDateAdded.CssClass = "sort_up"
                Else
                    lnbDateAdded.CssClass = "sort_down"
                End If
            End If
        End If

        If rptBibliography.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If

        If (e.Item.ItemType = ListItemType.Item) Or
              (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim DI As Object = e.Item.DataItem

            'Hyperlink Text in Citation Column
            hlCitation = e.Item.FindControl("hlCitation")
            hlPubMed = e.Item.FindControl("hlPubMed")
            Dim citation As String = DataBinder.Eval(DI, "Citation").ToString()
            Dim citationid As String = DataBinder.Eval(DI, "CitationID").ToString()
            Dim title As String = DataBinder.Eval(DI, "Title").ToString()
            Dim PubMedID As String = DataBinder.Eval(DI, "PubMedID").ToString()

            If String.IsNullOrEmpty(PubMedID) Then
                hlPubMed.Text = "-"
                hlPubMed.Style.Add("text-decoration", "none")
                hlPubMed.Enabled = False
            End If

            If (citation.IndexOf(title, StringComparison.InvariantCultureIgnoreCase) > -1) Then
                Dim hltitle = String.Format("<a href={0}>{1}</a>", "Citation_details.aspx?citationid=" + citationid, title)
                citation = citation.Replace(title, hltitle)
            End If
            hlCitation.Text = citation

            'Theories Column
            rptTheoriesList = e.Item.FindControl("rptTheoriesList")
            AllTheoriesLink = e.Item.FindControl("AllTheoriesLink")

            Dim strTheory As String = DataBinder.Eval(DI, "TheoryList").ToString()
            Dim TheoryCount As Int32 = Int32.Parse(DataBinder.Eval(DI, "TheoryCount"))

            If TheoryCount > 3 Then
                AllTheoriesLink.Text = "View all " & TheoryCount.ToString & " Theories"
            Else
                AllTheoriesLink.Visible = False
            End If

            If Not String.IsNullOrEmpty(strTheory) Then
                Dim xmlDoc = XDocument.Parse("<prow>" + strTheory + "</prow>")
                Dim rowList = From p In xmlDoc.Descendants("row")
                              Select New With {.TheoryName = p.Attribute("TheoryName").Value,
                                                  .TheoryID = p.Attribute("TheoryID").Value}

                Dim PList = rowList.ToList()
                rptTheoriesList.DataSource = PList
                rptTheoriesList.DataBind()
            End If
        End If

    End Sub
    Sub BindPubTypeFilterDropDown()
        Dim parameters() As SqlParameter = {}

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPubTypeList", parameters)

        ddlPubType_filter.DataSource = dt1.DefaultView
        ddlPubType_filter.DataBind()

    End Sub
    Sub BindPubYearFilterDropDown()
        Dim parameters() As SqlParameter = {}

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPubYearList", parameters)

        ddlPubYear_Filter.DataSource = dt1.DefaultView
        ddlPubYear_Filter.DataBind()

    End Sub

    Protected Sub rptBibliography_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = ViewState("column").ToString() Then
            If ViewState("sortorder").ToString() = "ASC" Then
                ViewState("sortorder") = "DESC"
            Else
                ViewState("sortorder") = "ASC"
            End If
        Else
            ViewState("column") = e.CommandName
            ViewState("sortorder") = "ASC"
        End If
        BindRepeater()
    End Sub

    Protected Sub btnGo_Click(sender As Object, e As EventArgs) Handles btnGo.Click
        BindRepeater()
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        ddlPubType_filter.SelectedValue = "all"
        ddlPubYear_Filter.SelectedValue = "all"
        BindRepeater()
    End Sub
End Class
