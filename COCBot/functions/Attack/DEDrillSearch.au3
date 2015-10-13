; #FUNCTION# ====================================================================================================================

; Name ..........: DEDrillSearch
; Description ...: Searches for the DE Drills in base, and returns; X&Y location, Bldg Level
; Syntax ........: DEDrillSearch([$bReTest = False])
; Parameters ....: $bReTest             - [optional] a boolean value. Default is False.
; Return values .: $aDrills Array with data on Dark Elixir Drills found in search
; Author ........: KnowJack (May 2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func SmartLightSpell()
	If GUICtrlRead($chkSmartLightSpell) = $GUI_CHECKED Then
		GUICtrlSetState($txtMinDark, $GUI_ENABLE)
		$ichkSmartLightSpell = 1
	Else
		GUICtrlSetState($txtMinDark, $GUI_DISABLE)
		$ichkSmartLightSpell = 0
	EndIf
IniWrite($config, "advanced", "SmartLightSpell",$ichkSmartLightSpell)
EndFunc   ;==>GUILightSpell

Func UpZapStates()
; DE Smart Zap
	GUICtrlSetData($lblSmartZap, _NumberFormat($smartZapGain))
    GUICtrlSetData($lblLightningUsed, _NumberFormat($NumLTSpellsUsed))
EndFunc


Func DEDrillSearch($bReTest = False)
	Local Const $DrillLevelSteal[6] = [59, 102, 172, 251, 343, 479] ; Amount of DE available from Drill at each level (1-6) with 1 average (lvl4) lightning spell
	Local Const $DrillLevelHold[6] = [120, 225, 405, 630, 960, 1350] ; Total Amount of DE available from Drill at each level (1-6) by attack
	Local $aDrills[4][4] = [[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]
	Local $pixel[2], $result, $listPixelByLevel, $pixelWithLevel, $level, $pixelStr
	Local $NumDEDrill = 0

	If $ichkSmartLightSpell <> 1 Then Return False

	; Checks the screen and stores the results as $result
	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2()
	$result = DllCall($LibDir & "\MBRfunctions.dll", "str", "getLocationDarkElixirExtractorWithLevel", "ptr", $hBitmapFirst)

	; Debugger
	If $debugsetlog = 1 Then Setlog("Drill search $result[0] = " & $result[0], $COLOR_PURPLE) ;Debug

	$listPixelByLevel = StringSplit($result[0], "~") ; split each building into array
	If UBound($listPixelByLevel) > 1 Then ; check for more than 1 bldg and proper split a part
		$NumDEDrill = UBound($listPixelByLevel) - 1
		SetLog("Total No. of Dark Elixir Drills = " & $NumDEDrill, $COLOR_FUCHSIA)
		If $debugsetlog = 1 Then
			For $ii = 0 To $listPixelByLevel[0]
				Setlog("Drill search $listPixelByLevel[" & $ii & "] = " & $listPixelByLevel[$ii], $COLOR_PURPLE) ;Debug
			Next
		EndIf
	EndIf


	If $NumDEDrill <> 0 Then
		For $i = 0 To $NumDEDrill
			If $NumDEDrill > 1 Then
				$pixelWithLevel = StringSplit($listPixelByLevel[$i], "#")
				If @error Then ContinueLoop ; If the string delimiter is not found, then try next string.
			Else
				$pixelWithLevel = StringSplit($result[$i], "#")
			If @error Then ContinueLoop
			EndIf

			If $debugsetlog = 1 Then
				Setlog("Drill search UBound($pixelWithLevel) = " & UBound($pixelWithLevel), $COLOR_PURPLE) ;Debug
				For $ii = 0 To UBound($pixelWithLevel) - 1
					Setlog("Drill search $pixelWithLevel[" & $ii & "] = " & $pixelWithLevel[$ii], $COLOR_PURPLE) ;Debug
				Next
			EndIf

			$level = $pixelWithLevel[1]
			$pixelStr = StringSplit($pixelWithLevel[2], "-")
			If $debugsetlog = 1 Then
				Setlog("Drill search $level = " & $level, $COLOR_PURPLE) ;Debug
				For $ii = 0 To UBound($pixelStr) - 1
					Setlog("Drill search $pixelStr[" & $ii & "] = " & $pixelStr[$ii], $COLOR_PURPLE) ;Debug
				Next
			EndIf

			Local $pixel[2] = [$pixelStr[1], $pixelStr[2]]
			If isInsideDiamond($pixel)  Then
				$aDrills[$i][0] = Number($pixel[0])
				$aDrills[$i][1] = Number($pixel[1])
				$aDrills[$i][2] = Number($level)
				$aDrills[$i][3] = $DrillLevelHold[Number($level) - 1]
				If $debugsetlog = 1 Then SetLog("Dark Elixir Drill: [" & $aDrills[$i][0] & "," & $aDrills[$i][1] & "], Level: " & $aDrills[$i][2] & " " & $aDrills[$i][3], $COLOR_BLUE)
			Else
				If $debugsetlog = 1 Then SetLog("Dark Elixir Drill: [" & $pixel[0] & "," & $pixel[1] & "], Level: " & $level, $COLOR_PURPLE)
				If $debugsetlog = 1 Then SetLog("Found Drill Storage with Invalid Location?", $COLOR_RED)
			EndIf
		Next
	EndIf
	Return $aDrills
EndFunc   ;==>DEDrillSearch

#cs ----------------------------------------------------------------------------
   AutoIt Version: 3.3.6.1
   This file was made to software CoCgameBot v2.0
   Author:         KnowJack - (modified by drei3000)

   Script Function: Locates DE Drills and returns their locations and levels
CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<http://www.gnu.org/licenses/>.
#ce ----------------------------------------------------------------------------
