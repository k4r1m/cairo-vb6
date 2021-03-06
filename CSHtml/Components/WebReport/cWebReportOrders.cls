VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cWebReportOrders"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'--------------------------------------------------------------------------------
' cWebReportOrders
' 23-04-04

'--------------------------------------------------------------------------------
' notas:

'--------------------------------------------------------------------------------
' api win32
    ' constantes
    ' estructuras
    ' funciones

'--------------------------------------------------------------------------------

' constantes
Private Const C_Module = "CSWebReport.cWebReportOrders"
' estructuras
' variables privadas
Private m_Coll      As Collection
' eventos
' propiedades publicas
' propiedades privadas
' funciones publicas
Public Function Load(ByVal RptId As Long) As Boolean
  Dim db            As cDBHelper
  Dim rs            As ADODB.Recordset
  
  Set db = CreateObject("CSWebDataBase.cDBHelper")
  
  Set rs = db.RunSPReturnRS("sp_Web_ReportsGetOrders", _
                            mp("@@rpt_id", adInteger, 4, RptId))
  CollClear m_Coll

  While Not rs.EOF
    
    With Add(Nothing)
      .FieldName = ValField(rs.Fields, cscWInfoNombre)
    End With
    
    rs.MoveNext
  Wend

  GetObjectContext.SetComplete
  Load = True
  Exit Function
      
ControlError:
  CtxRaiseError C_Module, "Load"
End Function

Public Function Add(ByVal o As cWebReportOrder, Optional Key As Variant) As cWebReportOrder
  On Error GoTo ControlError

  If o Is Nothing Then Set o = New cWebReportOrder

  If IsMissing(Key) Then
    m_Coll.Add o
  Else
    m_Coll.Add o, GetKey(Key)
  End If
  
  Dim Col As cWebReportOrder
  Set Col = o
  Col.Index = m_Coll.Count

  Set Add = o
  Exit Function
ControlError:
  Set Add = Nothing

End Function

Public Sub Clear()
  CollClear m_Coll
End Sub

Public Function Count() As Long
  Count = m_Coll.Count
End Function

Public Function Item(ByVal kItem As Variant) As cWebReportOrder
Attribute Item.VB_UserMemId = 0
  On Error GoTo ControlError
  If Not IsNumeric(kItem) Then kItem = GetKey(kItem)
  Set Item = m_Coll(kItem)
  Exit Function
ControlError:
End Function

Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
  Set NewEnum = m_Coll.[_NewEnum]
End Function

Public Sub Remove(ByVal kItem As Variant)
  m_Coll.Remove kItem
End Sub

' funciones privadas
' construccion - destruccion
Private Sub Class_Initialize()
  Set m_Coll = New Collection
End Sub

Private Sub Class_Terminate()
  CollClear m_Coll
  Set m_Coll = Nothing
End Sub

