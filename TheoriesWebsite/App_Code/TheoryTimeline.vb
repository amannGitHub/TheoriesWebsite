Imports Microsoft.VisualBasic


Public Class TheoryLink
    Public Property url() As String
        Get
            Return m_url
        End Get
        Set
            m_url = Value
        End Set
    End Property
    Private m_url As String
    Public Property label() As String
        Get
            Return m_label
        End Get
        Set
            m_label = Value
        End Set
    End Property
    Private m_label As String
End Class

Public Class Theory
    Public Property id() As String
        Get
            Return m_id
        End Get
        Set
            m_id = Value
        End Set
    End Property
    Private m_id As String
    Public Property title() As String
        Get
            Return m_title
        End Get
        Set
            m_title = Value
        End Set
    End Property
    Private m_title As String
    Public Property startdate() As String
        Get
            Return m_startdate
        End Get
        Set
            m_startdate = Value
        End Set
    End Property
    Private m_startdate As String
    Public Property date_limit() As String
        Get
            Return m_date_limit
        End Get
        Set
            m_date_limit = Value
        End Set
    End Property
    Private m_date_limit As String
    Public Property description() As String
        Get
            Return m_description
        End Get
        Set
            m_description = Value
        End Set
    End Property
    Private m_description As String
    Public Property icon() As String
        Get
            Return m_icon
        End Get
        Set
            m_icon = Value
        End Set
    End Property
    Private m_icon As String
    Public Property importance() As String
        Get
            Return m_importance
        End Get
        Set
            m_importance = Value
        End Set
    End Property
    Private m_importance As String
    Public Property link() As List(Of TheoryLink)
        Get
            Return m_link
        End Get
        Set
            m_link = Value
        End Set
    End Property
    Private m_link As List(Of TheoryLink)
End Class

Public Class TheoryTimeline
    Public Property id() As String
        Get
            Return m_id
        End Get
        Set
            m_id = Value
        End Set
    End Property
    Private m_id As String = "theoryTimeline"
    Public Property title() As String
        Get
            Return m_title
        End Get
        Set
            m_title = Value
        End Set
    End Property
    Private m_title As String = "Theory Timeline"
    Public Property focus_date() As String
        Get
            Return m_focus_date
        End Get
        Set
            m_focus_date = Value
        End Set
    End Property
    Private m_focus_date As String = "today"
    Public Property initial_zoom() As String
        Get
            Return m_initial_zoom
        End Get
        Set
            m_initial_zoom = Value
        End Set
    End Property
    Private m_initial_zoom As String = "45"
    Public Property color() As String
        Get
            Return m_color
        End Get
        Set
            m_color = Value
        End Set
    End Property
    Private m_color As String = "#82530d"
    Public Property size_importance() As String
        Get
            Return m_size_importance
        End Get
        Set
            m_size_importance = Value
        End Set
    End Property
    Private m_size_importance As String = "true"
    Public Property events() As List(Of Theory)
        Get
            Return _theoryLists
        End Get
        Set
            _theoryLists = Value
        End Set
    End Property
    Private _theoryLists As List(Of Theory)
End Class

