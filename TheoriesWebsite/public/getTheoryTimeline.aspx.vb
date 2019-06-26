Imports System.Data
Imports System.Data.SqlClient
Imports Newtonsoft.Json

Partial Class public_getTheoryTimeline
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim timeline As TheoryTimeline = Nothing
        timeline = New TheoryTimeline

        timeline.events = getTheories()
        Dim json As [String] = "[" + JsonConvert.SerializeObject(timeline) + "]"

        Response.Clear()
        Response.ContentType = "application/json; charset=utf-8"
        Response.Write(json)
        Response.End()
    End Sub

    Private Function getTheories() As List(Of Theory)
        Dim theories = New List(Of Theory)
        Dim theory As Theory = Nothing

        Dim links = New List(Of TheoryLink)
        Dim theorylink As TheoryLink = Nothing


        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@LetterGroup", SqlDbType.Char, 1),
          New SqlParameter("@UserID", SqlDbType.VarChar, 50) With {.Value = Nothing},
          New SqlParameter("@ConstructID", SqlDbType.Int),
          New SqlParameter("@YearPublished", SqlDbType.Int)
        }
        parameters(0).Value = Nothing
        parameters(2).Value = Nothing

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetTheoryList", parameters)

        If Not dt1 Is Nothing And dt1.Rows.Count > 0 Then
            For Each row As DataRow In dt1.Rows
                theory = New Theory
                links = New List(Of TheoryLink)
                theorylink = New TheoryLink

                theory.id = row("TheoryID").ToString()
                theory.title = row("TheoryName").ToString()
                theory.description = row("TheoryDescription").ToString()

                If Not String.IsNullOrEmpty(row("YearPublished").ToString()) Then
                    theory.startdate = row("YearPublished").ToString() + "-01-01 12:00"
                Else
                    theory.startdate = "2015-01-01 12:00"
                End If

                theory.date_limit = "ye"
                theory.icon = "plus_green.png"
                theory.importance = "45"

        theorylink.url = "Theory_details.aspx?TID=" + row("TheoryID").ToString()
        theorylink.label = "View Details"

                links.Add(theorylink)
                theory.link = links
                theories.Add(theory)
            Next
        End If

        Return theories
    End Function

End Class
