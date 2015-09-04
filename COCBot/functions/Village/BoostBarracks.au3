
; #FUNCTION# ====================================================================================================================
; Name ..........: BoostBarracks
; Description ...:
; Syntax ........: BoostBarracks()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #11
; Modified ......: Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func BoostBarracks()
	If $bTrainEnabled = False Then Return

	If _GUICtrlComboBox_GetCurSel($cmbBoostBarracks) > 0 And $boostsEnabled = 1 Then
		If $barrackPos[0] = "" Then
			LocateBarrack()
			SaveConfig()
			If _Sleep($iDelayBoostBarracks2) Then Return
		EndIf
		While 1
			SetLog("Boosting Barracks", $COLOR_BLUE)


			ClickP($aAway,1,0,"#0157")
			If _Sleep($iDelayBoostBarracks1) Then ExitLoop
			Click($barrackPos[0], $barrackPos[1],1,0,"#0158")
			If _Sleep($iDelayBoostBarracks1) Then ExitLoop
			_CaptureRegion()
			$Boost = _PixelSearch(410, 603, 493, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				If $DebugSetlog = 1 Then Setlog("Boost Button X|Y = "&$Boost[0]&"|"&$Boost[1]&", color = "&_GetPixelColor($Boost[0], $Boost[1]), $COLOR_PURPLE)
				Click($Boost[0], $Boost[1],1,0,"#0159")
				If _Sleep($iDelayBoostBarracks1) Then Return
				If _ColorCheck(_GetPixelColor(420, 375, True), Hex(0xD0E978, 6), 20) Then
					Click(420, 375,1,0,"#0160")
					If _Sleep($iDelayBoostBarracks2) Then Return
					If _ColorCheck(_GetPixelColor(586, 267, True), Hex(0xd80405, 6), 20) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
						SetLog("Not enough gems", $COLOR_RED)
					Else
						If _GUICtrlComboBox_GetCurSel($cmbBoostBarracks) > 5 Then
							SetLog('Boost completed. Remaining :' & GUICtrlRead($cmbBoostBarracks), $COLOR_GREEN)
						Else
							_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, (GUICtrlRead($cmbBoostBarracks) - 1))
							SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostBarracks)), $COLOR_GREEN)
						EndIf
					EndIf
				Else
					SetLog("Barracks are already Boosted", $COLOR_RED)
				EndIf
				If _Sleep($iDelayBoostBarracks3) Then ExitLoop
				ClickP($aAway,1,0,"#0161")
			Else
				SetLog("Barracks Boost Button not found", $COLOR_RED)
				If _Sleep($iDelayBoostBarracks1) Then Return
			EndIf

			ExitLoop
		WEnd
	Else
		SetLog(_GUICtrlComboBox_GetCurSel($cmbBoostBarracks))
	EndIf
	If _Sleep($iDelayBoostBarracks3) Then Return
	checkMainScreen(False)  ; Check for errors during function

EndFunc   ;==>BoostBarracks


