; ==========================================================
; Chatbot script by DankMemes
; Mod version: 2.1.1
; Made for COCBot <http://gamebot.org>
; I cannot be held responsible for what this chatbot says
; See bottom of file for more info
; ==========================================================

#include <Process.au3>
#include <Array.au3>

$chatIni = ""

; SETTINGS =================================================
Global $ChatbotChatGlobal       = False
Global $ChatbotScrambleGlobal   = False
Global $ChatbotSwitchLang       = False
Global $ChatbotChatClan         = False
Global $ChatbotClanUseCleverbot = False
Global $ChatbotClanUseSimsimi   = False
Global $ChatbotClanUseResponses = False
Global $ChatbotClanAlwaysMsg    = False
Global $ChatbotUsePushbullet    = False
Global $ChatbotPbSendNew        = False
Global $ClanMessages = ""
Global $ClanResponses = ""
Global $GlobalMessages1 = ""
Global $GlobalMessages2 = ""
Global $GlobalMessages3 = ""
Global $GlobalMessages4 = ""
; END SETTINGS =============================================

; GUI ======================================================

Global $chkGlobalChat;
Global $chkGlobalScramble;
Global $chkSwitchLang;

Global $chkClanChat;
Global $chkUseResponses;
Global $chkUseCleverbot;
Global $chkUseSimsimi;
Global $chkUseGeneric;
Global $chkChatPushbullet;
Global $chkPbSendNewChats;

Global $editGlobalMessages1;
Global $editGlobalMessages2;
Global $editGlobalMessages3;
Global $editGlobalMessages4;

Global $editResponses;
Global $editGeneric;

Global $ChatbotQueuedChats[0]
Global $ChatbotReadQueued = False
Global $ChatbotReadInterval = 0
Global $ChatbotIsOnInterval = False

Func ChatbotReadSettings()
   If IniRead($chatIni, "global", "use",      "False") = "True" Then $ChatbotChatGlobal       = True
   If IniRead($chatIni, "global", "scramble", "False") = "True" Then $ChatbotScrambleGlobal   = True
   If IniRead($chatIni, "global", "swlang",   "False") = "True" Then $ChatbotSwitchLang       = True

   If IniRead($chatIni, "clan", "use",        "False") = "True" Then $ChatbotChatClan         = True
   If IniRead($chatIni, "clan", "cleverbot",  "False") = "True" Then $ChatbotClanUseCleverbot = True
   If IniRead($chatIni, "clan", "simsimi",    "False") = "True" Then $ChatbotClanUseSimsimi   = True
   If IniRead($chatIni, "clan", "responses",  "False") = "True" Then $ChatbotClanUseResponses = True
   If IniRead($chatIni, "clan", "always",     "False") = "True" Then $ChatbotClanAlwaysMsg    = True
   If IniRead($chatIni, "clan", "pushbullet", "False") = "True" Then $ChatbotUsePushbullet    = True
   If IniRead($chatIni, "clan", "pbsendnew",  "False")  = "True" Then $ChatbotPbSendNew       = True

   $ClanMessages = StringSplit(IniRead($chatIni, "clan", "genericMsg", "Generic messages, eg|Remember to attack wisely in cw!|Remember to donate more than received"), "|", 2)
   Local $ClanResponses0 = StringSplit(IniRead($chatIni, "clan", "responseMsg", "keyword:Response, eg|hello:Hi, welcome to the clan!"), "|", 2)
   Local $ClanResponses1[UBound($ClanResponses0)][2];
   For $a = 0 To UBound($ClanResponses0) - 1
	  $TmpResp = StringSplit($ClanResponses0[$a], ":", 2)
	  If UBound($TmpResp) > 0 Then
		 $ClanResponses1[$a][0] = $TmpResp[0]
	  Else
		 $ClanResponses1[$a][0] = "<invalid>"
	  EndIf
	  If UBound($TmpResp) > 1 Then
		 $ClanResponses1[$a][1] = $TmpResp[1]
	  Else
		 $ClanResponses1[$a][1] = "<undefined>"
	  EndIf
   Next

   $ClanResponses = $ClanResponses1

   $GlobalMessages1 = StringSplit(IniRead($chatIni, "global", "globalMsg1", "join here|join|join now"), "|", 2)
   $GlobalMessages2 = StringSplit(IniRead($chatIni, "global", "globalMsg2", "awesome clan|great clan|cool clan"), "|", 2)
   $GlobalMessages3 = StringSplit(IniRead($chatIni, "global", "globalMsg3", "max donations|24/7 donations|huge donations"), "|", 2)
   $GlobalMessages4 = StringSplit(IniRead($chatIni, "global", "globalMsg4", "clan war every week|cw every week|frequent clan war"), "|", 2)
