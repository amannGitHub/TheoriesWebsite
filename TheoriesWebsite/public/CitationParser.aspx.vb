

Imports System.Collections.Generic
    Imports System.IO
    Imports System.Linq
    Imports System.Net
    Imports System.Text
    Imports System.Web
    Imports System.Web.UI
    Imports System.Web.UI.WebControls
    Imports System.Xml
    Imports System.Xml.Linq

Partial Class public_CitationParser
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs)

        End Sub

        Protected Sub btnParse_Click(sender As Object, e As EventArgs)
        Dim testXML As String = "<citations> " & vbCr & vbLf & "                                        <citation valid='true'>" & vbCr & vbLf & "                                        <authors><author>A Albada</author><author>M Ausems</author><author>J Bensing</author><author>van_Dulmen S 2009</author></authors>" & vbCr & vbLf & "                                        <title>Tailored information about cancer risk and screening: A systematic review</title>" & vbCr & vbLf & "                                        <journal>Patient Educ. Couns</journal>" & vbCr & vbLf & "                                        <volume>77</volume>" & vbCr & vbLf & "                                        <pages>155--171</pages>" & vbCr & vbLf & "                                        <year>2009</year>" & vbCr & vbLf & "                                        <raw_string>Albada A, Ausems M, Bensing J, van Dulmen S. 2009. Tailored information about cancer risk and screening: A systematic review. Patient Educ. Couns. 77: 155-171, 2009.</raw_string>" & vbCr & vbLf & "                                        </citation> " & vbCr & vbLf & "                               </citations>"
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

      'input = input.TrimEnd(Convert.ToChar(Keys.Return), Convert.ToChar(Keys.LineFeed))


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
                    lblStatus.Text = CInt(DirectCast(response, HttpWebResponse).StatusCode).ToString()

                    Dim resdataStream = response.GetResponseStream()

                    Dim reader As New StreamReader(resdataStream)
                    responseFromServer = reader.ReadToEnd()

                    lblCitation.Text = responseFromServer

                    reader.Close()
                    resdataStream.Close()
                    response.Close()
                Else
                    lblStatus.Text = "Error: Invalid Input"
                End If
            Catch ex As Exception
                lblStatus.Text = "Error: " + ex.Message
            End Try
            Return responseFromServer
        End Function

        Protected Sub parseXML(responsefromserver As String)
            Dim xmlDoc As XDocument = XDocument.Parse(responsefromserver)

            Dim eCitation As XElement = xmlDoc.Descendants("citation").[Single]()

            'check if Valid
            Dim isvalid As String = eCitation.Attribute("valid").Value
            lblIsValid.Text = isvalid

            'get Title
            Dim title As String = eCitation.Descendants("title").[Single]().Value
            lblTitle.Text = title

            'get Authors
            Dim authors As New List(Of String)()
            Dim XEauthors As List(Of XElement) = eCitation.Descendants("authors").[Single]().Descendants("author").ToList()
        For Each author As Object In XEauthors
            authors.Add(author.Value)
        Next
        lblAuthors.Text = String.Join("<br />", authors)

            'get journal
            Dim xeJournal As XElement = eCitation.Descendants("journal").FirstOrDefault()
            If xeJournal IsNot Nothing Then
                lblJournal.Text = xeJournal.Value
            End If

            'get volume
            Dim xeVolume As XElement = eCitation.Descendants("volume").FirstOrDefault()
            If xeVolume IsNot Nothing Then
                lblVolume.Text = xeVolume.Value
            End If

            'get pages
            Dim xePages As XElement = eCitation.Descendants("pages").FirstOrDefault()
            If xePages IsNot Nothing Then
                lblPages.Text = xePages.Value
            End If

            'get year
            Dim xeYear As XElement = eCitation.Descendants("year").FirstOrDefault()
            If xeYear IsNot Nothing Then
                lblYear.Text = xeYear.Value
            End If

            'get publisher
            Dim xePublisher As XElement = eCitation.Descendants("publisher").FirstOrDefault()
            If xePublisher IsNot Nothing Then
                lblPublisher.Text = xePublisher.Value
            End If
        End Sub
    End Class
