Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.IO
Imports System.Collections.Generic
Imports System.Linq
Imports System.Net

Partial Class public_theory_edit_page
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
        If Integer.TryParse(queryPtid, dtid) Then
            TID = dtid
            hdTheoryID.Value = TID.ToString()
        End If
        If Not IsPostBack Then
            If String.IsNullOrEmpty(queryPtid) Then
                ltlmode.Text = "Add Theory"
                hlexit.NavigateUrl = "Browse-Theories.aspx"
                hdTheoryID.Value = String.Empty
            Else
                ltlmode.Text = "Edit Theory"
                hlexit.NavigateUrl = "theory_details.aspx?TID=" & TID
                getTheory()
                getReference()
                getConstruct()
                getRelatedTheories()
                getAdditionalResources()
                getTheoryModelThumbnails()
            End If
            flUploadModel.Attributes("onchange") = "setUploadModelPath(this)"
            cbUseConstructName.Attributes.Add("onclick", "return warnChangeOrigGem();")
            BindPubTypeFilterDropDown()
            BindRelationTheories()
            BindResourceType()
        End If

    End Sub
    Sub BindPubTypeFilterDropDown()
        Dim parameters() As SqlParameter = {}
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPubTypeList", parameters)
        ddlPubType_filter.DataSource = dt1.DefaultView
        ddlPubType_filter.DataBind()
    End Sub

    Sub BindRelationTheories()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPossibleRelatedTheories", parameters)
        ddlRelationTheories.DataSource = dt1.DefaultView
        ddlRelationTheories.DataBind()
    End Sub

    Sub BindResourceType()
        Dim parameters() As SqlParameter = {}
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResourceTypeList", parameters)
        ddlResourceType.DataSource = dt1.DefaultView
        ddlResourceType.DataBind()
    End Sub

    Sub getTheory()
        Dim parameters() As SqlParameter = New SqlParameter() _
      {
        New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
    }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheory", parameters)
        If Not dt1 Is Nothing Then
            lbltitle.Text = dt1.Rows(0)("TheoryName").ToString()
            txtname.Text = dt1.Rows(0)("TheoryName").ToString()
            txtdesc.Text = dt1.Rows(0)("TheoryDescription").ToString()
            lblyear.Text = dt1.Rows(0)("YearPublished").ToString()
        End If
    End Sub

    Sub getReference()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
        }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryReferences", parameters)
        Dim dvData As New DataView(dt1)
        'dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        RptReferences.DataSource = dvData
        RptReferences.DataBind()
    End Sub

    Sub getConstruct()
        Dim parameters() As SqlParameter = New SqlParameter() _
            {
              New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
          }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryConstructs", parameters)
        Dim dvData As New DataView(dt1)
        'dvData.Sort = ViewState("column") + " " + ViewState("sortorder")
        rptConstructs.DataSource = dvData
        rptConstructs.DataBind()
    End Sub

    Sub getRelatedTheories()
        Dim parameters() As SqlParameter = New SqlParameter() _
            {
              New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
          }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetRelatedTheories", parameters)
        Dim dvData As New DataView(dt1)
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
        rptAdditonalResources.DataSource = dvData
        rptAdditonalResources.DataBind()
    End Sub

    Sub saveTheory()
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int),
            New SqlParameter("@TheoryName", SqlDbType.NVarChar) With {.Value = txtname.Text},
            New SqlParameter("@TheoryDesc", SqlDbType.NVarChar) With {.Value = txtdesc.Text}
        }
        parameters(0).Direction = ParameterDirection.InputOutput
        If TID = 0 Then
            parameters(0).Value = DBNull.Value
        Else
            parameters(0).Value = TID
        End If

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheory", parameters)
        hdTheoryID.Value = parameters(0).Value
    End Sub

    Protected Sub btnsubmit1_Click(sender As Object, e As EventArgs) Handles btnsubmit1.Click
        saveTheory()
    End Sub

    Protected Sub btncancel1_Click(sender As Object, e As EventArgs) Handles btncancel1.Click
        Dim queryPtid As String = Request.QueryString("TID")
        If String.IsNullOrEmpty(queryPtid) Then
            Response.Redirect("browse-theories.aspx")
        Else
            Response.Redirect("theory_details.aspx?TID=" & TID)
        End If
    End Sub

    Protected Sub RptReferences_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If (e.CommandName = "DeleteThis") Then
            DeleteReference(e.CommandArgument)
            getReference()
        End If
    End Sub

    Protected Sub btnAddReference_Click(sender As Object, e As EventArgs)

        AddReference()
        ''getReference()
        ''resetAddReference()

        'CheckCitation()

        hdTab.Value = "0"
        Response.Redirect("theory-edit-page.aspx?at=0&TID=" & TID)

    End Sub
    Protected Sub txtCitation_TextChanged(sender As Object, e As EventArgs)

        If txtPubMedID.Text.Trim() = "" AndAlso txtCitation.Text.Trim() <> "" Then
            Dim responseFromServer As String = postData()
            parseXML(responseFromServer)
            hdTab.Value = "0"
            Me.txtTitle.Focus()
        End If

    End Sub

    Protected Function postData() As String
        Dim input As String = String.Empty
        Dim responseFromServer As String = String.Empty
        Dim url As String = "http://freecite.library.brown.edu/citations/create"
        Try
            input = txtCitation.Text.Trim()
            input = Replace(input, Chr(13) & Chr(10), " ")
            input = input.Replace(vbCrLf, " ")

            If Not String.IsNullOrEmpty(input) Then
                Dim request As HttpWebRequest = DirectCast(WebRequest.Create(url), HttpWebRequest)
                ' Set the Method property of the request to POST.
                request.Method = "POST"
                request.Accept = "text/xml"
                Dim postData1 As String = Convert.ToString("citation=") & input
                Dim byteArray As Byte() = Encoding.UTF8.GetBytes(postData1)

                request.ContentLength = byteArray.Length

                Using dataStream As Stream = request.GetRequestStream()
                    dataStream.Write(byteArray, 0, byteArray.Length)
                End Using


                Dim response As WebResponse = request.GetResponse()
                'lblStatus.Text = CInt(DirectCast(response, HttpWebResponse).StatusCode).ToString()

                Dim resdataStream = response.GetResponseStream()

                Dim reader As New StreamReader(resdataStream)
                responseFromServer = reader.ReadToEnd()

                'lblCitation.Text = responseFromServer

                reader.Close()
                resdataStream.Close()
                response.Close()
            Else
                'lblStatus.Text = "Error: Invalid Input"
            End If
        Catch ex As Exception
            'lblStatus.Text = "Error: " + ex.Message
        End Try
        Return responseFromServer
    End Function

    Protected Sub parseXML(responsefromserver As String)
        Dim xmlDoc As XDocument = XDocument.Parse(responsefromserver)

        Dim eCitation As XElement = xmlDoc.Descendants("citation").[Single]()

        'check if Valid
        Dim isvalid As String = eCitation.Attribute("valid").Value
        'lblIsValid.Text = isvalid

        If (eCitation.Descendants("title").[SingleOrDefault]()) IsNot Nothing Then
            'get Title
            Dim title As String = eCitation.Descendants("title").[SingleOrDefault]().Value
            txtTitle.Text = title

            ''get Authors
            'Dim authors As New List(Of String)()
            'Dim XEauthors As List(Of XElement) = eCitation.Descendants("authors").[SingleOrDefault]().Descendants("author").ToList()
            'For Each author As Object In XEauthors
            '    authors.Add(author.Value)
            'Next
            'txtAuthor.Text = String.Join("; ", authors)

            'get journal
            'Dim xeJournal As XElement = eCitation.Descendants("journal").FirstOrDefault()
            'If xeJournal IsNot Nothing Then
            '    txtJournal.Text = xeJournal.Value
            'End If

            'get volume
            Dim xeVolume As XElement = eCitation.Descendants("volume").FirstOrDefault()
            If xeVolume IsNot Nothing Then
                '.Text = xeVolume.Value
            End If

            'get pages
            Dim xePages As XElement = eCitation.Descendants("pages").FirstOrDefault()
            If xePages IsNot Nothing Then
                'lblPages.Text = xePages.Value
            End If

            'get year
            Dim xeYear As XElement = eCitation.Descendants("year").FirstOrDefault()
            If xeYear IsNot Nothing Then
                txtPubYear.Text = xeYear.Value
            End If

            'get publisher
            Dim xePublisher As XElement = eCitation.Descendants("publisher").FirstOrDefault()
            If xePublisher IsNot Nothing Then
                'txtpub.Text = xePublisher.Value
            End If
        End If
    End Sub

    Sub CheckCitation()


        Dim title As String = txtTitle.Text
        Dim yearpublished As Int32 = Convert.ToInt32(txtPubYear.Text)
        Dim pubmedid As String = txtPubMedID.Text

        Dim Chkparameters() As SqlParameter = New SqlParameter() _
        {
           New SqlParameter("@Title", SqlDbType.NVarChar, 1000) With {.Value = title},
           New SqlParameter("@YearPublished", SqlDbType.SmallInt) With {.Value = yearpublished},
           New SqlParameter("@PubMedID", SqlDbType.VarChar, 50)
        }

        If String.IsNullOrEmpty(pubmedid) Then
            Chkparameters(2).Value = DBNull.Value
        Else
            Chkparameters(2).Value = pubmedid
        End If

        If (DataAccess.ExecuteStoredProc("usp_CheckCitationDuplicates", Chkparameters) IsNot Nothing) Then
            Me.plDups.Visible = True
            Me.plAddRef.Visible = False
        Else
            AddReference()
            Me.plDups.Visible = False
            getReference()

        End If

    End Sub

    Sub AddReference()
        Dim citation As String = txtCitation.Text().Trim
        citation = Replace(citation, Chr(13) & Chr(10), " ")
        citation = citation.Replace(vbCrLf, " ")

        Dim relevanceID As Int32 = Convert.ToInt32(ddlRelevance.SelectedValue)
        Dim PubTypeID As String = ddlPubType_filter.SelectedValue
        'Dim PubTypeID As Int32 = Convert.ToInt32(ddlPubType_filter.SelectedValue)    
        Dim title As String = txtTitle.Text
        Dim yearpublished As Int32 = Convert.ToInt32(txtPubYear.Text)
        Dim pubmedid As String = txtPubMedID.Text


        Dim parameters() As SqlParameter = New SqlParameter() _
        {
           New SqlParameter("@TheoryReferenceID", SqlDbType.Int),
           New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
           New SqlParameter("@Citation", SqlDbType.NVarChar, 1000) With {.Value = citation},
           New SqlParameter("@YearPublished", SqlDbType.SmallInt) With {.Value = yearpublished},
           New SqlParameter("@PubMedID", SqlDbType.VarChar, 50),
           New SqlParameter("@Title", SqlDbType.NVarChar, 1000) With {.Value = title},
           New SqlParameter("@RelevanceID", SqlDbType.Int) With {.Value = relevanceID},
           New SqlParameter("@PubTypeID", SqlDbType.Int)
        }
        parameters(0).Direction = ParameterDirection.Output
        If String.IsNullOrEmpty(pubmedid) Then
            parameters(4).Value = DBNull.Value
        Else
            parameters(4).Value = pubmedid
        End If

        If String.IsNullOrEmpty(PubTypeID) Then
            parameters(7).Value = DBNull.Value
        Else
            parameters(7).Value = Convert.ToInt32(PubTypeID)
        End If

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheoryReference", parameters)



    End Sub

    Protected Sub rptConstructs_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If rptConstructs.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True

            End If
        End If

    End Sub

    Protected Sub rptConstructs_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptConstructs.ItemCommand
        resetRptConstruct()

        Dim item As RepeaterItem = e.Item
        Dim lnk_Edit As LinkButton = CType(e.Item.FindControl("lnk_Edit"), LinkButton)
        Dim lnk_Delete As LinkButton = CType(e.Item.FindControl("lnk_Delete"), LinkButton)
        Dim delete_actions As HtmlGenericControl = CType(e.Item.FindControl("delete_actions"), HtmlGenericControl)
        Dim lblConstructName As Label = CType(e.Item.FindControl("lblConstruct"), Label)
        Dim lblConstructDefinition As Label = CType(e.Item.FindControl("lblConstructDesc"), Label)
        Dim lblGEMConstructID As Label = CType(e.Item.FindControl("lblGEMConstructID"), Label)

        If (e.CommandName = "EditThis") Then
            lnk_Edit.Visible = False
            lnk_Delete.Visible = True
            delete_actions.Visible = True

            'Change add construct to edit construct, load textboxes with values from db for editing
            Me.lblConstructMode.Text = "Edit Construct"
            Me.txtConstructName.Text = lblConstructName.Text
            Me.txtConstructDesc.Text = lblConstructDefinition.Text
            Me.lblGEMConstructID.Text = lblGEMConstructID.Text
            Me.hdnCID.Value = e.CommandArgument
            cbUseConstructName.Checked = False

            'The "Use GEM Construct name and definition" checkbox should be deactivated if there is not a [GEMConstructID] associate with the construct being edited.
            If lblGEMConstructID.Text = "" Then
                cbUseConstructName.Enabled = False
            Else
                getOriginalGEMbyID(lblGEMConstructID.Text)
                cbUseConstructName.Enabled = True
            End If

            btnConstructSubmit.Focus()

        ElseIf (e.CommandName = "DeleteThis") Then
            lnk_Edit.Visible = True
            lnk_Delete.Visible = False
            delete_actions.Visible = False
            DeleteConstruct(e.CommandArgument)
            'Reset other delete buttons
            getConstruct()
            resetAddConstruct()
        End If

    End Sub

    <WebMethod>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Shared Function GetConstructNames(prefixText As String, count As Int32) As List(Of String)
        Dim allConstructName As New List(Of String)()
        Dim construct As String = String.Empty
        Dim parameters() As SqlParameter = New SqlParameter() _
         {
             New SqlParameter("@ConstructName", SqlDbType.VarChar, 250) With {.Value = prefixText}
         }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_LookupConstructByName", parameters)

        If Not dt1 Is Nothing And dt1.Rows.Count > 0 Then
            For index = 0 To dt1.Rows.Count - 1
                construct = dt1.Rows(index)("ConstructName").ToString()
                allConstructName.Add(construct)
            Next
        End If

        Return allConstructName
    End Function

    Protected Sub hdnValue_ValueChanged(sender As Object, e As EventArgs)
        Dim constructNameGEM As String = DirectCast(sender, HiddenField).Value
        getOriginalGEM(constructNameGEM)
    End Sub

    Protected Sub btnConstructSubmit_Click(sender As Object, e As EventArgs) Handles btnConstructSubmit.Click
        AddConstruct()
        Response.Redirect("theory-edit-page.aspx?at=2&TID=" & TID)
    End Sub

    Sub resetRptConstruct()
        For Each construct As Control In rptConstructs.Controls
            If construct.FindControl("lnk_Delete") IsNot Nothing Then
                Dim lnk_Edit As LinkButton = CType(construct.FindControl("lnk_Edit"), LinkButton)
                Dim lnk_Delete As LinkButton = CType(construct.FindControl("lnk_Delete"), LinkButton)
                Dim delete_actions As HtmlGenericControl = CType(construct.FindControl("delete_actions"), HtmlGenericControl)
                lnk_Edit.Visible = True
                lnk_Delete.Visible = False
                delete_actions.Visible = False
            End If
        Next
    End Sub

    Sub getOriginalGEM(ByVal constructNameGEM As String)
        Dim constructName As String = ""
        If Not String.IsNullOrWhiteSpace(constructNameGEM) Then
            constructName = constructNameGEM.Replace("(GEM)", "").Trim()
        End If
        Dim constructDesc As String = String.Empty
        Dim GEMconstructID As String = String.Empty
        Dim parameters() As SqlParameter = New SqlParameter() _
         {
             New SqlParameter("@ConstructName", SqlDbType.VarChar, 250) With {.Value = constructName}
         }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_LookupConstructByName", parameters)

        If Not dt1 Is Nothing And dt1.Rows.Count > 0 Then
            constructDesc = dt1.Rows(0)("ConstructDefinition").ToString()
            GEMconstructID = dt1.Rows(0)("GEMConstructID").ToString()
        End If

        If Not String.IsNullOrEmpty(GEMconstructID) Then
            txtConstructName.Text = constructNameGEM
            txtConstructDesc.Text = constructDesc
            lblGEMConstructID.Text = GEMconstructID
            txtConstructDesc.ReadOnly = True
            txtConstructName.ReadOnly = True
            cbUseConstructName.Enabled = True
            cbUseConstructName.Checked = True
            'Save the default GEM name & desc, values will be used for comparison when user edit
            hdnCName.Value = constructNameGEM
            hdnCDesc.Value = constructDesc
        Else
            'The "Use GEM Construct name and definition" checkbox should be deactivated if there is not a [GEMConstructID] associate with the construct being added.
            cbUseConstructName.Enabled = False
            cbUseConstructName.Checked = False
        End If
    End Sub

    Sub getOriginalGEMbyID(ByVal gemID As String)

        Dim parameters() As SqlParameter = New SqlParameter() _
         {
             New SqlParameter("@GEMConstructID", SqlDbType.Int) With {.Value = gemID}
         }
        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetGEMConstruct", parameters)

        If Not dt1 Is Nothing And dt1.Rows.Count > 0 Then
            'Save the default GEM name & desc, values will be used for comparison when user edit
            hdnCName.Value = dt1.Rows(0)("ConstructName").ToString()
            hdnCDesc.Value = dt1.Rows(0)("Definition").ToString()
        End If
    End Sub

    Sub resetAddReference()
        Me.txtPubMedID.Text = ""
        Me.txtCitation.Text = ""
        Me.txtTitle.Text = ""
        Me.txtPubYear.Text = ""
        Me.ddlPubType_filter.SelectedValue = ""
        Me.ddlRelevance.SelectedValue = ""
    End Sub

    Sub resetAddConstruct()
        Me.lblConstructMode.Text = "Add Construct"
        Me.txtConstructName.Text = ""
        Me.txtConstructDesc.Text = ""
        Me.cbUseConstructName.Checked = False
        Me.lblGEMConstructID.Text = ""
    End Sub

    Sub resetAddRelation()
        Me.ddlRelationTheories.SelectedValue = ""
        Me.txtRelationComment.Text = ""
    End Sub

    Sub resetAddResource()
        Me.txtResourceName.Text = ""
        Me.txtResourceURL.Text = ""
        Me.txtResourceDesc.Text = ""
        Me.ddlResourceType.SelectedValue = ""
    End Sub

    Sub AddConstruct()
        Dim constructName As String = Me.txtConstructName.Text
        Dim constructDesc As String = Me.txtConstructDesc.Text
        Dim sGEMConstructID As String = Me.lblGEMConstructID.Text
        Dim constructID As String = Me.hdnCID.Value

        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@ConstructID", SqlDbType.Int),
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@ConstructName", SqlDbType.NVarChar, 350) With {.Value = constructName},
            New SqlParameter("@ConstructDesc", SqlDbType.NVarChar) With {.Value = constructDesc},
            New SqlParameter("@GEMConstructID", SqlDbType.Int)
        }

        If String.IsNullOrEmpty(constructID) Then
            parameters(0).Direction = ParameterDirection.Output
            parameters(0).Value = DBNull.Value
        Else
            parameters(0).Value = Integer.Parse(constructID)
        End If

        If String.IsNullOrEmpty(sGEMConstructID) Then
            parameters(4).Value = DBNull.Value
        Else
            parameters(4).Value = Integer.Parse(sGEMConstructID)
        End If

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheoryConstruct", parameters)
    End Sub

    Sub AddRelatedTheory()
        Dim relatedTheoryID As String = Me.ddlRelationTheories.SelectedValue
        Dim comments As String = Me.txtRelationComment.Text
        If Not String.IsNullOrEmpty(relatedTheoryID) Then
            Dim parameters() As SqlParameter = New SqlParameter() _
                    {
                        New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
                        New SqlParameter("@RelatedTheoryID", SqlDbType.Int) With {.Value = relatedTheoryID},
                        New SqlParameter("@Comment", SqlDbType.NVarChar, 500) With {.Value = comments}
                    }
            parameters(1).Value = Integer.Parse(relatedTheoryID)
            DataAccess.ExecuteNonQueryStoredProc("usp_SaveRelatedTheory", parameters)
        End If
    End Sub

    Sub AddResource()
        Dim resourceName As String = Me.txtResourceName.Text
        Dim resourceURL As String = Me.txtResourceURL.Text
        Dim resourceDesc As String = Me.txtResourceDesc.Text
        Dim resourceType As String = Me.ddlResourceType.SelectedValue
        Dim resourceID As String = Me.hdnValueResourceURL.Value

        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@ResourceID", SqlDbType.Int),
            New SqlParameter("@ResourceName", SqlDbType.NVarChar, 500) With {.Value = resourceName},
            New SqlParameter("@ResourceURL", SqlDbType.NVarChar, 1000) With {.Value = resourceURL},
            New SqlParameter("@ResourceDesc", SqlDbType.NVarChar) With {.Value = resourceDesc},
            New SqlParameter("@ResourceTypeID", SqlDbType.Int),
            New SqlParameter("@UserID", SqlDbType.NVarChar, 75)
        }

        If String.IsNullOrEmpty(resourceID) Then
            parameters(1).Value = DBNull.Value
        Else
            parameters(1).Value = Integer.Parse(resourceID)
        End If

        If String.IsNullOrEmpty(resourceType) Then
            parameters(5).Value = DBNull.Value
        Else
            parameters(5).Value = Integer.Parse(resourceType)
        End If

        parameters(6).Value = DBNull.Value

        DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheoryResource", parameters)
    End Sub

    Sub DeleteReference(ByVal cID As Integer)
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@CitationID", SqlDbType.Int) With {.Value = cID}
        }
        DataAccess.ExecuteNonQueryStoredProc("usp_DeleteTheoryReference", parameters)
    End Sub

    Sub DeleteConstruct(ByVal cID As Integer)
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@ConstructID", SqlDbType.Int) With {.Value = cID},
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID}
        }
        DataAccess.ExecuteNonQueryStoredProc("usp_DeleteTheoryConstruct", parameters)
    End Sub

    Sub DeleteRelatedTheory(ByVal relatedTID As Integer)
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@RelatedTheoryID", SqlDbType.Int) With {.Value = relatedTID}
        }
        DataAccess.ExecuteNonQueryStoredProc("usp_DeleteRelatedTheory", parameters)
    End Sub

    Sub DeleteTheoryResource(ByVal resourceID As Integer)
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
            New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
            New SqlParameter("@ResourceID", SqlDbType.Int) With {.Value = resourceID}
        }
        DataAccess.ExecuteNonQueryStoredProc("usp_DeleteTheoryResource", parameters)
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

    Protected Sub btnModelUpload_Click(sender As Object, e As EventArgs)
        Dim bytes As Byte() = Nothing
        Dim postedFile As HttpPostedFile = flUploadModel.PostedFile
        Dim fileName As String = Path.GetFileName(postedFile.FileName)
        Dim fileExtension As String = Path.GetExtension(fileName)

        Dim fileSize As Int32 = postedFile.ContentLength

        If fileExtension.ToLower().Equals(".jpg") Or fileExtension.ToLower().Equals(".png") Or fileExtension.ToLower().Equals(".bmp") Then
            Dim stream As Stream = postedFile.InputStream
            Dim binaryReader As BinaryReader = New BinaryReader(stream)
            bytes = binaryReader.ReadBytes(stream.Length)

            Dim ModelDesc As String = txtModelDesc.Text().Trim()
            Dim ModelSource As String = txtModelSource.Text().Trim()

            Dim parameters() As SqlParameter = New SqlParameter() _
           {
               New SqlParameter("@TheoryModelID", SqlDbType.Int),
               New SqlParameter("@TheoryID", SqlDbType.Int) With {.Value = TID},
               New SqlParameter("@ModelImage", SqlDbType.VarBinary) With {.Value = bytes},
               New SqlParameter("@ModelThumbnail", SqlDbType.VarBinary) With {.Value = bytes},
               New SqlParameter("@UserID", SqlDbType.VarChar, 100) With {.Value = Nothing},
               New SqlParameter("@ModelDescription", SqlDbType.NVarChar, 500) With {.Value = ModelDesc},
               New SqlParameter("@ModelSourceCredit", SqlDbType.NVarChar, 500) With {.Value = ModelSource}
           }
            parameters(0).Direction = ParameterDirection.Output

            DataAccess.ExecuteNonQueryStoredProc("usp_SaveTheoryModel", parameters)
            Response.Redirect("theory-edit-page.aspx?at=1&TID=" & TID)
        End If
    End Sub
    Protected Sub rptTheoryModels_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If rptTheoryModels.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                Dim dvFooter As HtmlGenericControl = CType(e.Item.FindControl("diagramfooter"), HtmlGenericControl)
                lblFooter.Visible = True
                dvFooter.Visible = True
            End If
        End If

        Dim img As Image
        If (e.Item.ItemType = ListItemType.Item) Or
             (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim DI As Object = e.Item.DataItem
            img = e.Item.FindControl("imgModel")
            If Not img Is Nothing Then
                If Not DataBinder.Eval(DI, "ModelThumbnail") Is DBNull.Value Then
                    Dim bytes As Byte() = DirectCast(DataBinder.Eval(DI, "ModelThumbnail"), Byte())
                    Dim base64String As String = Convert.ToBase64String(bytes, 0, bytes.Length)
                    img.ImageUrl = Convert.ToString("data:image/png;base64,") & base64String
                End If
            End If
        End If
    End Sub

    Protected Sub rptTheoryModels_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        Dim TheoryModelID As Int32 = Convert.ToInt32(e.CommandName)

        Dim parameters() As SqlParameter = New SqlParameter() _
         {
             New SqlParameter("@TheoryModelID", SqlDbType.Int) With {.Value = TheoryModelID}
         }

        DataAccess.ExecuteNonQueryStoredProc("usp_DeleteTheoryModel", parameters)
        Response.Redirect("theory-edit-page.aspx?at=1&TID=" & TID)
    End Sub



    Protected Sub rptRelatedTheories_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptRelatedTheories.ItemCommand
        If (e.CommandName = "DeleteThis") Then
            DeleteRelatedTheory(e.CommandArgument)
            getRelatedTheories()
        End If
    End Sub

    Protected Sub rptRelatedTheories_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptRelatedTheories.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item) Or (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim lnk_Delete As LinkButton = CType(e.Item.FindControl("lnk_Delete"), LinkButton)
            Dim delete_actions As HtmlGenericControl = CType(e.Item.FindControl("delete_actions"), HtmlGenericControl)
            Dim DI As Object = e.Item.DataItem
            If Not DataBinder.Eval(DI, "Relationship") Is DBNull.Value Then
                If DataBinder.Eval(DI, "Relationship").ToString = "User-specified" Then
                    lnk_Delete.Visible = True
                    delete_actions.Visible = True
                Else
                    lnk_Delete.Visible = False
                    delete_actions.Visible = False
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
    End Sub

    Protected Sub btnRelationSave_Click(sender As Object, e As EventArgs) Handles btnRelationSave.Click
        AddRelatedTheory()
        'getRelatedTheories()
        'resetAddRelation()
        Response.Redirect("theory-edit-page.aspx?at=3&TID=" & TID)
    End Sub

    Protected Sub rptAdditonalResources_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptAdditonalResources.ItemCommand
        If (e.CommandName = "DeleteThis") Then
            DeleteTheoryResource(e.CommandArgument)
            getAdditionalResources()
        End If
    End Sub

    Protected Sub btnResourceSave_Click(sender As Object, e As EventArgs) Handles btnResourceSave.Click
        AddResource()
        'getAdditionalResources()
        'resetAddResource()
        Response.Redirect("theory-edit-page.aspx?at=4&TID=" & TID)

    End Sub

    Protected Sub hdnValueResourceURL_ValueChanged(sender As Object, e As EventArgs) Handles hdnValueResourceURL.ValueChanged

    End Sub

    Protected Sub RptReferences_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptReferences.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item) Or
             (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim DI As Object = e.Item.DataItem

            'Hyperlink Text in Citation Column
            Dim lblCitation As Label = CType(e.Item.FindControl("lblCitation"), Label)
            Dim citation As String = DataBinder.Eval(DI, "Citation").ToString()
            Dim citationid As String = DataBinder.Eval(DI, "CitationID").ToString()
            Dim title As String = DataBinder.Eval(DI, "Title").ToString()
            Dim hlPubMed As HyperLink = CType(e.Item.FindControl("hlPubMed"), HyperLink)

            If (citation.IndexOf(title, StringComparison.InvariantCultureIgnoreCase) > -1) Then
                Dim hltitle = String.Format("<a href={0}>{1}</a>", "Citation_details.aspx?citationid=" + citationid, title)
                citation = citation.Replace(title, hltitle)
            End If
            lblCitation.Text = citation

            Dim PubMedID As String = DataBinder.Eval(DI, "PubMedID").ToString()

            If String.IsNullOrEmpty(PubMedID) Then
                hlPubMed.Text = "-"
                hlPubMed.Style.Add("text-decoration", "none")
                hlPubMed.Enabled = False
            End If
        End If
        If RptReferences.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True

            End If
        End If
    End Sub

    Protected Sub rptAdditonalResources_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptAdditonalResources.ItemDataBound
        If rptAdditonalResources.Items.Count < 1 Then
            If e.Item.ItemType = ListItemType.Footer Then
                Dim trFooter As Control = e.Item.FindControl("tremptydata")
                Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
                lblFooter.Visible = True
                trFooter.Visible = True
            End If
        End If
    End Sub

    'Protected Sub btncancel2_Click(sender As Object, e As EventArgs)

    'End Sub
    Protected Sub btnConstructCancel_Click(sender As Object, e As EventArgs) Handles btnConstructCancel.Click
        Response.Redirect("theory-edit-page.aspx?at=2&TID=" & TID)
    End Sub
    'Protected Sub btnResourceCancel_Click(sender As Object, e As EventArgs) Handles btnResourceCancel.Click
    '    resetAddResource()
    'End Sub
    'Protected Sub btnRelationCancel_Click(sender As Object, e As EventArgs) Handles btnRelationCancel.Click
    '    resetAddRelation()
    'End Sub
End Class