EndFunc

Func ChatbotCreateGui()
   $chatIni = $sProfilePath & "\" & $sCurrProfile & "\chat.ini"
   ChatbotReadSettings()
   $tabChat = GUICtrlCreateTabItem("Chat")

   Local $x = 30, $y = 150

   GUICtrlCreateGroup("Global Chat", $x - 20, $y - 20, 225, 375)
   $chkGlobalChat = GUICtrlCreateCheckbox("Advertise in global", $x - 5, $y)
   GUICtrlSetTip($chkGlobalChat, "Use global chat to send messages")
   GUICtrlSetState($chkGlobalChat, $ChatbotChatGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkGlobalScramble = GUICtrlCreateCheckbox("Scramble global chats", $x - 5, $y)
   GUICtrlSetTip($chkGlobalScramble, "Scramble the message pieces defined in the textboxes below to be in a random order")
   GUICtrlSetState($chkGlobalScramble, $ChatbotScrambleGlobal)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkSwitchLang = GUICtrlCreateCheckbox("Switch languages", $x - 5, $y)
   GUICtrlSetTip($chkSwitchLang, "Switch languages after spamming for a new global chatroom")
   GUICtrlSetState($chkSwitchLang, $ChatbotSwitchLang)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $editGlobalMessages1 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages1, @CRLF), $x - 5, $y, 200, 70)
   GUICtrlSetTip($editGlobalMessages1, "Take one item randomly from this list (one per line) and add it to create a message to send to global")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 70
   $editGlobalMessages2 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages2, @CRLF), $x - 5, $y, 200, 70)
   GUICtrlSetTip($editGlobalMessages2, "Take one item randomly from this list (one per line) and add it to create a message to send to global")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 70
   $editGlobalMessages3 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages3, @CRLF), $x - 5, $y, 200, 70)
   GUICtrlSetTip($editGlobalMessages3, "Take one item randomly from this list (one per line) and add it to create a message to send to global")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 70
   $editGlobalMessages4 = GUICtrlCreateEdit(_ArrayToString($GlobalMessages4, @CRLF), $x - 5, $y, 200, 70)
   GUICtrlSetTip($editGlobalMessages4, "Take one item randomly from this list (one per line) and add it to create a message to send to global")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 70
   GUICtrlCreateGroup("", -99, -99, 1, 1)

   $x = 255
   $y = 150

   GUICtrlCreateGroup("Clan Chat", $x - 20, $y - 20, 225, 375)
   $chkClanChat = GUICtrlCreateCheckbox("Chat in clan chat", $x - 5, $y)
   GUICtrlSetTip($chkClanChat, "Use clan chat to send messages")
   GUICtrlSetState($chkClanChat, $ChatbotChatClan)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkUseResponses = GUICtrlCreateCheckbox("Use custom responses", $x - 5, $y)
   GUICtrlSetTip($chkUseResponses, "Use the keywords and responses defined below")
   GUICtrlSetState($chkUseResponses, $ChatbotClanUseResponses)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkUseCleverbot = GUICtrlCreateCheckbox("Use cleverbot responses", $x - 5, $y)
   GUICtrlSetTip($chkUseCleverbot, "Get responses from cleverbot.com")
   GUICtrlSetState($chkUseCleverbot, $ChatbotClanUseCleverbot)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkUseSimsimi = GUICtrlCreateCheckbox("Use simsimi responses", $x - 5, $y)
   GUICtrlSetTip($chkUseSimsimi, "Get responses from simsimi.com")
   GUICtrlSetState($chkUseSimsimi, $ChatbotClanUseSimsimi)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkUseGeneric = GUICtrlCreateCheckbox("Use generic chats", $x - 5, $y)
   GUICtrlSetTip($chkUseGeneric, "Use generic chats if reading the latest chat failed or there are no new chats")
   GUICtrlSetState($chkUseGeneric, $ChatbotClanAlwaysMsg)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkChatPushbullet = GUICtrlCreateCheckbox("Use PushBullet for clan chatting", $x - 5, $y)
   GUICtrlSetTip($chkChatPushbullet, "Send and recieve chats via pushbullet. Use BOT <myvillage> GETCHATS <interval|NOW|STOP> to get the latest clan chat as an image, and BOT <myvillage> SENDCHAT <chat message> to send a chat to your clan")
   GUICtrlSetState($chkChatPushbullet, $ChatbotUsePushbullet)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25
   $chkPbSendNewChats = GUICtrlCreateCheckbox("Send pb message on new clan chat", $x - 5, $y)
   GUICtrlSetTip($chkPbSendNewChats, "Will send an image of your clan chat via pushbullet when a new chat is detected. Not guaranteed to be 100% accurate.")
   GUICtrlSetState($chkPbSendNewChats, $ChatbotPbSendNew)
   GUICtrlSetOnEvent(-1, "ChatGuiCheckboxUpdate")
   $y += 25

   $editResponses = GUICtrlCreateEdit(_ArrayToString($ClanResponses, ":", -1, -1, @CRLF), $x - 5, $y, 200, 85)
   GUICtrlSetTip($editResponses, "Look for the specified keywords in clan messages and respond with the responses. One item per line, in the format keyword:response")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")
   $y += 90
   $editGeneric = GUICtrlCreateEdit(_ArrayToString($ClanMessages, @CRLF), $x - 5, $y, 200, 85)
   GUICtrlSetTip($editGeneric, "Generic messages to send, one per line")
   GUICtrlSetOnEvent(-1, "ChatGuiEditUpdate")

   GUICtrlCreateTabItem("")
