Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Linq
Imports System.Net
Partial Class public_Citation_edit
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

        Dim dtid As Int32
        Dim queryPcid As String = Request.QueryString("CitationID")
        If Integer.TryParse(queryPcid, dtid) Then
            CitationID = dtid
            hdTheoryID.Value = CitationID.ToString()
        End If
        If Not IsPostBack Then
            If String.IsNullOrEmpty(queryPcid) Then
                ltlmode.Text = "Add Citation"
                hlexit.NavigateUrl = "Bibliography.aspx"
                hdTheoryID.Value = String.Empty
                hlexit.Text = "Exit Add Mode"
            Else
                hlexit.NavigateUrl = "Citation_details.aspx?citationid=" & CitationID
                hlexit.Text = "Exit Edit Mode"
                getCitation()
            End If
            BindPubTypeFilterDropDown()
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
            txtTitle.Text = dt1.Rows(0)("Title").ToString()
            txtCitation.Text = dt1.Rows(0)("Citation").ToString()
            txtPubYear.Text = dt1.Rows(0)("YearPublished").ToString()

            txtAuthor.Text = dt1.Rows(0)("Authors").ToString()

            ddlPubType_filter.Text = dt1.Rows(0)("pubTypeId").ToString()


            txtAvOnline.Text = dt1.Rows(0)("ResourceURL").ToString()

            txtPubMedID.Text = dt1.Rows(0)("PubMedID").ToString()
            'txtPubMedID.NavigateUrl = "http://www.ncbi.nlm.nih.gov/pubmed/" + dt1.Rows(0)("PubMedID").ToString()

            txtDOI.Text = dt1.Rows(0)("DOI").ToString()
            'txtDOI.NavigateUrl = "https://doi.org/" + dt1.Rows(0)("DOI").ToString()
            lbltitle.Text = dt1.Rows(0)("Title").ToString()

        End If

    End Sub
    Sub BindPubTypeFilterDropDown()
        Dim parameters() As SqlParameter = {}

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPubTypeList", parameters)

        ddlPubType_filter.DataSource = dt1.DefaultView
        ddlPubType_filter.DataBind()

    End Sub
    Protected Sub txtCitation_TextChanged(sender As Object, e As EventArgs)
        Dim responseFromServer As String = postData()
        parseXML(responseFromServer)
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

            'get Authors
            Dim authors As New List(Of String)()
            Dim XEauthors As List(Of XElement) = eCitation.Descendants("authors").[SingleOrDefault]().Descendants("author").ToList()
            For Each author As Object In XEauthors
                authors.Add(author.Value)
            Next
            txtAuthor.Text = String.Join("; ", authors)

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
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        SaveCitation()
        'Response.Redirect("Citation-details.aspx?citationid=" & CitationID)
    End Sub

    Sub SaveCitation()

    Dim citation As String = txtCitation.Text().Trim
    citation = Replace(citation, Chr(13) & Chr(10), " ")
    citation = citation.Replace(vbCrLf, " ")

        Dim yearpublished As String = Convert.ToInt32(txtPubYear.Text().Trim)
        Dim citationTitle As String = txtTitle.Text().Trim
        Dim Authors As String = txtAuthor.Text()
        Dim publicationtype As Integer = Integer.Parse(ddlPubType_filter.SelectedValue)
        Dim Availableonline As String = txtAvOnline.Text()
        Dim pubmedid As String = txtPubMedID.Text()
        Dim doi As String = txtDOI.Text()
        '      usp_SaveCitation '
        '@CitationID int output,
        '@Citation nvarchar(max),
        '@YearPublished int,
        '@PubTypeID int = null,
        '@Title nvarchar(1000) = null,
        '@Authors nvarchar(750) = null,
        '@PubMedID varchar(50) = null,
        '@DOI varchar(50) = null,
        '@URL nvarchar(500) = null,
        '@UserID varchar(100) = null
        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@CitationID", SqlDbType.Int),
          New SqlParameter("@Citation", SqlDbType.NVarChar) With {.Value = citation},
          New SqlParameter("@YearPublished", SqlDbType.Int) With {.Value = yearpublished},
          New SqlParameter("@PubTypeID", SqlDbType.Int) With {.Value = publicationtype},
          New SqlParameter("@Title", SqlDbType.NVarChar, 1000) With {.Value = citationTitle},
          New SqlParameter("@Authors", SqlDbType.NVarChar, 750) With {.Value = Authors},
          New SqlParameter("@PubMedID", SqlDbType.NVarChar, 50) With {.Value = pubmedid},
         New SqlParameter("@DOI", SqlDbType.NVarChar, 50) With {.Value = doi},
          New SqlParameter("@URL", SqlDbType.NVarChar, 500) With {.Value = Availableonline}
        }

        If CitationID = 0 Then
            parameters(0).Direction = ParameterDirection.Output
            parameters(0).Value = DBNull.Value
        Else
            parameters(0).Value = Integer.Parse(citationid)
        End If
        Dim cid As String = DataAccess.ExecuteNonQueryStoredProc_returnOutputParameter("usp_SaveCitation", "@CitationID", parameters)
        Response.Redirect("Citation_details.aspx?citationid=" & cid)
    End Sub

    Protected Sub btncancel1_Click(sender As Object, e As EventArgs)
        Dim queryPtid As String = Request.QueryString("CitationID")
        If String.IsNullOrEmpty(queryPtid) Then
            Response.Redirect("Bibliography.aspx")
        Else
            Response.Redirect("Citation_details.aspx?citationid=" & CitationID)
        End If
    End Sub
End Class
