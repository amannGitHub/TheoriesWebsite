Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Imports System.ComponentModel

Partial Class public_Theory_details
    Inherits System.Web.UI.Page
    Private _TID As Int32
    Dim count As Int32
    Public Property TID() As Int32
        Get
            Return _TID
        End Get
        Set(ByVal value As Int32)
            _TID = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim dtid As Int32
        Dim queryPtid As String = Request.QueryString("TID")
        If Not IsPostBack Then
            If Integer.TryParse(queryPtid, dtid) Then
                TID = dtid
                getTheory()

                ViewState("column") = "RelevanceOrder"
                ViewState("sortorder") = "ASC"
                getReference()

                ViewState("ccolumn") = "ConstructName"
                ViewState("csortorder") = "ASC"
                getConstruct()

                getDiagrams()
                getRelatedTheory()

                ViewState("ARcolumn") = "ResourceName"
                ViewState("ARsortorder") = "ASC"
                getAdditionalResources()
                getComments()
                getTheoryModelThumbnails()
                hledit.NavigateUrl = "theory-edit-page.aspx?TID=" & TID
            End If
        Else
            If Integer.TryParse(queryPtid, dtid) Then
                TID = dtid
            End If
        End If
    End Sub

    Sub getTheory()
        'Dim result As String
        Dim parameters() As SqlParameter = New SqlParameter() _
       {
         New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
     }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheory", parameters)
        If Not dt1 Is Nothing Then
            ltltitle.Text = dt1.Rows(0)("TheoryName").ToString()
            lblTitle.Text = dt1.Rows(0)("TheoryName").ToString()
            lblYear.Text = dt1.Rows(0)("YearPublished").ToString()
            lblDesc.Text = dt1.Rows(0)("TheoryDescription").ToString()
            '    Dim sdesccount As Int32 = Int32.Parse(ConfigurationManager.AppSettings("DescCount"))
            '    If sdesc.Length < sdesccount Then
            '        lblDesc.Text = sdesc
            '        hlmore.Visible = False

            '    Else
            '        result = TruncateAtWord(sdesc, sdesccount)
            '        lblDesc.Text = result
            '        hlmore.Visible = True
            '    End If
        End If

    End Sub

    Sub getComments()
        Dim parameters() As SqlParameter = New SqlParameter() _
          {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryComments", parameters)
        rptcomments.DataSource = dt1
        rptcomments.DataBind()
    End Sub

    Sub getRelatedTheory()
        Dim parameters() As SqlParameter = New SqlParameter() _
    {
      New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
  }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetRelatedTheories", parameters)
        Dim dvData As New DataView(dt1)
        'dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        rptRelatedTheories.DataSource = dvData
        rptRelatedTheories.DataBind()
    End Sub

    Sub getAdditionalResources()
        Dim parameters() As SqlParameter = New SqlParameter() _
  {
    New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
}
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("dbo.usp_GetTheoryResources", parameters)
        Dim dvData As New DataView(dt1)
        'If Not ViewState("ARcloumn") Is Nothing And Not ViewState("ARsortorder") Is Nothing Then
        dvData.Sort = ViewState("ARcolumn") + " " + ViewState("ARsortorder")

        RptAdditonalResources.DataSource = dvData
        RptAdditonalResources.DataBind()
    End Sub

    Sub getReference()
        Dim parameters() As SqlParameter = New SqlParameter() _
     {
       New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
   }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryReferences", parameters)
        Dim dvData As New DataView(dt1)
        dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        RptReferneces.DataSource = dvData
        RptReferneces.DataBind()
    End Sub

    Sub getConstruct()
        Dim parameters() As SqlParameter = New SqlParameter() _
            {
              New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
          }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryConstructs", parameters)
        Dim dvData As New DataView(dt1)
        dvData.Sort = ViewState("ccolumn") + " " + ViewState("csortorder")
        rptConstructs.DataSource = dvData
        rptConstructs.DataBind()
    End Sub

    Sub getDiagrams()
        Dim parameters() As SqlParameter = New SqlParameter() _
            {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
            }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryModels", parameters)
        Dim dvData As New DataView(dt1)

        'If (dvData.Count > 1) Then
        '    hlAdditionalDiagrams.Visible = True
        'End If
        'If (dvData.Count > 0) Then
        '    dvData.RowFilter = "IsPrimary = true"
        '    imgPrimaryDiagram.ImageUrl = "~/Content/images/Models/" & dvData(0)("ModelImagePath")
        'End If

    End Sub

    Public Shared Function TruncateAtWord(input As String, length As Integer) As String
        If input Is Nothing OrElse input.Length < length Then
            Return input
        End If
        Dim iNextSpace As Integer = input.LastIndexOf(" ", length)
        Return String.Format("{0}...", input.Substring(0, If((iNextSpace > 0), iNextSpace, length)).Trim())
    End Function

    Protected Sub RptReferneces_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        hdTab.Value = "0"
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
        Dim queryPtid As String = Request.QueryString("TID")
        Dim dtid As Int32
        If Integer.TryParse(queryPtid, dtid) Then
            TID = dtid
            getReference()
        End If

    End Sub

    Protected Sub rptConstructs_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Header Then
            Dim lnbConstructName As LinkButton = CType(e.Item.FindControl("lnbConstructName"), LinkButton)
            Dim lnbKeyConstructFlag As LinkButton = CType(e.Item.FindControl("lnbKeyConstructFlag"), LinkButton)

            If ViewState("ccolumn").ToString() = "ConstructName" Then
                If ViewState("csortorder").ToString() = "ASC" Then
                    lnbConstructName.CssClass = "sort_up"
                Else
                    lnbConstructName.CssClass = "sort_down"
                End If
            Else
                If ViewState("csortorder").ToString() = "ASC" Then
                    lnbKeyConstructFlag.CssClass = "sort_up"
                Else
                    lnbKeyConstructFlag.CssClass = "sort_down"
                End If
            End If
        End If
        If rptConstructs.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If
    End Sub

    Protected Sub RptReferneces_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptReferneces.ItemDataBound
        Dim hlPubMed As HyperLink

        If e.Item.ItemType = ListItemType.Header Then
            Dim lnbPubYear As LinkButton = CType(e.Item.FindControl("lnbYear"), LinkButton)
            Dim lnbRelevance As LinkButton = CType(e.Item.FindControl("lnbRelevance"), LinkButton)

            If ViewState("column").ToString() = "RelevanceOrder" Then
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbRelevance.CssClass = "sort_down"
                Else
                    lnbRelevance.CssClass = "sort_up"
                End If
            Else
                If ViewState("sortorder").ToString() = "ASC" Then
                    lnbPubYear.CssClass = "sort_up"
                Else
                    lnbPubYear.CssClass = "sort_down"
                End If
            End If
        End If

        If RptReferneces.Items.Count < 1 Then
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
            hlPubMed = e.Item.FindControl("hlPubMed")

            Dim PubMedID As String = DataBinder.Eval(DI, "PubMedID").ToString()

            If String.IsNullOrEmpty(PubMedID) Then
                hlPubMed.Text = "-"
                hlPubMed.Style.Add("text-decoration", "none")
                hlPubMed.Enabled = False
            End If
    End If

    'Hyperlink Text in Citation Column
    Dim lblCitation As Label

    If (e.Item.ItemType = ListItemType.Item) Or
         (e.Item.ItemType = ListItemType.AlternatingItem) Then
      Dim DI As Object = e.Item.DataItem

      'Hyperlink Text in Citation Column
      lblCitation = e.Item.FindControl("lblCitation")
      Dim citation As String = DataBinder.Eval(DI, "Citation").ToString()
      Dim citationid As String = DataBinder.Eval(DI, "CitationID").ToString()
      Dim title As String = DataBinder.Eval(DI, "Title").ToString()

      If (citation.IndexOf(title, StringComparison.InvariantCultureIgnoreCase) > -1) Then
        Dim hltitle = String.Format("<a href={0}>{1}</a>", "Citation_details.aspx?citationid=" + citationid, title)
        citation = citation.Replace(title, hltitle)
      End If
      lblCitation.Text = citation
    End If



    End Sub

    Protected Sub rptRelatedTheories_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptRelatedTheories.ItemDataBound
        If rptRelatedTheories.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If
    End Sub

    Protected Sub RptAdditonalResources_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles RptAdditonalResources.ItemCommand
        hdTab.Value = "4"
        If e.CommandName = ViewState("ARcolumn").ToString() Then
            If ViewState("ARsortorder").ToString() = "ASC" Then
                ViewState("ARsortorder") = "DESC"
            Else
                ViewState("ARsortorder") = "ASC"
            End If
        Else
            ViewState("ARcolumn") = e.CommandName
            ViewState("ARsortorder") = "ASC"
        End If
        Dim queryPtid As String = Request.QueryString("TID")
        Dim dtid As Int32
        If Integer.TryParse(queryPtid, dtid) Then
            TID = dtid
            getAdditionalResources()
        End If
    End Sub

    Protected Sub RptAdditonalResources_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptAdditonalResources.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            Dim lnbName As LinkButton = CType(e.Item.FindControl("lnbName"), LinkButton)
            Dim lnbType As LinkButton = CType(e.Item.FindControl("lnbType"), LinkButton)

            If ViewState("ARcolumn").ToString() = "ResourceName" Then
                If ViewState("ARsortorder").ToString() = "ASC" Then
                    lnbName.CssClass = "sort_up"
                Else
                    lnbName.CssClass = "sort_down"
                End If
            Else
                If ViewState("ARsortorder").ToString() = "ASC" Then
                    lnbType.CssClass = "sort_up"
                Else
                    lnbType.CssClass = "sort_down"
                End If
            End If
        End If
        If RptAdditonalResources.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If
    End Sub

    Protected Sub rptConstructs_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        hdTab.Value = "2"
        If e.CommandName = ViewState("ccolumn").ToString() Then
            If ViewState("csortorder").ToString() = "ASC" Then
                ViewState("csortorder") = "DESC"
            Else
                ViewState("csortorder") = "ASC"
            End If
        Else
            ViewState("ccolumn") = e.CommandName
            ViewState("csortorder") = "ASC"
        End If
        Dim queryPtid As String = Request.QueryString("TID")
        Dim dtid As Int32
        If Integer.TryParse(queryPtid, dtid) Then
            TID = dtid
            getConstruct()
        End If
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
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@CommentTitle", SqlDbType.NVarChar, 600),
            New SqlParameter("@CommentText", SqlDbType.NVarChar)
        }
        parameters(0).Direction = ParameterDirection.Output
        parameters(2).Value = txtCommentTitle.Text().Trim()
        parameters(3).Value = txtCommentText.Text().Trim()

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheoryComment", parameters)
    End Sub
    Protected Sub rptTheoryModels_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If rptTheoryModels.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                Dim dvFooter As HtmlGenericControl = CType(e.Item.FindControl("diagramfooter"), HtmlGenericControl)
                lblFooter.Visible = True
                dvFooter.Visible = True
                lblfulllimg.Visible = False
            End If
        End If

        Dim img As Image
        Dim hlModel As HyperLink
        Dim lbModelDownload As LinkButton
        Dim TheoryModelID As Integer
    Dim TheoryModelDesc As String = String.Empty
    Dim TheoryModelSource As String = String.Empty


        If (e.Item.ItemType = ListItemType.Item) Or
             (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim DI As Object = e.Item.DataItem
            img = e.Item.FindControl("imgModel")
            hlModel = e.Item.FindControl("hlModel")
            lbModelDownload = e.Item.FindControl("lbModelDownload")
      TheoryModelID = DirectCast(DataBinder.Eval(DI, "TheoryModelID"), Int32)

            Dim dt1 As DataTable = GetTheoryModelByID(TheoryModelID)

            If Not dt1 Is Nothing Then
        TheoryModelDesc = dt1.Rows(0)("ModelDescription").ToString()
        TheoryModelSource = dt1.Rows(0)("ModelSource").ToString()

            End If

            If Not img Is Nothing Then
                If Not DataBinder.Eval(DI, "ModelThumbnail") Is DBNull.Value Then
                    Dim bytes As Byte() = DirectCast(DataBinder.Eval(DI, "ModelThumbnail"), Byte())
                    Dim base64String As String = Convert.ToBase64String(bytes, 0, bytes.Length)
                    img.ImageUrl = Convert.ToString("data:image/png;base64,") & base64String
          'img.AlternateText = TheoryModelDesc
                    hlModel.NavigateUrl = Convert.ToString("data:image/png;base64,") & base64String
          hlModel.Attributes.Add("title", TheoryModelDesc & "<br /> Source: " & TheoryModelSource)
          lbModelDownload.CommandName = TheoryModelID

                End If
            End If
        End If
    End Sub
    Sub getTheoryModelThumbnails()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryModelThumbnails", parameters)
        Dim dvData As New DataView(dt1)

        rptTheoryModels.DataSource = dvData
        rptTheoryModels.DataBind()
    End Sub

    Public Function GetTheoryModelByID(TheoryModelID As Integer) As DataTable
        Dim dt1 As DataTable = Nothing
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
           New SqlParameter("@TheoryModelID", SqlDbType.Int) With {.Value = TheoryModelID},
           New SqlParameter("@UserID", SqlDbType.VarChar, 100) With {.Value = Nothing}
        }
        dt1 = DataAccess.ExecuteStoredProc("usp_GetTheoryModel", parameters)
        Return dt1
    End Function
    Protected Sub lbModelDownload_Click(sender As Object, e As EventArgs)
        Dim btn As LinkButton = TryCast(sender, LinkButton)
        Dim TheoryModelID As Int32 = Convert.ToInt32(btn.CommandName)
        loadImage(TheoryModelID)
    End Sub

    Public Sub loadImage(TheoryModelID As Integer)
        Dim dt As DataTable = GetTheoryModelByID(TheoryModelID)
        ' return data from database in this function
        If dt IsNot Nothing Then
            Dim bytes As [Byte]() = DirectCast(dt.Rows(0)("ModelImage"), [Byte]())
            Response.Buffer = True
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            'Response.ContentType = dt.Rows(0)("ContentType").ToString()
            Response.AddHeader("content-disposition", "attachment;filename=modelimage.jpg")
            Response.BinaryWrite(bytes)
            Response.Flush()
            Response.[End]()
        End If
    End Sub

  Public Shared Function CreateURL(myValue As Object) As String
    If myValue Is DBNull.Value Then
      Return "No"
    Else
      Return "Yes"
      'Return "<asp:hyperlink ID=""hlgemdetails"" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, ""GEMConstructLink"")%>' " & _
      '" Target=""_blank"" runat=""server"" class=""nolink"" >Yes</asp:hyperlink>"
      'Return "<a href=<%DataBinder.Eval(Container.DataItem, ""GEMConstructLink"").ToString()}>Yes</a>"
      'Return "<a href='<%#DataBinder.Eval(Container.DataItem, ""GEMConstructLink"")%>' Target=""_blank"">Yes</a>"
    End If
    Return myValue.ToString()
  End Function

End Class
