Func cmbAttackbottomType()
	IniWrite($config, "advanced", "BottomTHType", _GUICtrlComboBox_GetCurSel($cmbAttackbottomType))
EndFunc   ;==>cmbAttackbottomType

Func SwitchAttackBottomTH($numperspot, $spots)

	Switch (_GUICtrlComboBox_GetCurSel($cmbAttackbottomType) + 1)

		Case 1
			AllZoomedAttack($numperspot, $spots)
		Case 2
			ModerateZoomed($numperspot, $spots)
		Case 3
			SideSnipe($numperspot, $spots)
		Case 4
			MaxZoomed2($numperspot, $spots)
		Case 5
			OriginalMaxZoomed($numperspot, $spots)
	EndSwitch

EndFunc   ;==>SwitchAttackBottomTH

Func ChangeSettingsSnipeOnly()

	GUICtrlSetData($txtDBMinGold, "999999")
	GUICtrlSetData($txtDBMinElixir, "999999")
	GUICtrlSetData($txtABMinGold, "999999")
	GUICtrlSetData($txtABMinElixir, "999999")
	GUICtrlSetState($chkTrophyMode, $GUI_CHECKED)
	;chkSnipeModeAdd()
	GUICtrlSetState($chkDBMeetOne, $GUI_UNCHECKED)
	GUICtrlSetState($chkABMeetOne, $GUI_UNCHECKED)
	GUICtrlSetState($chkAttackTH, $GUI_UNCHECKED)
	GUICtrlSetState($chkDBMeetTHO, $GUI_UNCHECKED)
	GUICtrlSetState($chkABMeetTHO, $GUI_UNCHECKED)
	_GUICtrlComboBox_SetCurSel($cmbDBMeetGE, "0")
	_GUICtrlComboBox_SetCurSel($cmbABMeetGE, "0")
	cmbDBGoldElixir()
	cmbABGoldElixir()
	SetLog("Your settings have been changed to Snipe only mode")
EndFunc   ;==>ChangeSettingsSnipeOnly

