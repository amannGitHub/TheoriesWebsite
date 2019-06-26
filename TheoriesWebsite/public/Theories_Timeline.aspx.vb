Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess

Partial Class public_Theories_Timeline
  Inherits System.Web.UI.Page
  Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    If Not IsPostBack Then

      Me.BindPubYearFilterDropDown()

    End If

  End Sub
  Sub BindPubYearFilterDropDown()
    Dim parameters() As SqlParameter = {}

    Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetPubYearList", parameters)

    ddlPubYear_Filter1.DataSource = dt1.DefaultView
    ddlPubYear_Filter1.DataBind()

    ddlPubYear_Filter2.DataSource = dt1.DefaultView
    ddlPubYear_Filter2.DataBind()

  End Sub

End Class
