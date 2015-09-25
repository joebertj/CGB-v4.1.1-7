; #FUNCTION# ====================================================================================================================
; Name ..........: checkArmyCamp
; Description ...: Reads the size it the army camp, the number of troops trained, and
; Syntax ........: checkArmyCamp()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #4,342
; Modified ......: Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func checkArmyCamp()
	Local $aGetArmySize[3] = ["", "", ""]
	Local $sArmyInfo = ""
	Local $sInputbox
	Local $diff

	SetLog("Checking Army Camp...", $COLOR_BLUE)
	If _Sleep($iDelaycheckArmyCamp1) Then Return

	ClickP($aAway, 1, 0, "#0292") ;Click Away
	If _Sleep($iDelaycheckArmyCamp1) Then Return

	Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293") ;Click Army Camp
	If _Sleep($iDelaycheckArmyCamp2) Then Return

	$iCount = 0  ; reset loop counter
	$sArmyInfo = getArmyCampCap(212, 144) ; OCR read army trained and total
	If $debugSetlog = 1 Then Setlog("$sArmyInfo = " & $sArmyInfo, $COLOR_PURPLE)
	While $sArmyInfo = ""  ; In case the CC donations recieved msg are blocking, need to keep checking numbers for 10 seconds
		If _Sleep($iDelaycheckArmyCamp3) Then Return
		$sArmyInfo = getArmyCampCap(212, 144) ; OCR read army trained and total
		If $debugSetlog = 1 Then Setlog(" $sArmyInfo = " & $sArmyInfo, $COLOR_PURPLE)
		$iCount += 1
		If $iCount > 4 Then ExitLoop
	WEnd

	$CurCampOld = $CurCamp
	$aGetArmySize = StringSplit($sArmyInfo, "#") ; split the trained troop number from the total troop number
	If $aGetArmySize[0] > 1 Then ; check if the OCR was valid and returned both values
		$CurCamp = Number($aGetArmySize[1])
		If $debugSetlog = 1 Then Setlog("$CurCamp = " & $CurCamp, $COLOR_PURPLE)
		If $TotalCamp = 0 Then ; check if army camp size is already known
			$TotalCamp = Number($aGetArmySize[2])
		EndIf
		If $debugSetlog = 1 Then Setlog("$TotalCamp = " & $TotalCamp, $COLOR_PURPLE)
	Else
		Setlog("Army size read error, Troop numbers can't be trained correctly", $COLOR_RED) ; log if there is read error
		$CurCamp = 0
	EndIf

	If $TotalCamp = 0 Then ; if Total camp size is still not set
		If $ichkTotalCampForced = 0 Then ; check if forced camp size set in expert tab
			$sInputbox = InputBox("Question", "Enter your total Army Camp capacity", "200", "", Default, Default, Default, Default, 0, $frmbot)
			$TotalCamp = Number($sInputbox)
			Setlog("Army Camp User input = " & $TotalCamp, $COLOR_RED) ; log if there is read error AND we ask the user to tell us.
		Else
			$TotalCamp = Number($iValueTotalCampForced)
		EndIf
	EndIf
	If _Sleep($iDelaycheckArmyCamp4) Then Return

	SetLog("Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp)

	If ($CurCamp >= ($TotalCamp * $fulltroop / 100)) Then
		$fullArmy = True
	EndIf

	If ($CurCamp + 1) = $TotalCamp Then
		$fullArmy = True
	EndIf
		_WinAPI_DeleteObject($hBitmapFirst)
		Local $hBitmapFirst = _CaptureRegion2(140, 165, 705, 220)
		If $debugSetlog = 1 Then SetLog("$hBitmapFirst made", $COLOR_PURPLE)
		If _Sleep($iDelaycheckArmyCamp5) Then Return
		If $debugSetlog = 1 Then SetLog("Calling CGBfunctions.dll/searchIdentifyTroopTrained ", $COLOR_PURPLE)

		Local $FullTemp = DllCall($LibDir & "\CGBfunctions.dll", "str", "searchIdentifyTroopTrained", "ptr", $hBitmapFirst)
		If $debugSetlog = 1 Then SetLog("Dll return $FullTemp :" & $FullTemp[0], $COLOR_PURPLE)
		Local $TroopTypeT = StringSplit($FullTemp[0], "#")
		If $debugSetlog = 1 Then SetLog("$Trooptype split # : " & $TroopTypeT[0], $COLOR_PURPLE)
		Local $TroopName = 0
		Local $TroopQ = 0
		If $debugSetlog = 1 Then SetLog("Start the Loop", $COLOR_PURPLE)

		For $i = 1 To $TroopTypeT[0]
			$TroopName = "Unknown"
			$TroopQ = "0"
			If _sleep($iDelaycheckArmyCamp1) Then Return
			Local $Troops = StringSplit($TroopTypeT[$i], "|")
			If $debugSetlog = 1 Then SetLog("$TroopTypeT[$i] split : " & $i, $COLOR_PURPLE)

			If $Troops[1] = "Barbarian" Then
				$TroopQ = $Troops[3]
				$TroopName = "Barbarians"
				;SetLog("$eBarbCountOld: " & $eBarbCountOld & " $eBarbCount: " & $eBarbCount & " $eBarbTrain: " & $eBarbTrain)
				$eBarbCountOld = $eBarbCount
				$eBarbCount = $TroopQ
				;SetLog("$eBarbCountOld: " & $eBarbCountOld & " $eBarbCount: " & $eBarbCount & " $eBarbTrain: " & $eBarbTrain)
				$diff = $eBarbCount - $eBarbCountOld
				;SetLog("$diff: " & $diff & "$eBarbTrain: " & $eBarbTrain)
				If $eBarbTrain > $diff And $diff > 0 Then $eBarbTrain -= $diff
				;SetLog("$diff: " & $diff & "$eBarbTrain: " & $eBarbTrain)
				If $FirstStart Then $CurBarb -= $TroopQ
			ElseIf $Troops[1] = "Archer" Then
				$TroopQ = $Troops[3]
				$TroopName = "Archers"
				;SetLog("$eArchCountOld: " & $eArchCountOld & " $eArchCount: " & $eArchCount & " $eArchTrain: " & $eArchTrain)
				$eArchCountOld = $eArchCount
				$eArchCount = $TroopQ
				;SetLog("$eArchCountOld: " & $eArchCountOld & " $eArchCount: " & $eArchCount & " $eArchTrain: " & $eArchTrain)
				$diff = $eArchCount - $eArchCountOld
				;SetLog("$diff: " & $diff & "$eArchTrain: " & $eArchTrain)
				If $eArchTrain > $diff And $diff > 0 Then $eArchTrain -= $diff
				;SetLog("$diff: " & $diff & "$eArchTrain: " & $eArchTrain)
				If $FirstStart Then $CurArch -= $TroopQ
			ElseIf $Troops[1] = "Giant" Then
				$TroopQ = $Troops[3]
				$TroopName = "Giants"
				$eGiantCountOld = $eGiantCount
				$eGiantCount = $TroopQ
				$diff = $eGiantCount - $eGiantCountOld
				If $eGiantTrain > $diff And $diff > 0 Then $eGiantTrain -= $diff
				If $FirstStart Then $CurGiant -= $TroopQ

			ElseIf $Troops[1] = "Goblin" Then
				$TroopQ = $Troops[3]
				$TroopName = "Goblins"
				$eGoblCountOld = $eGoblCount
				$eGoblCount = $TroopQ
				$diff = $eGoblCount - $eGoblCountOld
				If $eGoblTrain > $diff And $diff > 0 Then $eGoblTrain -= $diff
				If $FirstStart Then $CurGobl -= $TroopQ

			ElseIf $Troops[1] = "WallBreaker" Then
				$TroopQ = $Troops[3]
				$TroopName = "Wallbreakers"
				$eWallCountOld = $eWallCount
				$eWallCount = $TroopQ
				$diff = $eWallCount - $eWallCountOld
				If $eWallTrain > $diff And $diff > 0 Then $eWallTrain -= $diff
				If $FirstStart Then $CurWall -= $TroopQ

			ElseIf $Troops[1] = "Balloon" Then
				$TroopQ = $Troops[3]
				$TroopName = "Balloons"
				$eBallCountOld = $eBallCount
				$eBallCount = $TroopQ
				$diff = $eBallCount - $eBallCountOld
				If $eBallTrain > $diff And $diff > 0 Then $eBallTrain -= $diff
				If $FirstStart Then $CurBall -= $TroopQ

			ElseIf $Troops[1] = "Healer" Then
				$TroopQ = $Troops[3]
				$TroopName = "Healers"
				$eHealCountOld = $eHealCount
				$eHealCount = $TroopQ
				$diff = $eHealCount - $eHealCountOld
				If $eHealTrain > $diff And $diff > 0 Then $eHealTrain -= $diff
				If $FirstStart Then $CurHeal -= $TroopQ

			ElseIf $Troops[1] = "Wizard" Then
				$TroopQ = $Troops[3]
				$TroopName = "Wizards"
				$eWizaCountOld = $eWizaCount
				$eWizaCount = $TroopQ
				$diff = $eWizaCount - $eWizaCountOld
				If $eWizaTrain > $diff And $diff > 0 Then $eWizaTrain -= $diff
				If $FirstStart Then $CurWiza -= $TroopQ

			ElseIf $Troops[1] = "Dragon" Then
				$TroopQ = $Troops[3]
				$TroopName = "Dragons"
				$eDragCountOld = $eDragCount
				$eDragCount = $TroopQ
				$diff = $eDragCount - $eDragCountOld
				If $eDragTrain > $diff And $diff > 0 Then $eDragTrain -= $diff
				If $FirstStart Then $CurDrag -= $TroopQ

			ElseIf $Troops[1] = "Pekka" Then
				$TroopQ = $Troops[3]
				$TroopName = "Pekkas"
				$ePekkCountOld = $ePekkCount
				$ePekkCount = $TroopQ
				$diff = $ePekkCount - $ePekkCountOld
				If $ePekkTrain > $diff And $diff > 0 Then $ePekkTrain -= $diff
				If $FirstStart Then $CurPekk -= $TroopQ

			ElseIf $Troops[1] = "Minion" Then
				$TroopQ = $Troops[3]
				$TroopName = "Minions"
				;SetLog("Minicountold: " & $eMiniCountOld & " Minicount: " & $eMiniCount & " MiniTrain: " & $eMiniTrain)
				$eMiniCountOld = $eMiniCount
				$eMiniCount = $TroopQ
				$diff = $eMiniCount - $eMiniCountOld
				If $eMiniTrain > $diff And $diff > 0 Then $eMiniTrain -= $diff
				;SetLog("Minicountold: " & $eMiniCountOld & " Minicount: " & $eMiniCount & " MiniTrain: " & $eMiniTrain)
				If $FirstStart Then $CurMini -= $TroopQ

			ElseIf $Troops[1] = "HogRider" Then
				$TroopQ = $Troops[3]
				$TroopName = "Hog Riders"
				$eHogsCountOld = $eHogsCount
				$eHogsCount = $TroopQ
				$diff = $eHogsCount - $eHogsCountOld
				If $eHogsTrain > $diff And $diff > 0 Then $eHogsTrain -= $diff
				If $FirstStart Then $CurHogs -= $TroopQ

			ElseIf $Troops[1] = "Valkyrie" Then
				$TroopQ = $Troops[3]
				$TroopName = "Valkyries"
				$eValkCountOld = $eValkCount
				$eValkCount = $TroopQ
				$diff = $eValkCount - $eValkCountOld
				If $eValkTrain > $diff And $diff > 0 Then $eValkTrain -= $diff
				If $FirstStart Then $CurValk -= $TroopQ

			ElseIf $Troops[1] = "Golem" Then
				$TroopQ = $Troops[3]
				$TroopName = "Golems"
				$eGoleCountOld = $eGoleCount
				$eGoleCount = $TroopQ
				$diff = $eGoleCount - $eGoleCountOld
				If $eGoleTrain > $diff And $diff > 0 Then $eGoleTrain -= $diff
				If $FirstStart Then $CurGole -= $TroopQ

			ElseIf $Troops[1] = "Witch" Then
				$TroopQ = $Troops[3]
				$TroopName = "Witches"
				$eWitcCountOld = $eWitcCount
				$eWitcCount = $TroopQ
				$diff = $eWitcCount - $eWitcCountOld
				If $eWitcTrain > $diff And $diff > 0 Then $eWitcTrain -= $diff
				If $FirstStart Then $CurWitc -= $TroopQ

			ElseIf $Troops[1] = "LavaHound" Then
				$TroopQ = $Troops[3]
				$TroopName = "Lava Hounds"
				$eLavaCountOld = $eLavaCount
				$eLavaCount = $TroopQ
				$diff = $eLavaCount - $eLavaCountOld
				If $eLavaTrain > $diff And $diff > 0 Then $eLavaTrain -= $diff
				If $FirstStart Then $CurLava -= $TroopQ

			EndIf

			If $TroopQ <> 0 Then SetLog(" - No. of " & $TroopName & ": " & $TroopQ)
		Next
	If Not $fullArmy And $FirstStart Then
		$ArmyComp = $CurCamp
	EndIf

	;call BarracksStatus() to read barracks num
	If $FirstStart then
		BarracksStatus(true)
	Else
		BarracksStatus(false)
	EndIf


	If _Sleep(200) Then Return
	ClickP($aAway, 1, 0, "#0295") ;Click Away
	If _Sleep(200) Then Return
	$FirstCampView = True

EndFunc   ;==>checkArmyCamp