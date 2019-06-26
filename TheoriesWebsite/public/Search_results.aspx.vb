Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Imports System.ComponentModel

Partial Class public_Search_results
	Inherits System.Web.UI.Page
	Private _TID As Int32
  Dim count As Int32
  Dim tsearchKeyword As String = String.Empty

	Public Property TID() As Int32
		Get
			Return _TID
		End Get
		Set(ByVal value As Int32)
			_TID = value
		End Set
	End Property

	Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		Dim sTxt As String = String.Empty
		Dim queryTxt As String = Request.QueryString("sTxt")

		lblTitle.Text = "Search Results"

		If Not IsPostBack Then
      If Not IsNothing(queryTxt) Then
        txtSearchResults.Text = queryTxt
        getTheory(queryTxt)
        getCitation(queryTxt)
        getResource(queryTxt)
      End If
    Else
      tsearchKeyword = txtSearchResults.Text
    End If

	End Sub
  Sub getTheory(Optional ByVal tsearchKeyword As String = Nothing, Optional ByVal displayall As Boolean = False)

    If tsearchKeyword <> "" Then
      Dim parameters() As SqlParameter = New SqlParameter() _
       {
       New SqlParameter("@searchKeyword", SqlDbType.VarChar, 100) With {.Value = tsearchKeyword}
      }
      Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_SearchTheories", parameters)

      Dim pgitems As New PagedDataSource()
      Dim pagesize As Int32 = Int32.Parse(ConfigurationManager.AppSettings("PageSize"))
      Dim dv As New DataView(dt1)
      pgitems.DataSource = dv

      TheoryTotalCount.Text = String.Empty
      TheoryCount.Text = pgitems.PageSize
      lblTheoryCount.Visible = False
      btnTheoryAll.Visible = False
      btnTheoryLess.Visible = True
      pgitems.PageSize = dv.Count

      If Not (displayall) Then
        pgitems.AllowPaging = True
        pgitems.PageSize = pagesize
        If (CInt(dv.Count) < 1) Or (CInt(dv.Count) <= pgitems.PageSize) Then
          btnTheoryAll.Visible = False
          btnTheoryLess.Visible = False
        Else
          btnTheoryAll.Visible = True
          btnTheoryLess.Visible = False
        End If
      End If

      If CInt(dv.Count) > 0 Then
        If CInt(dv.Count) <= pgitems.PageSize Then
          TheoryCount.Text = dv.Count
        End If
        TheoryTotalCount.Text = (dv.Count)
        lblTheoryCount.Visible = True
      End If

      RptTheories.DataSource = pgitems
      RptTheories.DataBind()
    End If

  End Sub
  Sub getCitation(Optional ByVal tsearchKeyword As String = Nothing, Optional ByVal displayall As Boolean = False)
    If tsearchKeyword <> "" Then
      Dim parameters() As SqlParameter = New SqlParameter() _
       {
       New SqlParameter("@searchKeyword", SqlDbType.VarChar, 100) With {.Value = tsearchKeyword}
      }
      Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_SearchBibliography", parameters)

      Dim pgitems As New PagedDataSource()
      Dim pagesize As Int32 = Int32.Parse(ConfigurationManager.AppSettings("PageSize"))
      Dim dv As New DataView(dt1)

      pgitems.DataSource = dv

      CitationTotalCount.Text = String.Empty
      CitationCount.Text = pgitems.PageSize
      lblCitationCount.Visible = False
      pgitems.PageSize = dv.Count
      btnCitationAll.Visible = False
      btnCitationLess.Visible = True

      If Not (displayall) Then
        pgitems.AllowPaging = True
        pgitems.PageSize = pagesize
        If (CInt(dv.Count) < 1) Or (CInt(dv.Count) <= pgitems.PageSize) Then
          btnCitationAll.Visible = False
          btnCitationLess.Visible = False
        Else
          btnCitationAll.Visible = True
          btnCitationLess.Visible = False
        End If
      End If

      If CInt(dv.Count) > 0 Then
        If CInt(dv.Count) <= pgitems.PageSize Then
          CitationCount.Text = dv.Count
        End If
        CitationTotalCount.Text = (dv.Count)
        lblCitationCount.Visible = True
      End If

      RptCitations.DataSource = pgitems
      RptCitations.DataBind()
    End If

  End Sub
  Sub getResource(Optional ByVal tsearchKeyword As String = Nothing, Optional ByVal displayall As Boolean = False)
    If tsearchKeyword <> "" Then
      Dim parameters() As SqlParameter = New SqlParameter() _
       {
       New SqlParameter("@searchKeyword", SqlDbType.VarChar, 100) With {.Value = tsearchKeyword}
      }
      Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_SearchResources", parameters)

      Dim pgitems As New PagedDataSource()
      Dim pagesize As Int32 = Int32.Parse(ConfigurationManager.AppSettings("PageSize"))
      Dim dv As New DataView(dt1)

      pgitems.DataSource = dv

      ResourceTotalCount.Text = String.Empty
      ResourceCount.Text = pgitems.PageSize
      lblResourceCount.Visible = False
      btnResourceAll.Visible = False
      btnResourceLess.Visible = True
      pgitems.PageSize = dv.Count

      If Not (displayall) Then
        pgitems.AllowPaging = True
        pgitems.PageSize = pagesize
        If (CInt(dv.Count) < 1) Or (CInt(dv.Count) <= pgitems.PageSize) Then
          btnResourceAll.Visible = False
          btnResourceLess.Visible = False
        Else
          btnResourceAll.Visible = True
          btnResourceLess.Visible = False
        End If
      End If

      If CInt(dv.Count) > 0 Then
        If CInt(dv.Count) <= pgitems.PageSize Then
          ResourceCount.Text = dv.Count
        End If
        ResourceTotalCount.Text = (dv.Count)
        lblResourceCount.Visible = True
      End If

      RptResources.DataSource = pgitems
      RptResources.DataBind()
    End If

  End Sub
  Public Shared Function TruncateAtWord(input As String, length As Integer) As String
    If input Is Nothing OrElse input.Length < length Then
      Return input
    End If
    Dim iNextSpace As Integer = input.LastIndexOf(" ", length)
    Return String.Format("{0}...", input.Substring(0, If((iNextSpace > 0), iNextSpace, length)).Trim())
  End Function
	Protected Sub RptTheories_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptTheories.ItemDataBound
    If RptTheories.Items.Count < 1 Then
      If e.Item.ItemType = ListItemType.Footer Then
        Dim trFooter As Control = e.Item.FindControl("tremptydata")
        Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
        lblFooter.Visible = True
        trFooter.Visible = True
      End If
    End If
  End Sub
  Protected Sub RptCitations_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptCitations.ItemDataBound
    Dim hlCitation As Label
    Dim hlPubMed As HyperLink
    Dim lnbCitation As LinkButton = CType(e.Item.FindControl("lnbCitation"), LinkButton)

      If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
        Dim DI As Object = e.Item.DataItem

      'Hyperlink Text in Citation Column
        hlCitation = e.Item.FindControl("hlCitation")
        hlPubMed = e.Item.FindControl("hlPubMed")
        Dim citation As String = DataBinder.Eval(DI, "Citation").ToString()
        Dim citationid As String = DataBinder.Eval(DI, "CitationID").ToString()
        Dim title As String = DataBinder.Eval(DI, "Title").ToString()

        If (citation.IndexOf(title, StringComparison.InvariantCultureIgnoreCase) > -1) Then
          Dim hltitle = String.Format("<a href={0}>{1}</a>", "Citation_details.aspx?citationid=" + citationid, title)
          citation = citation.Replace(title, hltitle)
        End If
        hlCitation.Text = citation
      End If
    If RptCitations.Items.Count < 1 Then
      If e.Item.ItemType = ListItemType.Footer Then
        Dim trFooter As Control = e.Item.FindControl("tremptydata")
        Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
        lblFooter.Visible = True
        trFooter.Visible = True
      End If
    End If

    If (e.Item.ItemType = ListItemType.Item) Or
          (e.Item.ItemType = ListItemType.AlternatingItem) Then
    End If
  End Sub
  Protected Sub RptResources_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RptResources.ItemDataBound

    If RptResources.Items.Count < 1 Then
      If e.Item.ItemType = ListItemType.Footer Then
        Dim trFooter As Control = e.Item.FindControl("tremptydata")
        Dim lblFooter As Label = CType(e.Item.FindControl("lblEmptyData"), Label)
        lblFooter.Visible = True
        trFooter.Visible = True
      End If
    End If

  End Sub
  Public Shared Function CreateURL(myValue As Object) As String
    If myValue Is DBNull.Value Then
      Return "No"
    Else
      Return "Yes"
    End If
    Return myValue.ToString()
  End Function
  Protected Sub btnsearchResults_Click(sender As Object, e As EventArgs) Handles btnSearchResults.Click
    getTheory(tsearchKeyword)
    getCitation(tsearchKeyword)
    getResource(tsearchKeyword)
  End Sub
  Protected Sub btnResourceAll_Click(sender As Object, e As EventArgs) Handles btnResourceAll.Click
    getResource(tsearchKeyword, True)
  End Sub
  Protected Sub btnResourceLess_Click(sender As Object, e As EventArgs) Handles btnResourceLess.Click
    getResource(tsearchKeyword, False)
  End Sub
  Protected Sub btnCitationAll_Click(sender As Object, e As EventArgs) Handles btnCitationAll.Click
    getCitation(tsearchKeyword, True)
  End Sub
  Protected Sub btnCitationLess_Click(sender As Object, e As EventArgs) Handles btnCitationLess.Click
    getCitation(tsearchKeyword, False)
  End Sub
  Protected Sub btnTheoryAll_Click(sender As Object, e As EventArgs) Handles btnTheoryAll.Click
    getTheory(tsearchKeyword, True)
  End Sub
  Protected Sub btnTheoryLess_Click(sender As Object, e As EventArgs) Handles btnTheoryLess.Click
    getTheory(tsearchKeyword, False)
  End Sub
End Class
