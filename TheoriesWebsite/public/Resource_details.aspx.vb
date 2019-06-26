Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Imports System.ComponentModel

Partial Class public_Resource_details
    Inherits System.Web.UI.Page
    Private _RID As Int32

    Public Property RID() As Int32
        Get
            Return _RID
        End Get
        Set(ByVal value As Int32)
            _RID = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
    Dim dtid As Int32
    Dim queryPtid As String = Request.QueryString("RID")
        If Not IsPostBack Then
      'Dim queryPtid As String = Request.QueryString("RID")
            If Integer.TryParse(queryPtid, dtid) Then
                RID = dtid
                getResource()

                ViewState("column") = "TheoryName"
                ViewState("sortorder") = "ASC"
                getRelatedTheory()


                getComments()
                hledit.NavigateUrl = "resource-edit-page.aspx?RID=" & RID
      End If

    Else
      If Integer.TryParse(queryPtid, dtid) Then
        RID = dtid
      End If
    End If
    End Sub

    Sub getResource()
        'Dim result As String
        Dim parameters() As SqlParameter = New SqlParameter() _
         {
          New SqlParameter("@ResourceID ", SqlDbType.Int) With {.Value = RID}
         }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResource", parameters)
        If Not dt1 Is Nothing Then
            ltltitle.Text = dt1.Rows(0)("ResourceName").ToString()
            lblTitle.Text = dt1.Rows(0)("ResourceName").ToString()
            lblDesc.Text = dt1.Rows(0)("ResourceDesc").ToString()
            lblType.Text = dt1.Rows(0)("ResourceTypeDesc").ToString()
            hlURL.NavigateUrl = dt1.Rows(0)("ResourceURL").ToString()
            hlURL.Text = dt1.Rows(0)("ResourceURL").ToString()

            lblAddedBy.Text = dt1.Rows(0)("CreateUser").ToString()
            If Not String.IsNullOrEmpty(dt1.Rows(0)("CreateDT").ToString()) Then
                lblAddedDate.Text = Convert.ToDateTime(dt1.Rows(0)("CreateDT")).ToString("MM/dd/yyyy")
            End If

            lblUpdatedBy.Text = dt1.Rows(0)("UpdateUser").ToString()
            If Not String.IsNullOrEmpty(dt1.Rows(0)("UpdateDT").ToString()) Then
                lblUpdatedDate.Text = "(" & Convert.ToDateTime(dt1.Rows(0)("UpdateDT")).ToString("MM/dd/yyyy") & ")"
            End If

        End If

    End Sub

    Sub getComments()
        Dim parameters() As SqlParameter = New SqlParameter() _
          {
            New SqlParameter("@ResourceID", SqlDbType.Int) With {.Value = RID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResourceComments", parameters)
        rptcomments.DataSource = dt1
        rptcomments.DataBind()
    End Sub

    Sub getRelatedTheory()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@ResourceID", SqlDbType.Int) With {.Value = RID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResourceTheories", parameters)
        Dim dvData As New DataView(dt1)
        dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        rptRelatedTheories.DataSource = dvData
        rptRelatedTheories.DataBind()
    End Sub

    Protected Sub rptRelatedTheories_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptRelatedTheories.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            Dim lnbName As LinkButton = CType(e.Item.FindControl("lnbTheoryName"), LinkButton)

            If ViewState("column").ToString() = "TheoryName" Then
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbName.CssClass = "sort_up"
                Else
                    lnbName.CssClass = "sort_down"
                End If
            End If
        End If
        If rptRelatedTheories.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If

        Dim rptConstructList As Repeater
        Dim AllConstructsLink As HyperLink
        If (e.Item.ItemType = ListItemType.Item) Or _
             (e.Item.ItemType = ListItemType.AlternatingItem) Then

            rptConstructList = e.Item.FindControl("rptConstructList")
            AllConstructsLink = e.Item.FindControl("AllConstructsLink")

            Dim DI As Object = e.Item.DataItem
            Dim strConstruct As String = DataBinder.Eval(DI, "ConstructList").ToString()
            


            If Not String.IsNullOrEmpty(strConstruct) Then
                Dim xmlDoc = XDocument.Parse("<prow>" + strConstruct + "</prow>")
                Dim rowList = From p In xmlDoc.Descendants("row") _
                                 Select New With {.ConstructName = p.Attribute("ConstructName").Value}

                Dim PList = rowList.ToList()

                rptConstructList.DataSource = PList
                rptConstructList.DataBind()
            End If
        End If
    End Sub

    Protected Sub rptRelatedTheories_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
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
        Dim queryPtid As String = Request.QueryString("RID")
        Dim dtid As Int32
        If Integer.TryParse(queryPtid, dtid) Then
            RID = dtid
            getRelatedTheory()
        End If
  End Sub

  Protected Sub btnSubmitComment_Click(sender As Object, e As EventArgs)
    hdTab.Value = "1"
    If Not String.IsNullOrEmpty(txtCommentTitle.Text().Trim()) And Not String.IsNullOrEmpty(txtCommentText.Text().Trim()) Then
      addNewComment()
      getComments()
    End If
  End Sub

  Sub addNewComment()
    Dim parameters() As SqlParameter = New SqlParameter() _
    {
        New SqlParameter("@ResourceCommentID", SqlDbType.Int),
        New SqlParameter("@ResourceID", SqlDbType.Int) With {.Value = RID},
        New SqlParameter("@CommentTitle", SqlDbType.NVarChar, 600),
        New SqlParameter("@CommentText", SqlDbType.NVarChar)
    }
    parameters(0).Direction = ParameterDirection.Output
    parameters(2).Value = txtCommentTitle.Text().Trim()
    parameters(3).Value = txtCommentText.Text().Trim()

    DataAccess.ExecuteNonQueryStoredProc("usp_SaveResourceComment", parameters)
  End Sub


End Class
