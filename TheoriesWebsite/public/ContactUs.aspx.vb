Imports System.Data.SqlClient
Imports System.Data
Imports DataAccess
Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.IO

Partial Class public_ContactUs
  Inherits System.Web.UI.Page
  Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    'client side validation
    btnsubmit1.Attributes.Add("onclick", "return ValidateInput();")
    Page.Form.DefaultButton = Me.btnsubmit1.UniqueID

    txtComments.Attributes.Add("onKeyUp", "return TxtCntchk(500, '" + txtComments.ClientID + "','" + txtCommentsCnt.ClientID + "');")

    'If IsPostBack Then

    'Me.lblMessage.Text = "Your comments have been saved."

    'End If


  End Sub
  Sub saveComments()

    If Me.txtname.Text = "" AndAlso Me.txtEmail.Text = "" Then
      Me.lblMessage.Text = "Please enter your name and email."
    ElseIf Me.txtname.Text = "" Then
      Me.lblMessage.Text = "Please enter your name."
    ElseIf Me.txtEmail.Text = "" Then
      Me.lblMessage.Text = "Please enter your email."
    Else

      Dim parameters() As SqlParameter = New SqlParameter() _
          {
              New SqlParameter("@SenderName", SqlDbType.NVarChar) With {.Value = txtname.Text},
              New SqlParameter("@SenderEmail", SqlDbType.VarChar) With {.Value = txtEmail.Text},
              New SqlParameter("@SenderComments", SqlDbType.NVarChar) With {.Value = txtComments.Text}
          }

      DataAccess.ExecuteNonQueryStoredProc("usp_SaveUserComment", parameters)

      Response.Redirect("ContactUs_Send.aspx")

    End If

  End Sub

  Protected Sub btnsubmit1_Click(sender As Object, e As EventArgs) Handles btnsubmit1.Click
    saveComments()
  End Sub

  Protected Sub btncancel1_Click(sender As Object, e As EventArgs) Handles btncancel1.Click

    Response.Redirect("ContactUs.aspx")

  End Sub
  Protected Sub CharCount()
    'get textbox count
    Me.txtCommentsCnt.Text = 500 - Me.txtComments.Text.Length
  End Sub

  Protected Sub txtComments_TextChanged(sender As Object, e As System.EventArgs) Handles txtComments.TextChanged
    CharCount()
  End Sub
End Class
