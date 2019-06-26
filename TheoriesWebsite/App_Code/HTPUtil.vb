Imports Microsoft.VisualBasic

Public Class HTPUtil
    Public Shared HomeDescCount As Integer = 120
    Public Shared BrowseResDescCount As Integer = 500

    Public Shared Function TruncateAtWord(input As String, length As Integer) As String
        If input Is Nothing OrElse input.Length < length Then
            Return input
        End If
        Dim iNextSpace As Integer = input.LastIndexOf(" ", length)
        Return String.Format("{0}...", input.Substring(0, If((iNextSpace > 0), iNextSpace, length)).Trim())
    End Function
    Public Shared Function CheckNull(myValue As Object) As Boolean
        If myValue Is Nothing Then
            Return False
        End If
        Return True
    End Function

    Public Shared Function checknullreturnNO(myValue As Object) As String
        If myValue Is DBNull.Value Then
            Return "No"
        End If
        Return myValue.ToString()
  End Function
  Public Shared Function checknullreturnNOElseYes(myValue As Object) As String
    If myValue Is DBNull.Value Then
      Return "No"
    Else
      Return "Yes"
    End If
    Return myValue.ToString()
  End Function
  Public Shared Function CheckNullReturnFalse(myValue As Object) As Boolean
    If myValue Is DBNull.Value Then
      Return False
    End If
    Return True
  End Function
  Public Shared Function CheckNullReturnTrue(myValue As Object) As Boolean
    If myValue Is DBNull.Value Then
      Return True
    End If
    Return False
  End Function
End Class