EndFunc

Func ChatGuiCheckboxUpdate()
   $SimsimiOld = $ChatbotClanUseSimsimi
   $CleverbotOld = $ChatbotClanUseCleverbot

   $ChatbotChatGlobal       = GuiCtrlRead($chkGlobalChat)     = $GUI_CHECKED
   $ChatbotScrambleGlobal   = GuiCtrlRead($chkGlobalScramble) = $GUI_CHECKED
   $ChatbotSwitchLang       = GuiCtrlRead($chkSwitchLang)     = $GUI_CHECKED
   $ChatbotChatClan         = GuiCtrlRead($chkClanChat)       = $GUI_CHECKED
   $ChatbotClanUseCleverbot = GuiCtrlRead($chkUseCleverbot)   = $GUI_CHECKED
   $ChatbotClanUseSimsimi   = GuiCtrlRead($chkUseSimsimi)     = $GUI_CHECKED
   $ChatbotClanUseResponses = GuiCtrlRead($chkUseResponses)   = $GUI_CHECKED
   $ChatbotClanAlwaysMsg    = GuiCtrlRead($chkUseGeneric)     = $GUI_CHECKED
   $ChatbotUsePushbullet    = GuiCtrlRead($chkChatPushbullet) = $GUI_CHECKED
   $ChatbotPbSendNew        = GuiCtrlRead($chkPbSendNewChats) = $GUI_CHECKED

   If $ChatbotClanUseSimsimi And $CleverbotOld Then
	  GUICtrlSetState($chkUseCleverbot, 4) ; 4 = unchecked
	  $ChatbotClanUseCleverbot = False
   ElseIf $ChatbotClanUseCleverbot And $SimsimiOld Then
	  GUICtrlSetState($chkUseSimsimi, 4)
	  $ChatbotClanUseSimsimi = False
   EndIf

   If $ChatbotClanUseCleverbot And $ChatbotClanUseSimsimi Then
	  GUICtrlSetState($chkUseSimsimi, 4)
	  $ChatbotClanUseSimsimi = False
   EndIf

   IniWrite($chatIni, "global", "use",      $ChatbotChatGlobal)
   IniWrite($chatIni, "global", "scramble", $ChatbotScrambleGlobal)
   IniWrite($chatIni, "global", "swlang",   $ChatbotSwitchLang)

   IniWrite($chatIni, "clan", "use",        $ChatbotChatClan)
   IniWrite($chatIni, "clan", "cleverbot",  $ChatbotClanUseCleverbot)
   IniWrite($chatIni, "clan", "simsimi",    $ChatbotClanUseSimsimi)
   IniWrite($chatIni, "clan", "responses",  $ChatbotClanUseResponses)
   IniWrite($chatIni, "clan", "always",     $ChatbotClanAlwaysMsg)
   IniWrite($chatIni, "clan", "pushbullet", $ChatbotUsePushbullet)
   IniWrite($chatIni, "clan", "pbsendnew",  $ChatbotPbSendNew)
