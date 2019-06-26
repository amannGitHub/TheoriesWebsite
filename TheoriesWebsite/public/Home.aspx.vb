Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Partial Class Home
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.BindBibliographyRepeater()
        End If
    End Sub

    Sub BindBibliographyRepeater()
        Dim parameters() As SqlParameter = New SqlParameter() _
       {
         New SqlParameter("@RecCnt", SqlDbType.SmallInt) With {.Value = 3},
         New SqlParameter("@LetterGroup", SqlDbType.Char, 1) With {.Value = Nothing},
         New SqlParameter("@UserID", SqlDbType.VarChar, 50) With {.Value = Nothing},
         New SqlParameter("@PubTypeID", SqlDbType.Int) With {.Value = Nothing},
         New SqlParameter("@YearPublished", SqlDbType.Int) With {.Value = Nothing}
       }

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetBibliography", parameters)

        RptBibilography.DataSource = dt1
        RptBibilography.DataBind()
    End Sub
    Protected Sub RptBibilography_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim hlCitation As Label

        If (e.Item.ItemType = ListItemType.Item) Or
             (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim DI As Object = e.Item.DataItem

            'Hyperlink Text in Citation Column
            hlCitation = e.Item.FindControl("hlCitation")
            Dim citation As String = DataBinder.Eval(DI, "Citation").ToString()
            Dim citationid As String = DataBinder.Eval(DI, "CitationID").ToString()
            Dim title As String = DataBinder.Eval(DI, "Title").ToString()

            If (citation.IndexOf(title, StringComparison.InvariantCultureIgnoreCase) > -1) Then
                Dim hltitle = String.Format("<a href={0}>{1}</a>", "Citation_details.aspx?citationid=" + citationid, title)
                citation = citation.Replace(title, hltitle)
            End If
            hlCitation.Text = citation
        End If
    End Sub
End Class
