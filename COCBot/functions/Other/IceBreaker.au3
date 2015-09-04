; #FUNCTION# ====================================================================================================================
; Name ..........: IceBreaker
; Description ...: A trivia bot based on ChatBot
; Syntax ........: IceBreaker()
; Parameters ....: None
; Return values .: None
; Author ........: mojacka
; Modified ......: 8/25/2015
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:  =====================================================================================================================

Func IceBreaker()
	If $Answered = True Then
		$Answered = False
		$padzero = ""
		$category = Random(1, 191, 1)
		If $category < 10 Then
			$padzero = "00"
		ElseIf $category < 100 Then
			$padzero = "0"
		EndIf
		;SetLog("Padding: " & $padzero)
		$filename = @ScriptDir & "\english_question_files\" & $padzero & $category & ".lst"
		;SetLog("Filename: " & $filename)
		$questions = _FileCountLines($filename)
		;SetLog("Number of questions: " & $questions)
		$question = Random(1, $questions, 1)
		;SetLog("Question num: " & $question)
		$questionAnswer = StringSplit(FileReadLine($filename, $question), "*")
		;SetLog("Question: " & $questionAnswer[1] & " " & $questionAnswer[2])
		$Answer = $questionAnswer[2]
		WriteClan($questionAnswer[1])

	EndIf
	If $Answered = False Then
		$answerClan = ReadClan()
		If $answerClan == $Answer Then
			$Answered = True
			WriteClan( $Answer & "is correct!")
		Else
			$AnswerTries += 1
		EndIf
		If $AnswerTries = 5 Then
			WriteClan("The correct asnwer is " & $Answer)
			$AnswerTries = 0
			$Answered = True
		EndIf
	EndIf
EndFunc   ;==>IceBreaker

Func WriteClan($ChatMsg)
	;SetLog("Chatbot: Sending chats to clan", $COLOR_GREEN)
	If Not ChatbotChatOpen() Then Return
	If Not ChatbotSelectClanChat() Then Return
	If Not ChatbotChatClanInput() Then Return
	If Not ChatbotChatInput($ChatMsg) Then Return
	If Not ChatbotChatSendClan() Then Return
	If Not ChatbotChatClose() Then Return
	;SetLog("Chatbot: Done", $COLOR_GREEN)
EndFunc   ;==>WriteClan

Func ReadClan()
	$msg = ""
	;SetLog("Chatbot: Reading chats from clan", $COLOR_GREEN)
	If Not ChatbotChatOpen() Then Return
	If Not ChatbotSelectClanChat() Then Return
	If ChatbotIsLastChatNew() Then
		$msg = StringStripWS(getOcrAndCapture("coc-latinA", 30, 148, 270, 13, False), 7)
		SetLog("Found chat message: " & $msg, $COLOR_GREEN)
	EndIf
	If Not ChatbotChatClose() Then Return
	;SetLog("Chatbot: Done", $COLOR_GREEN)
	Return $msg
EndFunc   ;==>ReadClan