EndFunc

Func ChatGuiEditUpdate()
   $glb1 = GUICtrlRead($editGlobalMessages1)
   $glb2 = GUICtrlRead($editGlobalMessages2)
   $glb3 = GUICtrlRead($editGlobalMessages3)
   $glb4 = GUICtrlRead($editGlobalMessages4)

   $cResp = GUICtrlRead($editResponses)
   $cGeneric = GUICtrlRead($editGeneric)

   ; how 2 be lazy 101 =======
   $glb1 = StringReplace($glb1, @CRLF, "|")
   $glb2 = StringReplace($glb2, @CRLF, "|")
   $glb3 = StringReplace($glb3, @CRLF, "|")
   $glb4 = StringReplace($glb4, @CRLF, "|")

   $cResp = StringReplace($cResp, @CRLF, "|")
   $cGeneric = StringReplace($cGeneric, @CRLF, "|")

   IniWrite($chatIni, "global", "globalMsg1", $glb1)
   IniWrite($chatIni, "global", "globalMsg2", $glb2)
   IniWrite($chatIni, "global", "globalMsg3", $glb3)
   IniWrite($chatIni, "global", "globalMsg4", $glb4)

   IniWrite($chatIni, "clan", "genericMsg", $cGeneric)
   IniWrite($chatIni, "clan", "responseMsg", $cResp)

   ChatbotReadSettings()
   ; =========================
EndFunc

; FUNCTIONS ================================================
; All of the following return True if the script should
; continue running, and false otherwise
Func ChatbotChatOpen() ; open the chat area
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 20, 349) ; open chat
   If _Sleep(1000) Then Return False
   Return True
EndFunc

Func ChatbotSelectClanChat() ; select clan tab
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 220, 21) ; switch to clan
   If _Sleep(1000) Then Return False
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 220, 21) ; scroll to top
   If _Sleep(1000) Then Return False
   Return True
EndFunc

Func ChatbotSelectGlobalChat() ; select global tab
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 76, 22) ; switch to global
   If _Sleep(1000) Then Return False
   Return True
EndFunc

Func ChatbotChatClose() ; close chat area
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 330, 348) ; close chat
   waitMainScreen()
   Return True
EndFunc

Func ChatbotChatClanInput() ; select the textbox for clan chat
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 112, 97) ; select the textbox
   If _Sleep(1000) Then Return False
   Return True
EndFunc

