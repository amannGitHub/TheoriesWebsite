Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Public NotInheritable Class DataAccess

  Public Shared Function ExecuteQuery(ByVal sql As String) As DataTable
    Dim strConnString As String = ConfigurationManager.ConnectionStrings("HealthTheories_ConnectionString").ConnectionString
    Dim ds As New DataTable

    Using con As New SqlConnection(strConnString)
      Using cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = sql

        Using sda As New SqlDataAdapter()
          sda.SelectCommand = cmd
          sda.Fill(ds)
        End Using
      End Using
    End Using
    Return ds
  End Function

  Public Shared Function ExecuteStoredProc(ByVal storedProc As String, ParamArray paramList As SqlParameter()) As DataTable
    Dim strConnString As String = ConfigurationManager.ConnectionStrings("HealthTheories_ConnectionString").ConnectionString
    Dim ds As New DataTable

    Using con As New SqlConnection(strConnString)

      Using cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = storedProc
        For i As Integer = 0 To paramList.Length - 1
          cmd.Parameters.Add(paramList(i))
        Next

        Using sda As New SqlDataAdapter()
          sda.SelectCommand = cmd
          sda.Fill(ds)
        End Using

      End Using

    End Using
    Return ds
  End Function

  Public Shared Sub ExecuteNonQueryStoredProc(ByVal storedProc As String, ParamArray paramList As SqlParameter())
    Dim strConnString As String = ConfigurationManager.ConnectionStrings("HealthTheories_ConnectionString").ConnectionString
    Dim ds As New DataTable

    Using con As New SqlConnection(strConnString)

      Using cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = storedProc
        For i As Integer = 0 To paramList.Length - 1
          cmd.Parameters.Add(paramList(i))
        Next
        con.Open()
        cmd.ExecuteNonQuery()

      End Using

    End Using
  End Sub

    Public Shared Function ExecuteNonQueryStoredProc_returnOutputParameter(ByVal storedProc As String, ByVal ReturnVarName As String, ParamArray paramList As SqlParameter()) As String
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("HealthTheories_ConnectionString").ConnectionString
        Dim ds As New DataTable

        Using con As New SqlConnection(strConnString)

            Using cmd As New SqlCommand()
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandText = storedProc
                For i As Integer = 0 To paramList.Length - 1
                    cmd.Parameters.Add(paramList(i))
                Next
                con.Open()
                cmd.ExecuteNonQuery()
                Return cmd.Parameters(ReturnVarName).Value.ToString()
            End Using
        End Using

    End Function

End Class