Func AllZoomedAttack($numperspot, $spots)
	Local $count = 0

	;Zooming and scrolling _______________________________________________________________
	If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
		SendKeepActive($Title)
		SetLog("Attacking Th With Master Zoomed Max Mod ...")
		;Zoom in all the way
		SetLog("Zooming in Max...")
		While $zCount < 5
			If _Sleep(200) Then Return
			ControlSend($Title, "", "", "{UP}")
			If _Sleep(Random(600, 620)) Then Return
			$zCount += 1
		WEnd
		SetLog("Done zooming.")

		;Scroll to bottom
		SetLog("Scrolling to bottom...")

		While $sCount < 8
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(600) Then Return
			$sCount += 1
		WEnd

		ControlSend($Title, "", "", "{CTRLDOWN}{LEFT}{CTRLUP}")
		ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
		ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
		If _Sleep(2000) Then Return
		$zoomedin = True
	EndIf
	;End zooming and scrolling_______________________________________________________________

	;Attacking __________________________________________________________________________
	If $THi = 17 And $Thx > 400 And $Thx < 455 And $Thy > 525 And $Thy < 580 Then

		If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
		For $count = 1 To $numperspot * $spots
			;If CheckForStar(1) Then Return
			Click(Random(350, 500, 1), Random(515, 560, 1))
			If _Sleep(Random(70, 100)) Then Return
		Next

	Else
		If $THside = 1 Then
			If $debugSetlog = 1 Then Setlog("Left Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				;If CheckForStar(1) Then Return
				Click(Random(280, 380, 1), Random(365, 420, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next
		EndIf

		If $THside = 3 Then
			If $debugSetlog = 1 Then Setlog("Right Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				;If CheckForStar(1) Then Return
				Click(Random(780, 855, 1), Random(400, 560, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next
		EndIf

	EndIf
EndFunc   ;==>AllZoomedAttack

Func MaxZoomed2($numperspot, $spots)

	;Zooming and Dragging _______________________________________________________________
	If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
		SendKeepActive($Title)
		;Zoom in all the way
		SetLog("MaxdZoomed2...")
		SetLog("Zooming in Max With Scrolling ...")

		While $zCount < 3 And $sCount < 3
			ControlSend($Title, "", "", "{UP}")
			If _Sleep(600) Then Return
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(600) Then Return
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(600) Then Return
			$zCount += 1
			$sCount += 1
		WEnd

		ControlSend($Title, "", "", "{CTRLDOWN}{LEFT}{CTRLUP}")
		ControlSend($Title, "", "", "{UP}")
		ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
		ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")

		SetLog("Done zooming.")
		If _Sleep(2000) Then Return
		$zoomedin = True
		;End zooming and Dragging_______________________________________________________________
		;Attacking __________________________________________________________________________
		If $THi = 17 And $Thx > 400 And $Thx < 455 And $Thy > 525 And $Thy < 580 Then

			If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				;If CheckForStar(1) Then Return
				Click(Random(350, 500, 1), Random(515, 560, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next

		Else
			If $THside = 1 Then
				If $debugSetlog = 1 Then Setlog("Left Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
				For $count = 1 To $numperspot * $spots
					;If CheckForStar(1) Then Return
					Click(Random(280, 380, 1), Random(365, 420, 1))
					If _Sleep(Random(70, 100)) Then Return
				Next
			EndIf

			If $THside = 3 Then
				If $debugSetlog = 1 Then Setlog("Right Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
				For $count = 1 To $numperspot * $spots
					;If CheckForStar(1) Then Return
					Click(Random(780, 855, 1), Random(400, 560, 1))
					If _Sleep(Random(70, 100)) Then Return
				Next
			EndIf


		EndIf
	EndIf
EndFunc   ;==>MaxZoomed2



Func ModerateZoomed($numperspot, $spots)
	Local $count


	;Zooming and scrolling _______________________________________________________________
	If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
		SendKeepActive($Title)
		SetLog("Attacking Th With Master Moderate Zoomed Mod ...")
		;Few zooming and Scrolling to bottom
		SetLog("Zooming in a little and scrolling to bottom ...")
		While $zCount < 2 And $sCount < 2
			ControlSend($Title, "", "", "{UP}")
			If _Sleep(300) Then Return
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(400) Then Return
			$zCount += 1
			$sCount += 1
		WEnd
		If $debugSetlog = 1 Then SetLog("Done zooming.")
		_Sleep(500)
		$zoomedin = True
	EndIf
	;End zooming and scrolling ____________________________________________________________

	;Attacking ________________________________________________________________________
	If $THi = 17 And $Thx > 400 And $Thx < 455 And $Thy > 525 And $Thy < 580 Then

		If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
		For $count = 1 To $numperspot * $spots

			;;If CheckForStar(1) Then Return
			Click(Random(450, 510, 1), Random(564, 566, 1))
			If _Sleep(Random(70, 100)) Then Return
		Next

	Else
		If $THside = 1 Then
			If $debugSetlog = 1 Then Setlog("Left Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots

				;If CheckForStar(1) Then Return
				Click(Random(290, 340, 1), Random(564, 566, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next
		EndIf

		If $THside = 3 Then
			If $debugSetlog = 1 Then Setlog("Right Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots

				;If CheckForStar(1) Then Return
				Click(Random(630, 700, 1), Random(564, 566, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next

		EndIf
	EndIf
EndFunc   ;==>ModerateZoomed

Func SideSnipe($numperspot, $spots)
	Local $count
	Local $i = 0
	SetLog("Attacking Th With Master No Zoom side attack Mod ...")

	;Attacking ________________________________________________________________________
	If $THi = 17 And $Thx > 400 And $Thx < 455 And $Thy > 525 And $Thy < 580 Then
		If $debugSetlog = 1 Then Setlog("Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
		For $count = 1 To $numperspot * $spots
			If $i = 0 Then

				;If CheckForStar(1) Then Return
				Click(Random(355, 365, 1), Random(564, 566, 1))
				$i = 1
			Else

				;If CheckForStar(1) Then Return
				Click(Random(488, 500, 1), Random(564, 566, 1))
				$i = 0
			EndIf
			If _Sleep(Random(70, 100)) Then Return
		Next
	Else

		If $THside = 1 Or $THside = 3 Then
			If $debugSetlog = 1 Then Setlog("Not Center Bottom deployment THi = " & $THi & " ,x = " & $Thx & " ,y = " & $Thy)
			For $count = 1 To $numperspot * $spots
				;If CheckForStar(1) Then Return
				Click(Random($Thx - 5, $Thx + 5, 1), Random(564, 566, 1))
				If _Sleep(Random(70, 100)) Then Return
			Next
		EndIf


	EndIf

EndFunc   ;==>SideSnipe


Func OriginalMaxZoomed($numperspot, $spots)
	Local $count
	If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
		;Zoom in all the way
		SetLog("Zooming in...")
		While $zCount < 6
			If _Sleep(300) Then Return
			ControlSend($Title, "", "", "{UP}")
			If _Sleep(100) Then Return
			$zCount += 1
		WEnd
		SetLog("Done zooming.")
		If _Sleep(500) Then Return

		;Scroll to bottom
		SetLog("Scrolling to bottom...")
		While $sCount < 7
			If _Sleep(300) Then Return
			ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
			If _Sleep(100) Then Return
			$sCount += 1
		WEnd
		$zoomedin = True
	EndIf

	If $THside = 1 Then
		;						Setlog("LL Bottom deployment $THi="&$THi)
		For $count = 0 To $numperspot - 1
			For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
				$aThx = 830 - $ii * 19
				$aThy = 314 + $ii * 14

				;If CheckForStar(1) Then Return
				Click(730, 450)
				If _Sleep(Random(30, 60)) Then Return
			Next
			If _Sleep(Random(40, 100)) Then Return
		Next
	EndIf

	If $THside = 3 Then
		;						Setlog("LR Bottom deployment $THi="&$THi)
		For $count = 0 To $numperspot - 1
			For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
				$aThx = 830 - $ii * 19
				$aThy = 314 + $ii * 14

				;If CheckForStar(1) Then Return
				Click(730, 450)
				If _Sleep(Random(30, 60)) Then Return
			Next
			If _Sleep(Random(40, 100)) Then Return
		Next
	EndIf

EndFunc   ;==>OriginalMaxZoomed