Func ChatbotChatGlobalInput() ; select the textbox for global chat
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 112, 63) ; select the textbox
   If _Sleep(1000) Then Return False
   Return True
EndFunc

Func ChatbotChatInput($message) ; input the text
   ControlSend ($Title, "", "", $message, 1)
   Return True
EndFunc

Func ChatbotChatSendClan() ; click send
   If _Sleep(1000) Then Return False
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 282, 95) ; send
   If _Sleep(2000) Then Return False
   Return True
EndFunc

Func ChatbotChatSendGlobal() ; click send
   If _Sleep(1000) Then Return False
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 284, 62) ; send
   If _Sleep(2000) Then Return False
   Return True
EndFunc

Func ChatbotStartTimer()
   $ChatbotStartTime = TimerInit()
EndFunc

Func ChatbotIsInterval()
   $Time_Difference = TimerDiff($ChatbotStartTime)
   If $Time_Difference > $ChatbotReadInterval * 1000 Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

; Returns the response from cleverbot or simsimi, if any
Func runHelper($msg, $isCleverbot) ; run a script to get a response from cleverbot.com or simsimi.com
   Dim $DOS, $Message = ''

   $command = ' /c "phantomjs.exe phantom-cleverbot-helper.js '
   If Not $isCleverbot Then
	  $command = ' /c "phantomjs.exe phantom-simsimi-helper.js '
   EndIf

   $DOS = Run(@ComSpec & $command & $msg & '"', "", @SW_HIDE, 8)
   $HelperStartTime = TimerInit()
   SetLog("Waiting for chatbot helper...")
   While ProcessExists($DOS)
	  ProcessWaitClose($DOS, 10)
	  SetLog("Still waiting for chatbot helper...")
	  $Time_Difference = TimerDiff($HelperStartTime)
	  If $Time_Difference > 50000 Then
		 SetLog("Chatbot helper is taking too long!", $COLOR_RED)
		 ProcessClose($DOS)
		 _RunDos("taskkill -f -im phantomjs.exe") ; force kill
		 Return ""
	  EndIf
   WEnd
   $Message = ''
   While 1
	  $Message &= StdoutRead($DOS)
	  If @error Then
		 ExitLoop
	  EndIf
   WEnd
   Return StringStripWS($Message, 7)
EndFunc

Func ChatbotIsLastChatNew() ; returns true if the last chat was not by you, false otherwise
   _CaptureRegion()
   For $x = 38 To 261
	  If _ColorCheck(_GetPixelColor($x, 129), Hex(0x78BC10, 6), 5) Then Return True ; detect the green menu button
   Next
   Return False
EndFunc

Func ChatbotPushbulletSendChat()
   If Not $ChatbotUsePushbullet Then Return
   _CaptureRegion(0, 0, 320, 675)
   Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
   Local $Time = @HOUR & "." & @MIN

   $ChatFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
   _GDIPlus_ImageSaveToFile($hBitmap, $dirLoots & $ChatFile)
   _GDIPlus_ImageDispose($hBitmap)
   ;push the file
   SetLog("Chatbot: Sent chat image", $COLOR_GREEN)
   _PushFile($ChatFile, "Loots", "image/jpeg", $iOrigPushB & " | Last Clan Chats" & "\n" & $ChatFile)
   ;wait a second and then delete the file
   _Sleep(500)
   Local $iDelete = FileDelete($dirLoots & $ChatFile)
   If Not ($iDelete) Then SetLog("Chatbot: Failed to delete temp file", $COLOR_RED)
EndFunc

Func ChatbotPushbulletQueueChat($Chat)
   If Not $ChatbotUsePushbullet Then Return
   _ArrayAdd($ChatbotQueuedChats, $Chat)
EndFunc

Func ChatbotPushbulletQueueChatRead()
   If Not $ChatbotUsePushbullet Then Return
   $ChatbotReadQueued = True
EndFunc

Func ChatbotPushbulletStopChatRead()
   If Not $ChatbotUsePushbullet Then Return
   $ChatbotReadInterval = 0
   $ChatbotIsOnInterval = False
