; #FUNCTION# ====================================================================================================================

; Name ..........: DEDropSmartSpell, checkDE
; Description ...: DEDropSmartSpell - Grabs DE drill info. Selects Lightning spell and drops the spell at a
; 				   point, depending on criteria
; Syntax ........: DEDropSmartSpell(), checkDE()
; Parameters ....:
; Return values .: DEDropSmartSpell - None; checkDE - False or value if found
; Author ........: drei3000 (July 2015)
; Modified ......: By The Master
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
; DE Smart Zap
Global $iDrills[4][4] = [[-1, -1, -1, -1], [-1, -1, -1, -1], [-1, -1, -1, -1], [-1, -1, -1, -1]] ; [LocX, LocY, BldgLvl, Quantity=filled by other functions]


Func DEDropSmartSpell()
	Local Const $DrillLevelSteal[6] = [59, 102, 172, 251, 343, 479] ; Amount of DE available from Drill at each level (1-6) with 1 average (lvl4) lightning spell
	Local Const $DrillLevelHold[6] = [120, 225, 405, 630, 960, 1350] ; Total Amount of DE available from Drill at each level (1-6) by attack
	Local Const $strikeOffsets = [7, 10]
	Local $searchDark, $aDarkDrills, $oldDark, $Spell, $numSpells, $testX, $testY, $tempTestX, $tempTestY, $strikeGain, $expectedDE
	Local $error = 5 ;5pixel error margin for de drill search

	; If smartZap is not checked, exit.
	If $ichkSmartLightSpell <> 1 Then Return False

	;Get Dark Elixir value, if no DE value exists, exit.
	$searchDark = checkDE()
	If $searchDark = False Then Return False
	; Check match mode
	If $debugsetlog = 1 Then SetLog("Search Mode: "&$iCmbSearchMode, $COLOR_PURPLE)
	If $iCmbSearchMode <> 0 Then Return False

	; Get Drill locations and info
	$aDarkDrills = DEDrillSearch()

	$numSpells = 0
	;Select Lightning Spell and update number of spells left
	For $i = 0 To UBound($atkTroops) - 1
		If $atkTroops[$i][0] = $eLSpell Then
			$Spell = $i
			$numSpells = $atkTroops[$i][1]
			SelectDropTroop($Spell)
		EndIf
	Next
	If $debugsetlog = 1 Then SetLog("Number of Lightning Spells: "&$numSpells, $COLOR_PURPLE)

	; Offset the zap criteria for th8 and lower
	Local $drillLvlOffset = 0
	If $iTownHallLevel = 8 Then
		$drillLvlOffset = 1
	ElseIf $iTownHallLevel < 8 Then
		$drillLvlOffset = 2
	EndIf
	If $debugsetlog = 1 Then SetLog("Drill Level Offset is: "&$drillLvlOffset, $COLOR_PURPLE)

	; Offset the number of spells to align with townhall lvl
	Local $spellAdjust = -1
	If $iTownHallLevel = 10 Then
		$spellAdjust = 0
	ElseIf $iTownHallLevel = 9 Then
		$spellAdjust = 1
	ElseIf $iTownHallLevel = 8 or $iTownHallLevel = 7 Then
		$spellAdjust = 2
	ElseIf $iTownHallLevel = 6 Then
		$spellAdjust = 3
	ElseIf $iTownHallLevel = 5 Then
		$spellAdjust = 4
	Else
		$spellAdjust = -1
	EndIf
	If $debugsetlog = 1 Then SetLog("Spell Adjust is: "&$spellAdjust, $COLOR_PURPLE)

	; Sort by remaining DE
	_ArraySort($aDarkDrills, 1, 0, 0, 3)
	If $debugsetlog = 1 Then SetLog("Levels of drills: " & $aDarkDrills[0][3] & " " & $aDarkDrills[1][3] & " " & $aDarkDrills[2][3] & " " & $aDarkDrills[3][3], $COLOR_PURPLE)

	While $numSpells > 0 and $aDarkDrills[0][3] <> -1 and $spellAdjust <> -1


		If ($searchDark < Number($itxtMinDark)) Then
        SetLog ("Dark Elixir Is below minimum Value")
        Return
		EndIf

		CheckHeroesHealth()
		; If you have all five spells, drop lightning on any level de drill
		If $numSpells > (4 - $spellAdjust) Then
			If $debugsetlog = 1 Then SetLog("First condition: Attack any drill.", $COLOR_PURPLE)
			Click($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)
			$NumLTSpellsUsed += 1
			;MouseMove($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)

			$numSpells -= 1
			If _Sleep(3500) Then Return
			;btnMakeScreenshot()

		; elseif, 4 spells remaining and collector is high enough, drop lightning
		ElseIf $numSpells > (3 - $spellAdjust) and $aDarkDrills[0][2] > (3-$drillLvlOffset) Then
			If $debugsetlog = 1 Then SetLog("Second condition: Attack Lvl4+ drills if you have 4 spells", $COLOR_PURPLE)
			Click($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)
			$NumLTSpellsUsed += 1
			;MouseMove($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)

			$numSpells -= 1
			If _Sleep(3500) Then Return
			;btnMakeScreenshot()

		; elseif the collector is higher than lvl 4 and collector is more than 30% full
		ElseIf ($aDarkDrills[0][3]/$DrillLevelHold[$aDarkDrills[0][2] - 1]) > 0.3 and $aDarkDrills[0][2] > (4 - $drillLvlOffset) Then
			If $debugsetlog = 1 Then SetLog("Third condition: Attack Lvl5+ drills if you have less than 4 spells", $COLOR_PURPLE)
			Click($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)
			$NumLTSpellsUsed += 1
			;MouseMove($aDarkDrills[0][0] + $strikeOffsets[0], $aDarkDrills[0][1] + $strikeOffsets[1], 1)

			$numSpells -= 1
			If _Sleep(3500) Then Return
			;btnMakeScreenshot()

		Else
			If $debugsetlog = 1 Then SetLog("No suitable drills. Removing current drill from list.", $COLOR_PURPLE)
			For $i = 0 To UBound($aDarkDrills) - 1
				$aDarkDrills[0][$i] = -1
			Next
		EndIf

		$oldDark = $searchDark
		If $debugsetlog = 1 Then SetLog("Finished If Statement.", $COLOR_PURPLE)
		;In case proper color isn't detected for the DE
		$searchDark = checkDE()
		If $searchDark = False Then ExitLoop

		$strikeGain = $oldDark - $searchDark
		If $aDarkDrills[0][2] <> -1 Then
			$expectedDE = ($DrillLevelSteal[($aDarkDrills[0][2] - 1)] * 0.75)
		Else
			$expectedDE = -1
		EndIf

		;If change in DE is less than expected, remove the Drill from list. else, subtract change from assumed total
		If $strikeGain < $expectedDE and $expectedDE <> -1 Then
			For $i = 0 To UBound($aDarkDrills) - 1
				$aDarkDrills[0][$i] = -1
			Next
			If $debugsetlog = 1 Then SetLog("Gained: "&$strikeGain&" Expected: "& $expectedDE, $COLOR_PURPLE)
		Else
			$aDarkDrills[0][3] -= $strikeGain
			If $debugsetlog = 1 Then SetLog("Gained: "&$strikeGain&". Adjusting amount left in this drill.", $COLOR_PURPLE)
		EndIf

		$smartZapGain += $strikeGain
		SetLog("DE from zap: "&$strikeGain& " Total DE from smartZap: "&$smartZapGain, $COLOR_FUCHSIA)

		; Test current drill location to check if it still exists (within error)
		; AND get total theoretical amount in drills to compare against available amount
		$aDrills = DEDrillSearch()
		If $aDarkDrills[0][0] <> -1 Then
			;Initialize tests.
			$testX = -1
			$testY = -1
			For $i = 0 to 3
				If $aDrills[$i][0] <> -1 Then
					$tempTestX = abs($aDrills[$i][0] - $aDarkDrills[0][0])
					$tempTestY = abs($aDrills[$i][1] - $aDarkDrills[0][1])
					;If the tests are less than error, give pass onto test phase
					If $tempTestX < $error and $tempTestY < $error Then
						$testX = $tempTestX
						$testY = $tempTestY
					EndIf
					If $debugsetlog = 1 Then SetLog("tempX: "&$tempTestX&" tempY: "&$tempTestY, $COLOR_PURPLE)
				EndIf
			Next

			SetLog("testX: "&$testX&" testY: "&$testY, $COLOR_PURPLE)
			; Test Phase, if test error is greater than expected, or test error is default value.
			If ($testX > $error or $testY > $error) and ($testX <> -1 or $testY <> -1) Then
				For $i = 0 To UBound($aDarkDrills) - 1
					$aDarkDrills[0][$i] = -1
					$numDrills += 1
				Next
				SetLog("Removing drill since it wasn't found.", $COLOR_PURPLE)
			EndIf
		EndIf

		; Sort array by the assumed capacity available, and if all drills removed from array, then exit while loop
		_ArraySort($aDarkDrills, 1, 0, 0, 3)
		If $debugsetlog = 1 Then SetLog("DE Left in Collectors: " & $aDarkDrills[0][3]&" "& $aDarkDrills[1][3]&" "& $aDarkDrills[2][3]&" "& $aDarkDrills[3][3], $COLOR_PURPLE)

	WEnd
