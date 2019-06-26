Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class HomePageBLL
    Protected strConn As String = ConfigurationManager.ConnectionStrings("HealthTheories_ConnectionString").ConnectionString


  Public Function LoadCommonTheories() As DataTable

    'Return DataAccess.ExecuteStoredProc("usp_GetCommonTheories")
    Return DataAccess.ExecuteStoredProc("usp_GetMostViewedTheories")

  End Function

    Public Function LoadRecentTheories() As DataTable
        Return DataAccess.ExecuteStoredProc("usp_GetRecentTheories")
    End Function


    Public Function LoadRecentResources() As DataTable
        Return DataAccess.ExecuteStoredProc("usp_GetRecentResources")
    End Function
End Class
