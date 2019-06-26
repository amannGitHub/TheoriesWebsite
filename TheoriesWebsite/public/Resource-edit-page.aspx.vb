Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Linq
Imports System.Net
Partial Class public_Resource_edit_page
    Inherits System.Web.UI.Page
    Private _ResourceID As Integer
    Public Property ResourceID() As Integer
        Get
            Return _ResourceID
        End Get
        Set(ByVal value As Integer)
            _ResourceID = value
        End Set
    End Property
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim intResourceID As Integer = 0

        If Not String.IsNullOrEmpty(Request.QueryString("RID")) Then
            Integer.TryParse(Request.QueryString("RID"), intResourceID)
            ResourceID = intResourceID
        End If

        If Not IsPostBack Then
            If intResourceID = 0 Then
                ltlmode.Text = "Add Resource"
                hlexit.NavigateUrl = "browse-resources.aspx"
                hlexit.Text = "Exit Add Mode"
            Else
                hlexit.NavigateUrl = "Resource_details.aspx?RID=" & ResourceID
                hlexit.Text = "Exit Edit Mode"
                GetResource()
            End If
            BuildResourceTypeDropDown()
        End If


    End Sub
    Sub BuildResourceTypeDropDown()
        Dim parameters() As SqlParameter = {}

        Dim dt1 As DataTable = DataAccess.ExecuteStoredProc("usp_GetResoureTypeList", parameters)

        ddlResourceType.DataSource = dt1.DefaultView
        ddlResourceType.DataBind()

    End Sub

    Sub SaveResource()
        Dim strResourceName As String = txtResourceName.Text().Trim
        strResourceName = Replace(strResourceName, Chr(13) & Chr(10), " ")
        strResourceName = strResourceName.Replace(vbCrLf, " ")

        Dim strDescription As String = txtDescription.Text().Trim
        Dim intResourceTypeID As Integer = Integer.Parse(ddlResourceType.SelectedValue)
        Dim strURL As String = txtURL.Text()

        Dim parameters() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@ResourceID", SqlDbType.Int),
          New SqlParameter("@ResourceName", SqlDbType.NVarChar, 500) With {.Value = strResourceName},
          New SqlParameter("@ResourceDesc", SqlDbType.NVarChar) With {.Value = strDescription},
          New SqlParameter("@ResourceTypeID", SqlDbType.Int) With {.Value = intResourceTypeID},
          New SqlParameter("@ResourceDate", SqlDbType.DateTime) With {.Value = DBNull.Value},
          New SqlParameter("@UserID", SqlDbType.UniqueIdentifier, 75) With {.Value = DBNull.Value},
          New SqlParameter("@ResourceURL", SqlDbType.NVarChar, 1000) With {.Value = strURL}
          }
        If ResourceID = 0 Then
            parameters(0).Direction = ParameterDirection.Output
            parameters(0).Value = DBNull.Value
        Else
            parameters(0).Value = Integer.Parse(ResourceID)
        End If
        Dim rid As String

        rid = DataAccess.ExecuteNonQueryStoredProc_returnOutputParameter("usp_SaveResource", "@ResourceID", parameters)
        Response.Redirect("Resource_details.aspx?RID=" & rid)
    End Sub

    Sub GetResource()
        'Dim result As String
        Dim parameters() As SqlParameter = New SqlParameter() _
       {
         New SqlParameter("@ResourceID", SqlDbType.Int) With {.Value = ResourceID}
     }
        Dim dt As DataTable = DataAccess.ExecuteStoredProc("usp_GetResource", parameters)
        If Not dt Is Nothing Then
            txtResourceName.Text = dt.Rows(0)("ResourceName").ToString()
            txtDescription.Text = dt.Rows(0)("ResourceDesc").ToString()
            txtURL.Text = dt.Rows(0)("ResourceURL").ToString()
            ddlResourceType.Text = dt.Rows(0)("ResourceTypeID").ToString()
            lbltitle.Text = dt.Rows(0)("ResourceName").ToString()

        End If

    End Sub

    Protected Sub btncancel1_Click(sender As Object, e As EventArgs)
        Dim strRID As String = Request.QueryString("RID")
        If String.IsNullOrEmpty(strRID) Then
            Response.Redirect("Browser-Resource.aspx")
        Else
            Response.Redirect("Resource_details.aspx?RID=" & ResourceID)
        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        If ResourceURLExists() Then
            pnlConfirm.Visible = True
            pnlMain.Visible = Not pnlConfirm.Visible
        Else
            SaveResource()
            pnlConfirm.Visible = False
            pnlMain.Visible = Not pnlConfirm.Visible
        End If

    End Sub

    Protected Sub btnOK_Click(sender As Object, e As EventArgs) Handles btnOk.Click

        If IsPostBack() Then
            SaveResource()
            pnlConfirm.Visible = False
        End If
    End Sub

    Protected Sub btnNo_Click(sender As Object, e As EventArgs) Handles btnNo.Click

        pnlConfirm.Visible = False
        pnlMain.Visible = Not pnlConfirm.Visible
    End Sub
    Function ResourceURLExists() As Boolean
        Dim rst As Boolean = False
        Dim strURL As String = txtURL.Text()

        Dim parameters() As SqlParameter = New SqlParameter() _
            {
              New SqlParameter("@URL", SqlDbType.NVarChar, 1000) With {.Value = strURL},
              New SqlParameter("@ResourceID", SqlDbType.Int)}

        If ResourceID = 0 Then
            parameters(1).Value = DBNull.Value
        Else
            parameters(1).Value = Integer.Parse(ResourceID)
        End If
        Dim dt As DataTable = DataAccess.ExecuteStoredProc("usp_GetResourceByURL", parameters)

        If Not dt Is Nothing Then
            If dt.Rows.Count > 0 Then
                rst = True
            Else
                rst = False
            End If
        Else
            rst = False
        End If

        Return rst
    End Function

    Function IsValid()

    End Function
End Class
