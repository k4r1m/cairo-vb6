VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cCSProduccionPrestaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'--------------------------------------------------------------------------------
' cCSProduccionPrestaciones
' 09-05-2003

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
' enumeraciones

Public Enum csProduccionPrestacion
  csPreProdNewMaquina = 13002
  csPreProdEditMaquina = 13003
  csPreProdDeleteMaquina = 13004
  csPreProdListMaquina = 13005
  
  csPreProdNewProductoBOM = 13006
  csPreProdEditProductoBOM = 13007
  csPreProdDeleteProductoBOM = 13008
  csPreProdListProductoBOM = 13009

End Enum

Public Enum csMenuEnum
 csMenuConfig = 13999
End Enum

' variables privadas
' propiedades publicas
' propiedades privadas
' funciones publicas
Public Sub Init()
  SecurityAdd csPreProdNewMaquina, "Agregar Maquina", "Producci�n"
  SecurityAdd csPreProdDeleteMaquina, "Borrar Maquina", "Producci�n"
  SecurityAdd csPreProdEditMaquina, "Editar Maquina", "Producci�n"
  SecurityAdd csPreProdListMaquina, "Listar Maquina", "Producci�n"
  
  SecurityAdd csPreProdNewProductoBOM, "Agregar B.O.M.", "Producci�n"
  SecurityAdd csPreProdDeleteProductoBOM, "Borrar B.O.M.", "Producci�n"
  SecurityAdd csPreProdEditProductoBOM, "Editar B.O.M.", "Producci�n"
  SecurityAdd csPreProdListProductoBOM, "Listar B.O.M.", "Producci�n"
End Sub

' funciones privadas
' construccion - destruccion