EndFunc

Func ChatbotPushbulletIntervalChatRead($Interval)
   If Not $ChatbotUsePushbullet Then Return
   $ChatbotReadInterval = $Interval
   $ChatbotIsOnInterval = True
   ChatbotStartTimer()
EndFunc

Func ChangeLanguageToEN()
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 820, 524) ;settings
   Sleep(500)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 210, 390)  ;language
   Sleep(1000)
   MouseWheel("up",5)      ;scroll up
   Sleep(1000)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 171, 148)  ;English
   Sleep(500)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 513, 397)  ;language
   Sleep(1000)
EndFunc

Func ChangeLanguageToGER()
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 820, 524) ;settings
   Sleep(500)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 210, 390)  ;language
   Sleep(1000)
   MouseWheel("up",5)      ;scroll up
   Sleep(1000)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 420, 195)  ;german
   Sleep(500)
   ControlClick ( "BlueStacks App Player", "", "", "left", 1, 513, 397)  ;language
   Sleep(1000)
EndFunc

; MAIN SCRIPT ==============================================

Func ChatbotMessage() ; run the chatbot
   If $ChatbotChatGlobal Then
	  SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
   ElseIf $ChatbotChatClan Then
	  SetLog("Chatbot: Sending some chats", $COLOR_GREEN)
   EndIf
   If $ChatbotChatGlobal Then
	  If Not ChatbotChatOpen() Then Return
	  SetLog("Chatbot: Sending chats to global", $COLOR_GREEN)
	  ; assemble a message
	  Local $Message[4]
	  $Message[0] = $GlobalMessages1[Random(0, UBound($GlobalMessages1) - 1, 1)]
	  $Message[1] = $GlobalMessages2[Random(0, UBound($GlobalMessages2) - 1, 1)]
	  $Message[2] = $GlobalMessages3[Random(0, UBound($GlobalMessages3) - 1, 1)]
	  $Message[3] = $GlobalMessages4[Random(0, UBound($GlobalMessages4) - 1, 1)]
	  If $ChatbotScrambleGlobal Then
		 _ArrayShuffle($Message)
	  EndIf
	  ; Send the message
	  If Not ChatbotSelectGlobalChat() Then Return
	  If Not ChatbotChatGlobalInput() Then Return
	  If Not ChatbotChatInput(_ArrayToString($Message, " ")) Then Return
	  If Not ChatbotChatSendGlobal() Then Return
	  If Not ChatbotChatClose() Then Return

	  If $ChatbotSwitchLang Then
		 SetLog("Chatbot: Switching languages", $COLOR_GREEN)
		 ChangeLanguageToGER()
		 waitMainScreen()
		 ChangeLanguageToEN()
		 waitMainScreen()
	  EndIf
   EndIf

   If $ChatbotChatClan Then
	  If Not ChatbotChatOpen() Then Return
	  SetLog("Chatbot: Sending chats to clan", $COLOR_GREEN)
	  If Not ChatbotSelectClanChat() Then Return

	  $SentClanChat = False

	  If $ChatbotReadQueued Then
		 ChatbotPushbulletSendChat()
		 $ChatbotReadQueued = False
		 $SentClanChat = True
	  ElseIf $ChatbotIsOnInterval Then
		 If ChatbotIsInterval() Then
			ChatbotStartTimer()
			ChatbotPushbulletSendChat()
			$SentClanChat = True
		 EndIf
	  EndIf

	  If UBound($ChatbotQueuedChats) > 0 Then
		 SetLog("Chatbot: Sending pushbullet chats", $COLOR_GREEN)

		 For $a = 0 To UBound($ChatbotQueuedChats) - 1
			$ChatToSend = $ChatbotQueuedChats[$a]
			If Not ChatbotChatClanInput() Then Return
			If Not ChatbotChatInput($ChatToSend) Then Return
			If Not ChatbotChatSendClan() Then Return
		 Next

		 Dim $Tmp[0] ; clear queue
		 $ChatbotQueuedChats = $Tmp

		 ChatbotPushbulletSendChat()

		 If Not ChatbotChatClose() Then Return
		 SetLog("Chatbot: Done", $COLOR_GREEN)
		 Return
	  EndIf

	  If ChatbotIsLastChatNew() Then
		 ; get text of the latest message
		 $ChatMsg = StringStripWS(getOcrAndCapture("coc-latinA", 30, 148, 270, 13, False), 7)
		 SetLog("Found chat message: " & $ChatMsg, $COLOR_GREEN)
		 $SentMessage = False

		 If $ChatMsg = "" Or $ChatMsg = " " Then
			If $ChatbotClanAlwaysMsg Then
			   If Not ChatbotChatClanInput() Then Return
			   If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
			   If Not ChatbotChatSendClan() Then Return
			   $SentMessage = True
			EndIf
		 EndIf

		 If $ChatbotClanUseResponses And Not $SentMessage Then
			For $a = 0 To UBound($ClanResponses) - 1
			   If StringInStr($ChatMsg, $ClanResponses[$a][0]) Then
				  $Response = $ClanResponses[$a][1]
				  SetLog("Sending response: " & $Response, $COLOR_GREEN)
				  If Not ChatbotChatClanInput() Then Return
				  If Not ChatbotChatInput($Response) Then Return
				  If Not ChatbotChatSendClan() Then Return
				  $SentMessage = True
				  ExitLoop
			   EndIf
			Next
		 EndIf

		 If ($ChatbotClanUseCleverbot Or $ChatbotClanUseSimsimi) And Not $SentMessage Then
			$ChatResponse = runHelper($ChatMsg, $ChatbotClanUseCleverbot)
			SetLog("Got cleverbot response: " & $ChatResponse, $COLOR_GREEN)
			If StringInStr($ChatResponse, "No response") Or $ChatResponse = "" Or $ChatResponse = " " Then
			   If $ChatbotClanAlwaysMsg Then
				  If Not ChatbotChatClanInput() Then Return
				  If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
				  If Not ChatbotChatSendClan() Then Return
				  $SentMessage = True
			   EndIf
			Else
			   If Not ChatbotChatClanInput() Then Return
			   If Not ChatbotChatInput($ChatResponse) Then Return
			   If Not ChatbotChatSendClan() Then Return
			EndIf
		 EndIf

		 If Not $SentMessage Then
			If $ChatbotClanAlwaysMsg Then
			   If Not ChatbotChatClanInput() Then Return
			   If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
			   If Not ChatbotChatSendClan() Then Return
			EndIf
		 EndIf

		 ; send it via pushbullet if it's new
		 ; putting the code here makes sure the (cleverbot, specifically) response is sent as well :P
		 If $ChatbotUsePushbullet And $ChatbotPbSendNew Then
			If Not $SentClanChat Then ChatbotPushbulletSendChat()
		 EndIf
	  ElseIf $ChatbotClanAlwaysMsg Then
		 If Not ChatbotChatClanInput() Then Return
		 If Not ChatbotChatInput($ClanMessages[Random(0, UBound($ClanMessages) - 1, 1)]) Then Return
		 If Not ChatbotChatSendClan() Then Return
	  EndIf

	  If Not ChatbotChatClose() Then Return
   EndIf
   If $ChatbotChatGlobal Then
	  SetLog("Chatbot: Done chatting", $COLOR_GREEN)
   ElseIf $ChatbotChatClan Then
	  SetLog("Chatbot: Done chatting", $COLOR_GREEN)
   EndIf
EndFunc

#cs ----------------------------------------------------------------------------
   AutoIt Version: 3.3.14.0
   This file was made to software CoCgameBot v4.1
   Author:         DankMemes

   Script Function: Sends chat messages in global and clan chat
CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<http://www.gnu.org/licenses/>.
#ce ----------------------------------------------------------------------------