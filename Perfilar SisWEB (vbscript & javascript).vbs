Dim sh
Dim WS
Dim IE
Dim Produto
Dim Index
Dim Motivo
Dim Obs

Set sh = CreateObject("Shell.Application")
Set WS = CreateObject("WScript.Shell")

For Each wnd In sh.Windows
   If InStr(1, wnd.FullName, "iexplore.exe", vbTextCompare) > 0 Then
      Set IE = wnd
      Exit For
   End If
Next

With IE.Document.All
   If .Item("CamposProtocolo[8].Descricao").Value = "Plano de voz" or .Item("CamposProtocolo[8].Descricao").Value = "Após Horário Atendimento" Then
      Produto = "MÓVEL"
   Else
      Produto = .Item("CamposProtocolo[8].Descricao").Value
   End if

   If .Item("CamposProtocolo[7].Descricao").Value = "Cancelamento Total" or .Item("CamposProtocolo[7].Descricao").Value = "Cancelamento Parcial" Then
      Index = 20
      Motivo = "OI CONTA TOTAL / OI TOTAL"
      Obs = "Móvel e Oi Total cancelados - aguardando conclusão da OS." & Chr(13) & "- Sem acesso a cancelamento/migração R2 -"
   Else
      Index = 26
      Motivo = "STATUS SUSPENSO"
      Obs = "Sem acesso a " & Chr(13) & "- Nenhuma alteração realizada -"
   End if
End With

If MsgBox("	Finalizado?	", vbYesNo + vbQuestion, "Powered by Alexan") = vbYes Then
   With IE.Document.All
      .Item("CamposTrat[0]").SelectedIndex        = 1
      .Item("select2-28796-container").InnerText  = "FINALIZADO"
      .Item("CamposTrat[1]").SelectedIndex 	  = 23
      .Item("select2-28797-container").InnerText  = "SOLICITAÇÃO ATENDIDA"
      .Item("CamposTrat[2]").Value 		  = Produto
      .Item("CamposTrat[3]").Value 		  = "BO RETENÇÃO EMPRESARIAL"
      .Item("CamposTrat[4]").Value 		  = "CANCELADO"
      .Item("CamposTrat[5]").Value 		  = .Item("CamposProtocolo[1].Descricao").Value
      .Item("CamposTrat[6]").Value 		  = "0"
      .Item("CamposTrat[7]").Value 		  = "0"
      .Item("CamposTrat[8]").Value 		  = "-"
      .Item("CamposTrat[9]").Value 		  = .Item("CamposProtocolo[14].Descricao").Value
      .Item("CamposTrat[10]").Value 		  = "00.000.000/0000-00"
      .Item("CamposTrat[11]").Value 		  = .Item("CamposProtocolo[1].Descricao").Value
      .Item("CamposTrat[12]").Value 		  = "1"
      .Item("CamposTrat[13]").SelectedIndex 	  = 1
      .Item("select2-28809-container").InnerText  = "NÃO"
      .Item("Status").SelectedIndex 		  = 2
      .Item("select2-Status-container").InnerText = "Finalizado"
      .Item("Observacao").Value 		  = "Protocolo perfilado com sucesso!"
   End With

   IE.Visible = True
   WS.AppActivate "Tratar Protocolos - Internet Explorer"
   IE.Document.All.Item("Observacao").Focus
   WS.SendKeys "^{a}"

ElseIf MsgBox("	 Pendente?	 ", vbYesNo + vbQuestion, "Powered by Alexan") = vbYes Then
   With IE.Document.All
      .Item("CamposTrat[0]").SelectedIndex 	  = 4
      .Item("select2-28796-container").InnerText  = "PENDENTE"
      .Item("CamposTrat[1]").SelectedIndex 	  = Index
      .Item("select2-28797-container").InnerText  = Motivo
      .Item("CamposTrat[2]").Value 		  = "FIXO + BL"
      .Item("CamposTrat[3]").Value 		  = "BO RETENÇÃO EMPRESARIAL"
      .Item("CamposTrat[4]").Value 		  = "DESMEMBRADO"
      .Item("CamposTrat[5]").Value 		  = .Item("CamposProtocolo[1].Descricao").Value
      .Item("CamposTrat[6]").Value 		  = "0"
      .Item("CamposTrat[7]").Value 		  = "0"
      .Item("CamposTrat[8]").Value 		  = "-"
      .Item("CamposTrat[9]").Value 		  = .Item("CamposProtocolo[14].Descricao").Value
      .Item("CamposTrat[10]").Value 		  = "00.000.000/0000-00"
      .Item("CamposTrat[11]").Value 		  = .Item("CamposProtocolo[1].Descricao").Value
      .Item("CamposTrat[12]").Value 		  = "0"
      .Item("CamposTrat[13]").SelectedIndex 	  = 1
      .Item("select2-28809-container").InnerText  = "NÃO"
      .Item("Status").SelectedIndex 		  = 4
      .Item("select2-Status-container").InnerText = "Pendente"
      .Item("Observacao").Value 		  = Obs
   End With

   WS.AppActivate "Tratar Protocolos - Internet Explorer"
   IE.Document.All.Item("Observacao").Focus
   WS.SendKeys "{UP}"
   WS.SendKeys "{END}"
End if