Func BoostSpellFactory()

	If $bTrainEnabled = False Then Return

	If _GUICtrlComboBox_GetCurSel($cmbBoostSpellFactory) > 0 And $boostsEnabled = 1 Then
		If $barrackPos[0] = "" Then
			LocateBarrack()
			SaveConfig()
			If _Sleep($iDelayBoostSpellFactory2) Then Return
		EndIf
		SetLog("Boost Spell Factory...", $COLOR_BLUE)
		If $SFPos[0] = -1 Then
			LocateSpellFactory()
			SaveConfig()
		Else
			Click($SFPos[0], $SFPos[1],1,0,"#0162")
			If _Sleep($iDelayBoostSpellFactory4) Then Return
			_CaptureRegion()
			$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				If $DebugSetlog = 1 Then Setlog("Boost Button X|Y = "&$Boost[0]&"|"&$Boost[1]&", color = "&_GetPixelColor($Boost[0], $Boost[1]), $COLOR_PURPLE)
				Click($Boost[0], $Boost[1],1,0,"#0163")
				If _Sleep($iDelayBoostSpellFactory1) Then Return
				If _ColorCheck(_GetPixelColor(420, 375, True), Hex(0xD0E978, 6), 20) Then
					Click(420, 375,1,0,"#0164")
					If _Sleep($iDelayBoostSpellFactory2) Then Return
					If _ColorCheck(_GetPixelColor(586, 267, True), Hex(0xd80405, 6), 20) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, 0)
						SetLog("Not enough gems", $COLOR_RED)
					Else
						If _GUICtrlComboBox_GetCurSel($cmbBoostSpellFactory) > 5 Then
							SetLog('Boost completed. Remaining :' & GUICtrlRead($cmbBoostSpellFactory), $COLOR_GREEN)
						Else
							_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, (GUICtrlRead($cmbBoostSpellFactory) - 1))
							SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostSpellFactory)), $COLOR_GREEN)
						EndIf
					EndIf
				Else
					SetLog("Spell Factory is already Boosted", $COLOR_RED)
				EndIf
				If _Sleep($iDelayBoostSpellFactory3) Then Return
				ClickP($aAway,1,0,"#0165")
			Else
				SetLog("Spell Factory Boost Button not found", $COLOR_RED)
				If _Sleep($iDelayBoostSpellFactory1) Then Return
			EndIf
		EndIf
	EndIf
	If _Sleep($iDelayBoostSpellFactory3) Then Return
	checkMainScreen(False)  ; Check for errors during function

EndFunc   ;==>BoostSpellFactory
Func BoostHeros()
	If GUICtrlRead($chkBoostKing) = $GUI_CHECKED Then
		If $KingPos[0] = "" Then
			LocateKing()
			SaveConfig()
			If _Sleep(2000) Then Return
			Click(1, 1) ;Click Away
		EndIf
		SetLog("Boosting King...", $COLOR_BLUE)
		Click($KingPos[0], $KingPos[1]) ;Click King
		If _Sleep(600) Then Return
		_CaptureRegion()
		$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
		If IsArray($Boost) Then
			Click($Boost[0], $Boost[1], 1, 0, "#0163")
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
				Click(420, 375, 1, 0, "#0164")
				If _Sleep(2000) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
					_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, 0)
					SetLog("Not enough gems", $COLOR_RED)
				Else
					SetLog('Boost completed.', $COLOR_GREEN)
				EndIf
			Else
				SetLog("King is already Boosted", $COLOR_RED)
			EndIf
			If _Sleep(500) Then Return
			Click(1, 1)
		Else
			SetLog("King is already Boosted", $COLOR_RED)
			If _Sleep(1000) Then Return
		EndIf
	EndIf

	If GUICtrlRead($chkBoostQueen) = $GUI_CHECKED Then
		If $QueenPos[0] = "" Then
			LocateQueen()
			SaveConfig()
			If _Sleep(2000) Then Return
			Click(1, 1) ;Click Away
		EndIf
		SetLog("Boosting Queen...", $COLOR_BLUE)
		Click($QueenPos[0], $QueenPos[1]) ;Click Queen
		If _Sleep(600) Then Return
			_CaptureRegion()
			$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				Click($Boost[0], $Boost[1], 1, 0, "#0163")
				If _Sleep(1000) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
					Click(420, 375, 1, 0, "#0164")
					If _Sleep(2000) Then Return
					_CaptureRegion()
					If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, 0)
						SetLog("Not enough gems", $COLOR_RED)
				Else
					SetLog('Boost completed.', $COLOR_GREEN)
				EndIf
			Else
				SetLog("Queen is already Boosted", $COLOR_RED)
			EndIf
			If _Sleep(500) Then Return
			Click(1, 1)
		Else
			SetLog("Queen is already Boosted", $COLOR_RED)
			If _Sleep(1000) Then Return
		EndIf
	EndIf
EndFunc   ;==>BoostHeros
