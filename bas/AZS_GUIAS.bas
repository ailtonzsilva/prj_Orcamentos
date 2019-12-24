Attribute VB_Name = "AZS_GUIAS"
Option Explicit

Public Function BloqueioDeGuia(strSenha As String)
    ActiveSheet.Protect strSenha
End Function

Public Function DesbloqueioDeGuia(strSenha As String)
    ActiveSheet.Unprotect strSenha
End Function

Function LimparTemplate(Selecao As String, Conteudo As Variant)
    Range(Selecao).Select
    Selection.Value = Conteudo
End Function

Public Function OcultarLinhas(LinhaInicio As Integer, LinhaFinal As Integer, ocultar As Boolean)
    Rows(CStr(LinhaInicio) & ":" & CStr(LinhaFinal)).Select
    Selection.EntireRow.Hidden = ocultar
End Function

Public Function IntervaloEditacaoCriar(Titulo As String, Selecao As String)
On Error GoTo IntervaloEditacaoCriar_err
'On Error Resume Next
    
    ActiveSheet.Protection.AllowEditRanges.Add Title:=Titulo, Range:=Range(Selecao)
    
    DesmarcaTexto Selecao
    
IntervaloEditacaoCriar_Fim:
Exit Function
    
IntervaloEditacaoCriar_err:
    MsgBox Err.Description
    Resume IntervaloEditacaoCriar_Fim
End Function

Public Function IntervaloEditacaoRemover(IntervaloDeEdicao As String, Optional MarcarSelecao As String)
    Dim AER As AllowEditRange
    
    For Each AER In ActiveSheet.Protection.AllowEditRanges
        If AER.Title = IntervaloDeEdicao Then
            AER.DELETE
            MarcaTexto MarcarSelecao
        End If
    Next AER

End Function

Public Function IntervaloEditacaoRemoverTodos()
Dim AER As AllowEditRange
Dim x As Integer

    x = ActiveSheet.Protection.AllowEditRanges.count
        
    For Each AER In ActiveSheet.Protection.AllowEditRanges
        If x > 0 Then
            AER.DELETE
        End If
    Next AER
        
    Set AER = Nothing

End Function

Public Function MarcaTexto(Selecao As String)
    
    Range(Selecao).Select
    
    With Selection.Interior
'''####################
'''     AMARELO
'''####################

'        .Pattern = xlSolid
'        .PatternColorIndex = xlAutomatic
'        .Color = 65535
'        .TintAndShade = 0
'        .PatternTintAndShade = 0
        
'''####################
'''     SIMPLES
'''####################
                
        .Pattern = xlGray8
        .PatternColorIndex = xlAutomatic
        .ColorIndex = xlAutomatic
'        .TintAndShade = 0
'        .PatternTintAndShade = 0
        
    End With
    
End Function

Public Function DesmarcaTexto(Selecao As String)
    
'Application.Wait DateAdd("s", 10, Now)
    
    Range(Selecao).Select
    
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
'        .ThemeColor = xlThemeColorDark1
'        .TintAndShade = 0
'        .PatternTintAndShade = 0
    End With
    
End Function

Public Function MarcarObrigatorio(Selecao As String)

    Range(Selecao).Select
    Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Color = -16776961
        .TintAndShade = 0
        .Weight = xlThick
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Color = -16776961
        .TintAndShade = 0
        .Weight = xlThick
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Color = -16776961
        .TintAndShade = 0
        .Weight = xlThick
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Color = -16776961
        .TintAndShade = 0
        .Weight = xlThick
    End With
    With Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    
End Function

Public Sub InserirConteudo(Linha As Long, Coluna As Long, Conteudo As String)
    Cells(Linha, Coluna).Select
    Cells(Linha, Coluna).Value = Conteudo
End Sub

Public Function SelecionarGuiaAtual()
    Sheets(ActiveSheet.Name).Select
End Function

Public Function PesquisaNomeGuia(sGuia As String) As Boolean
Dim s As Integer
    For s = 1 To Sheets.count
        If Sheets(s).Name = sGuia Then
            PesquisaNomeGuia = True
        End If
    Next
End Function

Public Function ContarAreaPreechida(area As Range) As Long
    Dim celula As Range, Contador As Long
    Contador = 0
    For Each celula In area
        If celula <> "" Then
            Contador = Contador + 1
        End If
    Next
    ContarAreaPreechida = Contador
End Function