EndFunc

; Checks the value of DE on opponents base. Returns value if there is DE, otherwise returns false.
Func checkDE()
	Local $searchDark, $oldsearchDark, $icount
	If _ColorCheck(_GetPixelColor(30, 142, True), Hex(0x07010D, 6), 10) Then ; check if the village have a Dark Elixir Storage
		$searchDark = ""
		While $searchDark = "" Or $searchDark <> $oldsearchDark
			$oldsearchDark = $searchDark
			$searchDark = getDarkElixirVillageSearch(48, 69 + 57) ; Get updated Dark Elixir value
			$icount += 1
			If $debugsetlog = 1 Then Setlog("$searchDark= "&$searchDark&", $oldsearchDark= "&$oldsearchDark, $COLOR_PURPLE)
			If $icount > 15 Then ExitLoop ; check couple of times in case troops are blocking image
			If _Sleep(350) Then Return
		WEnd
		Return $searchDark
	Else
		If $debugsetlog = 1 Then SetLog("No DE Detected.", $COLOR_PURPLE)
		Return False
	EndIf
EndFunc

#cs ----------------------------------------------------------------------------
   AutoIt Version: 3.3.6.1
   This file was made to software CoCgameBot v2.0
   Author:         drei3000 (July 2015)

   Script Function: DEDropSmartSpell - Grabs DE drill info. Selects Lightning spell and drops the spell at a
 				   point, depending on criteria
CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<http://www.gnu.org/licenses/>.
#ce ----------------------------------------------------------------------------
