Imports System.Data.SqlClient
Imports System.Data
Partial Class public_Citation_details
    Inherits System.Web.UI.Page

    Private _CitationID As Int32

    Public Property CitationID() As Int32
        Get
            Return _CitationID
        End Get
        Set(ByVal value As Int32)
            _CitationID = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim queryPtid As String = Request.QueryString("citationid")
        Dim cid As Int32
        If Not IsPostBack Then
            If Integer.TryParse(queryPtid, cid) Then
                CitationID = cid
                getCitation()
                getRelatedTheory()
                getComments()
                hledit.NavigateUrl = "Citation-edit-page.aspx?citationid=" & CitationID
            End If
        Else
            If Integer.TryParse(queryPtid, cid) Then
                CitationID = cid


            End If

        End If
    End Sub

    Private Sub getCitation()
        'Dim result As String
        Dim parameters() As SqlParameter = New SqlParameter() _
       {
         New SqlParameter("@CitationID", SqlDbType.Int) With {.Value = CitationID}
     }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetCitation", parameters)
        If Not dt1 Is Nothing Then
            lblTitle.Text = dt1.Rows(0)("Title").ToString()
            lblCitation.Text = dt1.Rows(0)("Citation").ToString()
            lblyear.Text = dt1.Rows(0)("YearPublished").ToString()
            If String.IsNullOrEmpty(lblyear.Text) Then
                dvPubYear.Visible = False
            End If
            lblAuthor.Text = dt1.Rows(0)("Authors").ToString()
            If String.IsNullOrEmpty(lblAuthor.Text) Then
                dvAuthor.Visible = False
            End If

            lblType.Text = dt1.Rows(0)("PubTypeDesc").ToString()
            If String.IsNullOrEmpty(lblType.Text) Then
                dvPubType.Visible = False
            End If

            hlonline.Text = dt1.Rows(0)("ResourceURL").ToString()
            If String.IsNullOrEmpty(hlonline.Text) Then
                dvAvOnline.Visible = False
            End If

            hlpubmedID.Text = dt1.Rows(0)("PubMedID").ToString()
            hlpubmedID.NavigateUrl = "http://www.ncbi.nlm.nih.gov/pubmed/" + dt1.Rows(0)("PubMedID").ToString()
            If String.IsNullOrEmpty(hlpubmedID.Text) Then
                dvPubMedId.Visible = False
            End If

            hlDOI.Text = dt1.Rows(0)("DOI").ToString()
            hlDOI.NavigateUrl = "https://doi.org/" + dt1.Rows(0)("DOI").ToString()
            If String.IsNullOrEmpty(hlDOI.Text) Then
                dvDOI.Visible = False
            End If
        End If

    End Sub

    Sub getRelatedTheory()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@CitationID", SqlDbType.Int) With {.Value = CitationID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetCitationTheories", parameters)
        'Dim dvData As New DataView(dt1)
        'dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        rptRelatedTheories.DataSource = dt1
        rptRelatedTheories.DataBind()
    End Sub
    Sub getComments()
        Dim parameters() As SqlParameter = New SqlParameter() _
          {
            New SqlParameter("@CitationID", SqlDbType.Int) With {.Value = CitationID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetCitationComments", parameters)
        rptcomments.DataSource = dt1
        rptcomments.DataBind()
    End Sub
    Protected Sub btnSubmitComment_Click(sender As Object, e As EventArgs)
        hdTab.Value = "5"
        If Not String.IsNullOrEmpty(txtCommentTitle.Text().Trim()) And Not String.IsNullOrEmpty(txtCommentText.Text().Trim()) Then
            addNewComment()
            getComments()
        End If
    End Sub

    Sub addNewComment()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@ResourceCommentID", SqlDbType.Int),
            New SqlParameter("@CitationID", SqlDbType.Int) With {.Value = CitationID},
            New SqlParameter("@CommentTitle", SqlDbType.NVarChar, 600),
            New SqlParameter("@CommentText", SqlDbType.NVarChar)
        }
        parameters(0).Direction = ParameterDirection.Output
        parameters(2).Value = txtCommentTitle.Text().Trim()
        parameters(3).Value = txtCommentText.Text().Trim()

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveCitationComment", parameters)
    End Sub
    Protected Sub rptRelatedTheories_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
    'Dim rptConstructList As Repeater
        If (e.Item.ItemType = ListItemType.Item) Or
              (e.Item.ItemType = ListItemType.AlternatingItem) Then

      'rptConstructList = e.Item.FindControl("rptConstructList")

            Dim DI As Object = e.Item.DataItem
            Dim strConstruct As String = DataBinder.Eval(DI, "ConstructList").ToString()

            Dim theoryID As String = DataBinder.Eval(DI, "TheoryID").ToString()




            If Not String.IsNullOrEmpty(strConstruct) Then
                Dim xmlDoc = XDocument.Parse("<prow>" + strConstruct + "</prow>")
                Dim rowList = From p In xmlDoc.Descendants("row")
                              Select New With {.ConstructName = p.Attribute("ConstructName").Value,
                                               .TheoryID = theoryID}


                Dim PList = rowList.ToList()

        'rptConstructList.DataSource = PList
        'rptConstructList.DataBind()

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
    End Sub
End Class
