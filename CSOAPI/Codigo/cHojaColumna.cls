VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cLeaveColumn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'--------------------------------------------------------------------------------
' cLeaveColumn
' 25-03-00

'--------------------------------------------------------------------------------
' notas:

'--------------------------------------------------------------------------------
' api win32
    ' constantes
    ' estructuras
    ' funciones

'--------------------------------------------------------------------------------

' constantes
' estructuras
' variables privadas
Private m_Name          As String
Private m_Value         As String
Private m_Type          As csTypes
' Properties publicas
Public Property Get Name() As String
    Name = m_Name
End Property
Public Property Let Name(ByVal rhs As String)
    m_Name = rhs
End Property
Public Property Get Value() As String
    Value = m_Value
End Property
Public Property Let Value(ByVal rhs As String)
    m_Value = rhs
End Property
Public Property Get VarType() As csTypes
    VarType = m_Type
End Property
Public Property Let VarType(ByVal rhs As csTypes)
    m_Type = rhs
End Property
' Properties privadas
' funciones publicas
' funciones privadas




