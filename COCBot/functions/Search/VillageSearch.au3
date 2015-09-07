
; #FUNCTION# ====================================================================================================================
; Name ..........: VillageSearch
; Description ...: Searches for a village that until meets conditions
; Syntax ........: VillageSearch()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #6
; Modified ......: kaganus (June 2015), Sardo 2015-07, kaganus (August 2015)
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func VillageSearch() ;Control for searching a village that meets conditions
	$iSkipped = 0
	$DESideFound = False

	If $iCmbSearchMode > 0 And ($LBAQFilter = 1 Or $LBBKFilter = 1) Then
		If $Is_ClientSyncError = True And $LBHeroFilter = 0 Then
			SetLog("Client Sync error Heros already confirmed awake. Skipping Check ", $COLOR_BLUE)
		Else
			LiveRoyalFilter()
		EndIf
	EndIf

	If $debugDeadBaseImage = 1 Then
		If DirGetSize(@ScriptDir & "\SkippedZombies\") = -1 Then DirCreate(@ScriptDir & "\SkippedZombies\")
		If DirGetSize(@ScriptDir & "\Zombies\") = -1 Then DirCreate(@ScriptDir & "\Zombies\")
	EndIf

	If $Is_ClientSyncError = False Then
		For $i = 0 To $iModeCount - 1
			$iAimGold[$i] = $iMinGold[$i]
			$iAimElixir[$i] = $iMinElixir[$i]
			$iAimGoldPlusElixir[$i] = $iMinGoldPlusElixir[$i]
			$iAimDark[$i] = $iMinDark[$i]
			$iAimTrophy[$i] = $iMinTrophy[$i]
		Next
	EndIf

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	If _Sleep($iDelayVillageSearch1) Then Return

	;	; Check Break Shield button again
	;	If _CheckPixel($aBreakShield, $bCapturePixel) Then
	;		ClickP($aBreakShield, 1, 0, "#0154");Click Okay To Break Shield
	;	EndIf

	For $x = 0 To $iModeCount - 1
		If $x = $iCmbSearchMode Or $iCmbSearchMode = 2 Then

			SetLog(_PadStringCenter(" Searching For " & $sModeText[$x] & " ", 54, "="), $COLOR_BLUE)

			Local $MeetGxEtext = "", $MeetGorEtext = "", $MeetGplusEtext = "", $MeetDEtext = "", $MeetTrophytext = "", $MeetTHtext = "", $MeetTHOtext = "", $MeetWeakBasetext = "", $EnabledAftertext = ""

			SetLog(_PadStringCenter(" SEARCH CONDITIONS ", 50, "~"), $COLOR_BLUE)

			If $iCmbMeetGE[$x] = 0 Then $MeetGxEtext = "Meet: Gold and Elixir"
			If $iCmbMeetGE[$x] = 1 Then $MeetGorEtext = "Meet: Gold or Elixir"
			If $iCmbMeetGE[$x] = 2 Then $MeetGplusEtext = "Meet: Gold + Elixir"
			If $iChkMeetDE[$x] = 1 Then $MeetDEtext = ", Dark"
			If $iChkMeetTrophy[$x] = 1 Then $MeetTrophytext = ", Trophy"
			If $iChkMeetTH[$x] = 1 Then $MeetTHtext = ", Max TH " & $iMaxTH[$x] ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $MeetTHOtext = ", TH Outside"
			If $iChkWeakBase[$x] = 1 Then $MeetWeakBasetext = ", Weak Base(Mortar: " & $iCmbWeakMortar[$x] & ", WizTower: " & $iCmbWeakWizTower[$x] & ")"
			If $iChkEnableAfter[$x] = 1 Then $EnabledAftertext = ", Enabled after " & $iEnableAfterCount[$x] & " searches"

			SetLog($MeetGxEtext & $MeetGorEtext & $MeetGplusEtext & $MeetDEtext & $MeetTrophytext & $MeetTHtext & $MeetTHOtext & $MeetWeakBasetext & $EnabledAftertext)

			If $iChkMeetOne[$x] = 1 Then SetLog("Meet One and Attack!")

			SetLog(_PadStringCenter(" RESOURCE CONDITIONS ", 50, "~"), $COLOR_BLUE)
			If $iChkMeetTH[$x] = 1 Then $iAimTHtext[$x] = " [TH]:" & StringFormat("%2s", $iMaxTH[$x]) ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $iAimTHtext[$x] &= ", Out"


			If $iCmbMeetGE[$x] = 2 Then
				SetLog("Aim:           [G+E]:" & StringFormat("%7s", $iAimGoldPlusElixir[$x]) & " [D]:" & StringFormat("%5s", $iAimDark[$x]) & " [T]:" & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & " for: " & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			Else
				SetLog("Aim: [G]:" & StringFormat("%7s", $iAimGold[$x]) & " [E]:" & StringFormat("%7s", $iAimElixir[$x]) & " [D]:" & StringFormat("%5s", $iAimDark[$x]) & " [T]:" & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & " for: " & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			EndIf

		EndIf
	Next

	If $OptBullyMode + $OptTrophyMode + $chkATH > 0 Then
		SetLog(_PadStringCenter(" ADVANCED SETTINGS ", 50, "~"), $COLOR_BLUE)
		Local $YourTHText = "", $AttackTHTypeText = "", $chkATHText = "", $OptTrophyModeText = ""

		If $OptBullyMode = 1 Then
			For $i = 0 To 4
				If $YourTH = $i Then $YourTHText = "TH" & $THText[$i]
			Next
		EndIf

		If $OptBullyMode = 1 Then SetLog("THBully Combo @" & $ATBullyMode & " SearchCount, " & $YourTHText)

		If $chkATH = 1 Then $chkATHText = "AttackTH"
		If $OptTrophyMode = 1 And $AttackTHType = 0 Then $AttackTHTypeText = ", Barch"
		If $OptTrophyMode = 1 And $AttackTHType = 1 Then $AttackTHTypeText = ", Attack1:Normal"
		If $OptTrophyMode = 1 And $AttackTHType = 2 Then $AttackTHTypeText = ", Attack2:Extreme"
		If $OptTrophyMode = 1 And $AttackTHType = 3 Then $AttackTHTypeText = ", Attack3:Gbarch"
		If $OptTrophyMode = 1 And $AttackTHType = 4 Then $AttackTHTypeText = ", Attack4:SmartBarch"
		If $OptTrophyMode = 1 And $AttackTHType = 5 Then $AttackTHTypeText = ", Attack5:MasterGiBAM"
		If $OptTrophyMode = 1 And $AttackTHType = 6 Then $AttackTHTypeText = ", Attack6:PB6"
		If $OptTrophyMode = 1 And $AttackTHType = 7 Then $AttackTHTypeText = ", Attack7:THWizard"
		If $OptTrophyMode = 1 And $AttackTHType = 8 Then $AttackTHTypeText = ", Attack8:THDragon"
		If $OptTrophyMode = 1 Then $OptTrophyModeText = "THSnipe Combo, " & $THaddtiles & " Tile(s), "
		If $OptTrophyMode = 1 Or $chkATH = 1 Then SetLog($OptTrophyModeText & $chkATHText & $AttackTHTypeText)
	EndIf

	SetLog(_StringRepeat("=", 50), $COLOR_BLUE)

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowLB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowTS, $GUI_SHOW)
		GUICtrlSetState($pic2arrow, $GUI_HIDE)
		GUICtrlSetState($lblVersion, $GUI_HIDE)
	EndIf

	If $Is_ClientSyncError = False Then
		$SearchCount = 0
	EndIf

	Local $i = 0
	While 1
		If $iVSDelay > 0 Then
			If _Sleep(1000 * $iVSDelay) Then Return
		EndIf

		Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
		Local $Time = @HOUR & "." & @MIN & "." & @SEC

		If $Restart = True Then Return ; exit func
		GetResources() ;Reads Resource Values
		$manualTH = False
		If $searchTH == "-" And $AlertSearchError = 1 Then
			TrayTip("TH Detection Problem", "TH location can't be determined. Please wait or manually intervene. ", 5)
			If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
				SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
			ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
				SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
			EndIf
			While 1
				$MsgBox = MsgBox(1 + 65536, "Manual TH Select", "Click OK to manually select the base Townhall.", 5, $frmBot)
				If $MsgBox = 1 Then
					$MsgBox = MsgBox(0, "Click TH", "Please click the Townhall.", 2, $frmBot)
					If $MsgBox = 1 Then
						$THx = FindPos()[0]
						$THy = FindPos()[1]
						$MsgBox = MsgBox(4 + 65536, "Confirm TH Location", "Please confirm Townhall coordinates: " & $THx & ", " & $THy, 3, $frmBot)
						If $MsgBox = 6 Then
							$searchTH = checkTownhallADV()
							If $searchTH == "-" Then
								$searchTH = "10"
								SetLog("Forcing TH: " & $searchTH)
							ElseIf $searchTH <> "-" Then
								SetLog("Manual TH: " & $searchTH)
								GetResources($searchTH)
								$manualTH = True
							EndIf
						EndIf
					EndIf
				EndIf
				ExitLoop
			WEnd
			If Not $manualTH Then
				If _Sleep(1000) Then Return
			EndIf
		EndIf
		If $Restart = True Then Return ; exit func
		$bBtnAttackNowPressed = False

		If Mod(($iSkipped + 1), 100) = 0 Then
			_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS memory
			If _Sleep($iDelayVillageSearch1) Then Return
			If CheckZoomOut() = False Then Return
		EndIf

		Local $noMatchTxt = ""
		Local $dbBase = False
		Local $match[$iModeCount]
		Local $isModeActive[$iModeCount]
		For $i = 0 To $iModeCount - 1
			$match[$i] = False
			$isModeActive[$i] = False
		Next

		If $iCmbSearchMode = 0 Then
			$isModeActive[$DB] = True
			$match[$DB] = CompareResources($DB)
		ElseIf $iCmbSearchMode = 1 Then
			$isModeActive[$LB] = True
			$match[$LB] = CompareResources($LB)
		ElseIf $iCmbSearchMode = 2 Then
			For $i = 0 To $iModeCount - 1
				$isModeActive[$i] = IsSearchModeActive($i)
				If $isModeActive[$i] Then
					$match[$i] = CompareResources($i)
				EndIf
			Next
		EndIf

		For $i = 0 To $iModeCount - 1
			If ($match[$i] And $iChkWeakBase[$i] = 1 And $iChkMeetOne[$i] <> 1) Or ($isModeActive[$i] And Not $match[$i] And $iChkWeakBase[$i] = 1 And $iChkMeetOne[$i] = 1) Then
				If IsWeakBase($i) Then
					$match[$i] = True
				Else
					$match[$i] = False
					$noMatchTxt &= ", Not a Weak Base for " & $sModeText[$i]
				EndIf
			EndIf
		Next

		If $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				If $skipBase = False Then
					SetLog(_PadStringCenter(" TH Outside Found! ", 50, "~"), $COLOR_GREEN)
					$iMatchMode = $TS
					ExitLoop
				Else
					If $OptIgnoreTraps = 0 And $OptIgnoreAirTraps = 0 Then
						SetLog("Trap found, skipping base...", $COLOR_RED)
						$i = 0
						While $i < 100
							$i += 1
							If ( _ColorCheck(_GetPixelColor($NextBtn[0], $NextBtn[1], True), Hex($NextBtn[2], 6), $NextBtn[3])) Then
								ClickP($NextBtn, 1, 0, "#0155") ;Click Next
								If $ichkKeepAlive = 1 Then KeepAlive()
								ExitLoop
							Else
								If $debugsetlog = 1 Then SetLog("Wait to see Next Button... " & $i, $COLOR_PURPLE)
							EndIf
							If $i >= 99 Then ; if we can't find the next button or there is an error, then restart
								$Restart = True
								$Is_ClientSyncError = True
								$iStuck = 0
								$Restart = True
								If isProblemAffect(True) Then
									SetLog("Cannot locate Next button, Restarting Bot...", $COLOR_RED)
									Pushmsg("OoSResources")
									GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync) + 1)
									Return
								Else
									SetLog("Have strange problem can not determine, Restarting Bot...", $COLOR_RED)
									Return
								EndIf
							EndIf
							; break every 15 searches when Snipe While Train mode is active
							If $isSnipeWhileTrain Then
								If $iSkipped > 13 Then
									Click(62, 519) ; Click End Battle
									$Restart = True ; To Prevent Initiation of Attack
									ExitLoop
								EndIf
							EndIf
							_Sleep($iDelayVillageSearch2)
						WEnd
						$iSkipped = $iSkipped + 1
						ContinueLoop
					Else
						SetLog("Trap found, attacking anyway...", $COLOR_RED)
					EndIf
				EndIf
			EndIf
		EndIf

		If $match[$DB] Or $match[$LB] Then
			$dbBase = checkDeadBase()
		EndIf

		If $match[$DB] And $dbBase Then
			SetLog(_PadStringCenter(" Dead Base Found! ", 50, "~"), $COLOR_GREEN)
			$iMatchMode = $DB
			If $debugDeadBaseImage = 1 Then
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\Zombies\" & $Date & " at " & $Time & ".jpg")
				_WinAPI_DeleteObject($hBitmap)
			EndIf
			If $iChkDeploySettings[$iMatchMode] = 5 Then
				If PrepareAttackTHPB6() Then ExitLoop
			Else
				ExitLoop
			EndIf
			If $iChkDeploySettings[$iMatchMode] = 6 Then
				If PrepareAttackTHLavaloonion() Then ExitLoop
			Else
				ExitLoop
			EndIf
		ElseIf $match[$LB] And Not $dbBase Then
			SetLog(_PadStringCenter(" Live Base Found! ", 50, "~"), $COLOR_GREEN)
			$iMatchMode = $LB
			If $iChkDeploySettings[$LB] = 7 And ($iSkipUndetectedDE > 0 Or $iSkipCentreDE > 0) Then
				If CheckfoundorcoreDE() = True Then
					SetLog(_PadStringCenter(" DE Side Base Found!- ", 50, "~"), $COLOR_GREEN)
					$iMatchMode = $LB
					$DESideFound = True
					ExitLoop
				EndIf
			ElseIf $iChkDeploySettings[$LB] = 7 Then
				SetLog(_PadStringCenter(" DE Side Base Found! ", 50, "~"), $COLOR_GREEN)
				$iMatchMode = $LB
				$DESideFound = True
				ExitLoop
			EndIf
			If $iChkDeploySettings[$iMatchMode] = 5 Then
				If PrepareAttackTHPB6() Then ExitLoop
			Else
				ExitLoop
			EndIf
			If $iChkDeploySettings[$iMatchMode] = 6 Then
				If PrepareAttackTHLavaloonion() Then ExitLoop
			Else
				ExitLoop
			EndIf
		ElseIf $match[$LB] Or $match[$DB] Then
			If $OptBullyMode = 1 And ($SearchCount >= $ATBullyMode) Then
				If $SearchTHLResult = 1 Then
					SetLog(_PadStringCenter(" Not a match, but TH Bully Level Found! ", 50, "~"), $COLOR_GREEN)
					$iMatchMode = $iTHBullyAttackMode
					ExitLoop
				EndIf
			EndIf
		EndIf

		If $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				SetLog(_PadStringCenter(" TH Outside Found! ", 50, "~"), $COLOR_GREEN)
				$iMatchMode = $TS
				ExitLoop
			EndIf
		EndIf

		If $match[$DB] And Not $dbBase Then
			$noMatchTxt &= ", Not a " & $sModeText[$DB]
			If $debugDeadBaseImage = 1 Then
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\SkippedZombies\" & $Date & " at " & $Time & ".jpg")
				_WinAPI_DeleteObject($hBitmap)
			EndIf
		ElseIf $match[$LB] And $dbBase Then
			$noMatchTxt &= ", Not a " & $sModeText[$LB]
		EndIf

		If $noMatchTxt <> "" Then
			SetLog(_PadStringCenter(" " & StringMid($noMatchTxt, 3) & " ", 50, "~"), $COLOR_PURPLE)
		EndIf

		If $iChkAttackNow = 1 Then
			If _Sleep(1000 * $iAttackNowDelay) Then Return ; add human reaction time on AttackNow button function
		EndIf

		If $bBtnAttackNowPressed = True Then ExitLoop

		Local $i = 0
		While $i < 100
			$i += 1
			If ( _ColorCheck(_GetPixelColor($NextBtn[0], $NextBtn[1], True), Hex($NextBtn[2], 6), $NextBtn[3])) Then
				ClickP($NextBtn, 1, 0, "#0155") ;Click Next
				If $ichkKeepAlive = 1 Then KeepAlive()
				ExitLoop
			Else
				If $debugsetlog = 1 Then SetLog("Wait to see Next Button... " & $i, $COLOR_PURPLE)
			EndIf
			If $i >= 99 Then ; if we can't find the next button or there is an error, then restart
				$Restart = True
				$Is_ClientSyncError = True
				$iStuck = 0
				$Restart = True
				If isProblemAffect(True) Then
					SetLog("Cannot locate Next button, Restarting Bot...", $COLOR_RED)
					Pushmsg("OoSResources")
					GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync) + 1)
					Return
				Else
					SetLog("Have strange problem can not determine, Restarting Bot...", $COLOR_RED)
					Return
				EndIf
			EndIf
			; break every 15 searches when Snipe While Train mode is active
			If $isSnipeWhileTrain Then
				If $iSkipped > 13 Then
					Click(62, 519) ; Click End Battle
					$Restart = True ; To Prevent Initiation of Attack
					ExitLoop
				EndIf
			EndIf
			_Sleep($iDelayVillageSearch2)
		WEnd

		If _Sleep($iDelayVillageSearch3) Then Return

		If isGemOpen(True) = True Then
			Setlog(" Not enough gold to keep searching.....", $COLOR_RED)
			Click(585, 252, 1, 0, "#0156") ; Click close gem window "X"
			If _Sleep($iDelayVillageSearch3) Then Return
			$OutOfGold = 1 ; Set flag for out of gold to search for attack
			ReturnHome(False, False)
			Return
		EndIf

		$iSkipped = $iSkipped + 1
		GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
	WEnd

	If $bBtnAttackNowPressed = True Then
		Setlog(_PadStringCenter(" Attack Now Pressed! ", 50, "~"), $COLOR_GREEN)
	EndIf

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowLB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowTS, $GUI_HIDE)
		GUICtrlSetState($pic2arrow, $GUI_SHOW)
		GUICtrlSetState($lblVersion, $GUI_SHOW)
		$bBtnAttackNowPressed = False
	EndIf

	If $AlertSearch = 1 Then
		TrayTip($sModeText[$iMatchMode] & " Match Found!", "Gold: " & $searchGold & "; Elixir: " & $searchElixir & "; Dark: " & $searchDark & "; Trophy: " & $searchTrophy, "", 0)
		If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		EndIf
	EndIf

	SetLog(_PadStringCenter(" Search Complete ", 50, "="), $COLOR_BLUE)
	PushMsg("MatchFound")

	; TH Detection Check Once Conditions
	If $OptBullyMode = 0 And $OptTrophyMode = 0 And $iChkMeetTH[$iMatchMode] = 0 And $iChkMeetTHO[$iMatchMode] = 0 And $chkATH = 1 Then
		$searchTH = checkTownhallADV()
		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is inside, skip Attack TH")
		ElseIf $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is outside, Attacking Townhall!")
		Else
			SetLog("Checking Townhall location: Could not locate TH, skipping attack TH...")
		EndIf
	EndIf

;~	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS Memory

;~	readConfig()
	_BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys

	$Is_ClientSyncError = False

EndFunc   ;==>VillageSearch

Func IsSearchModeActive($pMode)
	If $iChkEnableAfter[$pMode] = 0 Then Return True
	If $SearchCount = $iEnableAfterCount[$pMode] Then SetLog(_PadStringCenter(" " & $sModeText[$pMode] & " search conditions are activated! ", 50, "~"), $COLOR_BLUE)
	If $SearchCount >= $iEnableAfterCount[$pMode] Then Return True
	Return False
EndFunc   ;==>IsSearchModeActive

Func IsWeakBase($pMode)
	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2()
	Local $resultHere = DllCall($pFuncLib, "str", "CheckConditionForWeakBase", "ptr", $hBitmapFirst, "int", ($iCmbWeakMortar[$pMode] + 1), "int", ($iCmbWeakWizTower[$pMode] + 1), "int", 10)
	Return $resultHere[0] = "Y"
EndFunc   ;==>IsWeakBase
