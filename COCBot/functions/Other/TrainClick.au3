
; #FUNCTION# ====================================================================================================================
; Name ..........: TrainClick
; Description ...: Clicks in troop training window with special checks for Barracks Full, and If not enough elxir to train troops or to close the gem window if opened.
; Syntax ........: TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $aLootSpot, $debugtxt = "")
; Parameters ....: $x                   - X location to click
;                  $y                   - Y location to click
;                  $iTimes              - Number fo times to cliok
;                  $iSpeed              - Wait time after click
;                  $aWatchSpot          - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click if full
;                  $aLootSpot           - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click, color used to see if out of Elixir for more troops
;						 $sdebugtxt				 - String with click debug text
; Return values .: True = success, False = failure
; Author ........: KnowJack (July 2015)
; Modified ......: Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $aLootSpot, $sdebugtxt = "")
	Local $trainSuccess = False

	If IsTrainPage() Then
		If $debugClick = 1 Then
			Local $txt = _DecodeDebug($sdebugtxt)
			SetLog("TrainClick " & $x & "," & $y & "," & $iTimes & "," & $iSpeed & " " & $sdebugtxt & $txt, $COLOR_ORANGE, "Verdana", "7.5", 0)
		EndIf

		If $iTimes <> 1 Then
			For $i = 0 To ($iTimes - 1)
				If isProblemAffect(True) Then checkMainScreen(False) ; Check for BS/CoC errors
				;If $DebugSetlog = 1 Then SetLog("Full Check=" & _GetPixelColor($aWatchSpot[0], $aWatchSpot[1], True), $COLOR_PURPLE)
				If _CheckPixel($aWatchSpot, True) = True Then ExitLoop  ; Check to see if barrack full
				If _CheckPixel($aLootSpot, True) = True Then  ; Check to see if out of Elixir
					SetLog("Elixir Check Fail: Color = " & _GetPixelColor($aLootSpot[0], $aLootSpot[1], True), $COLOR_PURPLE)
					$OutOfElixir = 1
					If _Sleep($iDelayTrainClick1) Then Return
					If IsGemOpen(True) = True Then ClickP($aAway) ;Click Away
					ExitLoop
				EndIf

				ControlClick($Title, "", "", "left", "1", $x, $y) ;Click once.
				$trainSuccess = True
				If _Sleep($iSpeed, False) Then ExitLoop
			Next
		Else
			If isProblemAffect(True) Then checkMainScreen(False)
			If $DebugSetlog = 1 Then SetLog("Full Check=" & _GetPixelColor($aWatchSpot[0], $aWatchSpot[1], True), $COLOR_PURPLE)
			If _CheckPixel($aWatchSpot, True) = True Then Return False; Check to see if barrack full
			If _CheckPixel($aLootSpot, True) = True Then  ; Check to see if out of Elixir
				SetLog("Elixir Check Fail: Color = " & _GetPixelColor($aLootSpot[0], $aLootSpot[1], True), $COLOR_PURPLE)
				$OutOfElixir = 1
				If _Sleep($iDelayTrainClick1) Then Return
				If IsGemOpen(True) = True Then ClickP($aAway) ;Click Away
				Return False
			EndIf

			ControlClick($Title, "", "", "left", "1", $x, $y)
			$trainSuccess = True

			If _Sleep($iSpeed, False) Then Return
			If _CheckPixel($aLootSpot, True) = True Then ; Check to see if out of Elixir
				SetLog("Elixir Check Fail: Color = " & _GetPixelColor($aLootSpot[0], $aLootSpot[1], True), $COLOR_PURPLE)
				$OutOfElixir = 1
				If _Sleep($iDelayTrainClick1) Then Return
				If IsGemOpen(True) = True Then ClickP($aAway) ;Click Away
				Return False
			EndIf
		EndIf
	Else
		Return False
	EndIf
	;SetLog("$trainSuccess: " & $trainSuccess)
	Return $trainSuccess
EndFunc   ;==>TrainClick

			; Temp fix for DE troop training
			Func TrainClickMini($point, $iTimes, $iSpeed)
			  If $iTimes <> 1 Then
			 For $i = 0 To ($iTimes - 1)
			ControlClick($Title, "", "", "left", "1", $point[0], $point[1])  ;Click once.
			If _Sleep($iSpeed, False) Then ExitLoop
			 Next
			  EndIf
			EndFunc
; TrainClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func TrainClickP($point, $howMany, $speed, $aWatchSpot, $aLootSpot, $debugtxt = "")
	If IsTrainPage() Then
		TrainClick($point[0], $point[1], $howMany, $speed, $aWatchSpot, $aLootSpot, $debugtxt)
	Else
		Return False
	EndIf
EndFunc   ;==>TrainClickP
