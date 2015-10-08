; #FUNCTION# ====================================================================================================================
; Name ..........: AttackTHAllIn
; Description ...: A polymorph build TH Snipe attack type
; Syntax ........: AttackTHAllIn(), GetTroopCount(), GetTroopSlot(), CheckForStar(), SpellTH(), KingTH(), QueenTH(), CCTH(),
;                  GetDropTHDistance(), TroopTH(), GetDropTH()
; Parameters ....: None
; Return values .: None
; Author ........: mojacka
; Modified ......: 8/25/2015
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func AttackTHAllIn()
	Local $i, $j
	Local $eKingCount
	Local $eQueenCount
	Local $eCastleCount
	Local $eKingSlot = -1
	Local $eQueenSlot = -1
	Local $eCastleSlot = -1
	Local $DropCoord[4][2] = [[0, 0], [0, 0], [0, 0], [0, 0]]
	Local $DropTH[2] = [0, 0]
	Local $setOffGroundTrap = False
	Local $setOffAirTrap = False
	Local $waveUsed = False
	;Local $x, $Bx, $Hx, $Dx
	;Local $y, $By, $Hy, $Dy
	$spotsNum = 5;

	SetLog("THside: " & $THside & " THi: " & $THi)
	Setlog("TH coordinates: ")
	Setlog("THx: " & $THx & " THy: " & $THy)
	$DropTH = GetDropTH($THx, $THy, $THside)
	Setlog("x: " & $DropTH[0] & " y: " & $DropTH[1])
	$DropCoord = GetDropTHDistance($THx, $THy, $DropTH[0], $DropTH[1], $THside)
	If $skipBase = False Then
		$eArchCount = GetTroopCount($eArch)
		If $eArchCount >= 10 Then
			Setlog("Archer wave")
			$setOffGroundTrap = SetOffTraps($THx, $THy, $eArch, 3, $setOffGroundTrap)
			TroopTH($THx, $THy, $eArch, $spotsNum, Random(2, 3, 1), 500)
			$waveUsed = True
			PrepareAttack($iMatchMode, True) ;Check remaining quantities
			If CheckForStar(45) = True Then
				If $optGreedy = 1 Then
					Greedy($spotsNum,$eKingSlot,$eQueenSlot)
				EndIf
				Return
			EndIf
		Else
			Setlog("Too few archers...skipping wave")
		EndIf

		$eBarbCount = GetTroopCount($eBarb)
		$eArchCount = GetTroopCount($eArch)
		$eMiniCount = GetTroopCount($eMini)
		If (Not $waveUsed And ($eBarbCount >= 10 Or $eMiniCount >=5)) Or ($waveUsed And ($eBarbCount >= 20 Or $eMiniCount >= 10)) Then
			$eGoblCount = GetTroopCount($eGobl)
			Setlog("BAM wave")
			If $eBarbCount >= 10 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eBarb, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eBarb, $spotsNum, Random(2, 4, 1), 1000)
			EndIf
			If $eGoblCount > 0 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eGobl, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eGobl, $spotsNum, Random(2, 4, 1), 1000)
			EndIf
			If $eArchCount >= 10 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eArch, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eArch, $spotsNum, Random(2, 4, 1), 1000)
			EndIf
			If $eMiniCount >= 5 Then
				$setOffAirTrap = SetOffTraps($THx, $THy, $eMini, 3, $setOffAirTrap)
				TroopTH($THx, $THy, $eMini, $spotsNum, Random(1, 4, 1), 1000)
			EndIf
			$waveUsed = True
			PrepareAttack($iMatchMode, True) ;Check remaining quantities
			If CheckForStar(45) = True Then
				If $optGreedy = 1 Then
					Greedy($spotsNum,$eKingSlot,$eQueenSlot)
				EndIf
				Return
			EndIf
		Else
			Setlog("Too few BAM troops...skipping wave")
		EndIf

		$eGiantCount = GetTroopCount($eGiant)
		$eHogsCount = GetTroopCount($eHogs)
		$eBallCount = GetTroopCount($eBall)
		$eWizaCount = GetTroopCount($eWiza)
		If ($waveUsed And ($eWizaCount >= 5 And ($eGiantCount >= 5 Or $eHogsCount >= 5 Or $eBallCount >= 5 Or $eBarbCount >= 20))) Then
			$eBarbCount = GetTroopCount($eBarb)
			$eGoblCount = GetTroopCount($eGobl)
			$eWallCount = GetTroopCount($eWall)
			$eArchCount = GetTroopCount($eArch)
			$eMiniCount = GetTroopCount($eMini)
			Setlog("Defense Aggro and Wizard wave") ;Send in the Defense specialists - Giants, Ballons and Hogriders
			If $eGiantCount >=5 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eGiant, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eGiant, $spotsNum, Random(1, 4, 1), 1000)
			EndIf
			If $eHogsCount >= 5 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eHogs, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eHogs, $spotsNum, Random(1, 4, 1), 1000)
			EndIf
			If $eBallCount >= 5 Then
				$setOffAirTrap = SetOffTraps($THx, $THy, $eBall, 3, $setOffAirTrap)
				TroopTH($THx, $THy, $eBall, $spotsNum, Random(1, 4, 1), 1000)
			EndIf
			If $eBarbCount >= 20 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eBarb, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eBarb, $spotsNum, Random(4, 6, 1), 1000)
			EndIf
			If $eGoblCount > 0 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eGobl, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eGobl, $spotsNum, Random(1, 4, 1), 1000)
			EndIf
			If $eWallCount > 0 Then
				TroopTH($THx, $THy, $eWall, 1, Random(1, 4, 1), 1000)
			EndIf
			If $eArchCount >= 10 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eArch, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eArch, $spotsNum, Random(2, 6, 1), 1000)
			EndIf
			If $eWizaCount >= 5 Then
				$setOffGroundTrap = SetOffTraps($THx, $THy, $eWiza, 3, $setOffGroundTrap)
				TroopTH($THx, $THy, $eWiza, $spotsNum, Random(1, 2, 1), 1000)
			EndIf
			If $eMiniCount >= 5 Then
				$setOffAirTrap = SetOffTraps($THx, $THy, $eMini, 3, $setOffAirTrap)
				TroopTH($THx, $THy, $eMini, $spotsNum, Random(1, 3, 1), 1500)
			EndIf
			$waveUsed = True
			PrepareAttack($iMatchMode, True) ;Check remaining quantities
			If CheckForStar(45) = True Then
				If $optGreedy = 1 Then
					Greedy($spotsNum,$eKingSlot,$eQueenSlot)
				EndIf
				Return
			EndIf
		Else
			Setlog("Too few Defense Aggro and Wizards...skipping wave")
		EndIf

		If Not $waveUsed Then
			Setlog("Last probe before going ALL IN")
			$eWizaCount = GetTroopCount($eWiza)
			$eDragCount = GetTroopCount($eDrag)
			$ePekkCount = GetTroopCount($ePekk)
			$eValkCount = GetTroopCount($eValk)
			If $eWizaCount > 1 Or $eDragCount > 1 Or $ePekkCount > 1 Or $eValkCount > 2 Then
				If $eWizaCount > 0 Then
					TroopTH($THx, $THy, $eWiza, 1, 1, 1000)
				EndIf

				If $eDragCount > 0 Then
					TroopTH($THx, $THy, $eDrag, 1, 1, 500)
				EndIf

				If $ePekkCount > 0 Then
					TroopTH($THx, $THy, $ePekk, 1, 1, 500)
				EndIf

				If $eValkCount > 0 Then
					TroopTH($THx, $THy, $eValk, 2, 1, 500)
				EndIf
				PrepareAttack($iMatchMode, True) ;Check remaining quantities
				If CheckForStar(90) = True Then
					If $optGreedy = 1 Then
						Greedy($spotsNum,$eKingSlot,$eQueenSlot)
					EndIf
					Return
				EndIf
			EndIf
		EndIf
	Else
		Setlog("Going directly to final wave since TH is trapped")
	EndIf

	Setlog("ALL IN!!!") ;Desperate times need desperate measures
	Setlog("Calculating drop sequence...")
	;Setlog("Drop coordinates: x" & $x & " y " & $y)
	$eESpellCount = GetTroopCount($eESpell)
	$eESpellSlot = -1
	If $eESpellCount > 0 Then
		$eESpellSlot = GetTroopSlot($eESpell)
	EndIf
	$eJSpellCount = GetTroopCount($eJSpell)
	$eJSpellSlot = -1
	If $eJSpellCount > 0 Then
		$eJSpellSlot = GetTroopSlot($eJSpell)
	EndIf
	$ePSpellCount = GetTroopCount($ePSpell)
	$ePSpellSlot = -1
	If $ePSpellCount > 0 Then
		$ePSpellSlot = GetTroopSlot($ePSpell)
	EndIf
	$eHSpellCount = GetTroopCount($eHSpell)
	$eHSpellSlot = -1
	If $eHSpellCount > 0 Then
		$eHSpellSlot = GetTroopSlot($eHSpell)
	EndIf
	$eRSpellCount = GetTroopCount($eRSpell)
	$eRSpellSlot = -1
	If $eRSpellCount > 0 Then
		$eRSpellSlot = GetTroopSlot($eRSpell)
	EndIf
	$eHaSpellCount = GetTroopCount($eHaSpell)
	$eHaSpellSlot = -1
	If $eHaSpellCount > 0 Then
		$eHaSpellSlot = GetTroopSlot($eHaSpell)
	EndIf
	$eFSpellCount = GetTroopCount($eFSpell)
	$eFSpellSlot = -1
	If $eFSpellCount > 0 Then
		$eFSpellSlot = GetTroopSlot($eFSpell)
	EndIf
	$eLSpellCount = GetTroopCount($eLSpell)
	$eLSpellSlot = -1
	If $eLSpellCount > 0 Then
		$eLSpellSlot = GetTroopSlot($eLSpell)
	EndIf
	$eGoleCount = GetTroopCount($eGole)
	$eLavaCount = GetTroopCount($eLava)
	$eDragCount = GetTroopCount($eDrag)
	$ePekkCount = GetTroopCount($ePekk)
	$eValkCount = GetTroopCount($eValk)
	$eKingCount = GetTroopCount($eKing)
	$eQueenCount = GetTroopCount($eQueen)
	$eCastleCount = GetTroopCount($eCastle)
	$eKingSlot = GetTroopSlot($eKing)
	$eQueenSlot = GetTroopSlot($eQueen)
	$eCastleSlot = GetTroopSlot($eCastle)
	SetLog("K: " & $eKingCount & " Q: " & $eQueenCount & " C: " & $eCastleCount & " Ki: " & $eKingSlot & " Qi: " & $eQueenSlot & " Ci: " & $eCastleSlot)
	;$King = $eKingSlot
	;$Queen = $eQueenSlot
	;$CC = $eCastleSlot
	$eGiantCount = GetTroopCount($eGiant)
	$eBallCount = GetTroopCount($eBall)
	$eHogsCount = GetTroopCount($eHogs)
	$eBarbCount = GetTroopCount($eBarb)
	$eGoblCount = GetTroopCount($eGobl)
	$eWallCount = GetTroopCount($eWall)
	$eArchCount = GetTroopCount($eArch)
	$eWizaCount = GetTroopCount($eWiza)
	$eMiniCount = GetTroopCount($eMini)
	$eWitcCount = GetTroopCount($eWitc)
	$eHealCount = GetTroopCount($eHeal)
	Setlog("Done. Dropping now.")

	If $eESpellCount > 0 Then
		If $OptParanoid = 0 Then $eESpellCount = 1
		For $i = 1 To $eESpellCount
			SpellTH($THx, $THy, $eESpellSlot)
		Next
	EndIf

	If $eJSpellCount > 0 Then
		SpellTH($DropCoord[2][0], $DropCoord[2][1], $eJSpellSlot)
	EndIf

	If $ePSpellCount > 0 Then
		If $OptParanoid = 0 Then $ePSpellCount = 1
		For $i = 1 To $ePSpellCount
			SpellTH($DropCoord[3][0], $DropCoord[3][1], $ePSpellSlot)
		Next
	EndIf

	If $eHSpellCount > 0 Then
		If $OptParanoid = 0 Then $eHSpellCount = 1
		For $i = 1 To $eHSpellCount
			SpellTH($DropCoord[1][0], $DropCoord[1][1], $eHSpellSlot)
		Next
	EndIf

	If $eRSpellCount > 0 Then
		If $OptParanoid = 0 Then $eRSpellCount = 1
		For $i = 1 To $eRSpellCount
			SpellTH($DropCoord[1][0], $DropCoord[1][1], $eRSpellSlot)
		Next
	EndIf

	If $eHaSpellCount > 0 Then
		If $OptParanoid = 0 Then $eHaSpellCount = 1
		For $i = 1 To $eHaSpellCount
			SpellTH($DropCoord[3][0], $DropCoord[3][1], $eHaSpellSlot)
		Next
	EndIf

	If $eFSpellCount > 0 Then
		If $OptParanoid = 0 Then $eFSpellCount = 1
		For $i = 1 To $eFSpellCount
			SpellTH($THx, $THy, $eFSpellSlot)
		Next
	EndIf

	; Drop high tier troops
	If $eGoleCount > 0 Then
		TroopTH($THx, $THy, $eGole, 1, $eGoleCount, 1500)
	EndIf

	If $eLavaCount > 0 Then
		TroopTH($THx, $THy, $eLava, 1, $eLavaCount, 500)
	EndIf

	If $eDragCount > 0 Then
		TroopTH($THx, $THy, $eDrag, 1, $eDragCount, 500)
	EndIf

	If $ePekkCount > 0 Then
		TroopTH($THx, $THy, $ePekk, 1, $ePekkCount, 500)
	EndIf

	If $eValkCount > 0 Then
		TroopTH($THx, $THy, $eValk, 1, $eValkCount, 500)
	EndIf

	Local $l = 0
	If $eGiantCount > 0 Then
		$l = Ceiling($eGiantCount / $spotsNum)
		;AttackTHGrid($eGiant, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eGiant, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eBallCount > 0 Then
		$l = Ceiling($eBallCount / $spotsNum)
		;AttackTHGrid($eBall, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eBall, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eHogsCount > 0 Then
		;AttackTHGrid($eHogs, 1, $eHogsCount, 500, 1, 1, 0)
		TroopTH($THx, $THy, $eHogs, 1, $eHogsCount, 500)
	EndIf

	If $eBarbCount > 0 Then
		$l = Ceiling($eBarbCount / $spotsNum)
		;AttackTHGrid($eBarb, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eBarb, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eGoblCount > 0 Then
		$l = Ceiling($eGoblCount / $spotsNum)
		;AttackTHGrid($eGobl, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eGobl, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eWallCount > 0 Then
		$l = Ceiling($eWallCount / 2)
		;AttackTHGrid($eWall, 2, $l, 500, 1, 1, 0)
		TroopTH($THx, $THy, $eWall, 2, $l, 500)
	EndIf

	If $eArchCount > 0 Then
		$l = Ceiling($eArchCount / $spotsNum)
		;AttackTHGrid($eArch, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eArch, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eWizaCount > 0 Then
		$l = Ceiling($eWizaCount / $spotsNum)
		TroopTH($THx, $THy, $eWiza, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eMiniCount > 0 Then
		$l = Ceiling($eMiniCount / $spotsNum)
		;AttackTHGrid($eMini, $spotsNum, $l, 250 + $l * 250, 1, 1, 0)
		TroopTH($THx, $THy, $eMini, $spotsNum, $l, 250 + $l * 250)
	EndIf

	If $eKingCount = 1 Then
		KingTH($DropCoord[0][0], $DropCoord[0][1], $eKingSlot)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eQueenCount = 1 Then
		QueenTH($DropCoord[0][0], $DropCoord[0][1], $eQueenSlot)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eCastleCount = 1 Then
		CCTH($DropCoord[0][0], $DropCoord[0][1], $eCastleSlot)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eWitcCount > 0 Then
		;AttackTHGrid($eWitc, 1, $eWitcCount, 500, 1, 1, 0)
		TroopTH($THx, $THy, $eWitc, 1, $eWitcCount, 500)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eHealCount > 0 Then
		;AttackTHGrid($eHeal, 1, $eHealCount, 500, 1, 1, 0)
		TroopTH($THx, $THy, $eHeal, 1, $eHealCount, 500)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eLSpellCount > 0 Then
		If $OptParanoid = 0 Then $eLSpellCount = 1
		For $i = 1 To $eLSpellCount
			SpellTH($THx, $THy, $eLSpellSlot)
		Next
	EndIf

	CheckForStar(30,3,$eKingSlot,$eQueenSlot)

	SetLog("Activating heroes abilities if not yet used before exit")
	If $eKingCount = 1 Then
		SelectDropTroop($eKingSlot)
	EndIf
	If $eQueenCount = 1 Then
		SelectDropTroop($eQueenSlot)
	EndIf

	SetLog("Finished Attacking, waiting for the battle to end")

EndFunc   ;==>AttackTHAllIn

Func GetTroopCount($eTroop)
	For $i = 0 To UBound($atkTroops) - 1
		Local $j = $atkTroops[$i][0]
		Local $k = $atkTroops[$i][1]
		If $k == "" Then $k = 1 ; CC, King, Queen
		If $j = $eTroop Then
			; temporary fix for a bug that misreads troop count at slot 0
			If $k = 1 And ($j = $eBarb Or $j = $eArch Or $j = $eMini) Then $k *= 19
			Return $k
		EndIf
	Next
	Return 0
EndFunc   ;==>GetTroopCount

Func GetTroopSlot($eTroop)
	For $i = 0 To UBound($atkTroops) - 1
		Local $j = $atkTroops[$i][0]
		Local $k = $atkTroops[$i][1]
		;If $k == "" Then $k = 1 ; CC, King, Queen
		If $j = $eTroop Then
			Return $i
		EndIf
	Next
	Return -1
EndFunc   ;==>GetTroopSlot

Func CheckForStar($delay, $star=1, $eKingSlot=-1, $eQueenSlot=-1)
	Local $count = 0, $WonStarColor[3]

	While $count < $delay
		If $star > 1 Then
			If CheckHeroesHealth($eKingSlot, $eQueenSlot) Then Return
		EndIf
		If _Sleep($iDelayAttackTHAllIn1) Then Return
		;_CaptureRegion()
		$WonStarColor[0] = _GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True)
		$WonStarColor[1] = Hex($aWonOneStar[2], 6)
		$WonStarColor[2] = $aWonOneStar[3]
		If $star = 2 Then
			SetLog("Checking if two stars has been won")
			$WonStarColor[0] = _GetPixelColor($aWonTwoStar[0], $aWonTwoStar[1], True)
			$WonStarColor[1] = Hex($aWonTwoStar[2], 6)
			$WonStarColor[2] = $aWonTwoStar[3]
		ElseIf $star = 3 Then
			SetLog("Checking if three stars has been won")
			$WonStarColor[0] = _GetPixelColor($aWonThreeStar[0], $aWonThreeStar[1], True)
			$WonStarColor[1] = Hex($aWonThreeStar[2], 6)
			$WonStarColor[2] = $aWonThreeStar[3]
		ElseIf $star <> 1 Then
			SetLog("Only one, two and three stars can be won")
			Return False
		EndIf
		If _ColorCheck($WonStarColor[0],$WonStarColor[1],$WonStarColor[2]) = True Then
			SetLog("Townhall has been destroyed!")
			Return True;exit if you get a star
		EndIf
		$count += 1
	WEnd
	Return False
EndFunc   ;==>CheckForStar

Func SpellTH($xx, $yy, $SpellSlot = -1)
	SetLog("Dropping Spell @ " & $xx & ", " & $yy, $COLOR_BLUE)
	SelectDropTroop($SpellSlot)
		Click($xx, $yy, 1, 0, "#0029")
	If _Sleep($iDelayCastSpell1) Then Return
EndFunc   ;==>SpellTH

Func KingTH($xx, $yy, $KingSlot = -1)
	SetLog("Dropping King @ " & $xx & ", " & $yy, $COLOR_BLUE)
	;SelectDropTroop($KingSlot)
	Click(GetXPosOfArmySlot($KingSlot, 68), 595, 1, 0, "#0092") ;Select King
		Click($xx, $yy, 1, 0, "#0093")
	If _Sleep($iDelaydropHeroes2) Then Return
	$checkKPower = True
EndFunc   ;==>KingTH

Func QueenTH($xx, $yy, $QueenSlot = -1)
	SetLog("Dropping Queen @ " & $xx & ", " & $yy, $COLOR_BLUE)
	;SelectDropTroop($QueenSlot)
	Click(GetXPosOfArmySlot($QueenSlot, 68), 595, 1, 0, "#0094") ;Select Queen
	Click($xx, $yy, 1, 0, "#0095")
	If _Sleep($iDelaydropHeroes2) Then Return
	$checkQPower = True
EndFunc   ;==>QueenTH

Func CCTH($xx, $yy, $CCSlot)
	SetLog("Dropping Clan Castle @ " & $xx & ", " & $yy, $COLOR_BLUE)
	;SelectDropTroop($CCSlot)
	Click(GetXPosOfArmySlot($CCSlot, 68), 595, 1, $iDelaydropCC2, "#0090")
	Click($xx, $yy, 1, 0, "#0091")
	If _Sleep($iDelaydropCC1) Then Return
EndFunc   ;==>CCTH

Func GetDropTHDistance($x1, $y1, $x2, $y2, $type)
	Local $d[4] = [0, 0, 0, 0]
	Local $cartesian[4][2] = [[0, 0], [0, 0], [0, 0], [0, 0]]
	Local $Dpixel = 11.6 ; using 2 extreme two points and distance formula divided by 40 tiles
	; if i use 19 pixels for x and 14 pixels for y i get 11.8 using trigonometric functions
	;$Xpixel = 19
	;$Ypixel = 14
	Local $Br, $Hr, $Dr
	Local $phiA, $phiB, $cosA, $sinA, $cosB, $sinB

	$cartesian[0][0] = $x2
	$cartesian[0][1] = $y2
	For $i = 1 To 3
		$cartesian[$i][0] = $THx
		$cartesian[$i][1] = $THy
	Next
	Setlog("Drop coordinates: ")
	Setlog("x: " & $cartesian[0][0] & " y: " & $cartesian[0][1])
	If $type < 0 Or $type > 3 Then Return $cartesian
	$d = GetDistance($x1, $y1, $x2, $y2, $type)
	$Br = 5 ; (5 + 1) * $Dpixel; heal, rage near TH
	$Hr = 3.5 ;(3.5 + 1) * $Dpixel; jump near troops
	$Dr = 4 ; (4 + 1) * $Dpixel; poison, haste near TH
	;lightning and earthquake use $THx, $THy = ground zero
	Setlog("a: " & $d[0] & " b: " & $d[1] & " c: " & $d[2] & " d: " & $d[3])
	;If $d > $Hr Then
	$phiA = ACos($d[0] / $d[2])
	$cosA = Cos($phiA)
	$sinA = Sin($phiA)
	$phiB = ACos($d[1] / $d[2])
	$cosB = Cos($phiB)
	$sinB = Sin($phiB)
	Setlog("phiA: " & $phiA & " cosA: " & $cosA & " sinA " & $sinA)
	Setlog("phiB: " & $phiB & " cosB: " & $cosB & " sinB " & $sinB)
	Switch $type
		Case 0
			$Brca = Round($Br * $cosA * $Dpixel)
			$Brcb = Round($Br * $sinA * $Dpixel)
			$Hrca = Round($Hr * $sinB * $Dpixel) ; for jump spell drop edge at troop drop point
			$Hrcb = Round($Hr * $cosB * $Dpixel)
			$Drca = Round($Dr * $cosA * $Dpixel)
			$Drcb = Round($Dr * $sinA * $Dpixel)
			If $d[3] > $Br Then
				$cartesian[1][0] = $x1 - $Brca
				$cartesian[1][1] = $y1 - $Brcb
			EndIf
			If $d[3] > $Hr Then
				$cartesian[2][0] = $x2 + $Hrca
				$cartesian[2][1] = $y2 + $Hrcb
			EndIf
			If $d[3] > $Dr Then
				$cartesian[3][0] = $x1 - $Drca
				$cartesian[3][1] = $y1 - $Drcb
			EndIf
		Case 1
			$Brca = Round($Br * $sinB * $Dpixel)
			$Brcb = Round($Br * $cosB * $Dpixel)
			$Hrca = Round($Hr * $cosA * $Dpixel) ; for jump spell drop edge at troop drop point
			$Hrcb = Round($Hr * $sinA * $Dpixel)
			$Drca = Round($Dr * $sinB * $Dpixel)
			$Drcb = Round($Dr * $cosB * $Dpixel)
			If $d > $Br Then
				$cartesian[1][0] = $x1 - $Brca
				$cartesian[1][1] = $y1 + $Brcb
			EndIf
			If $d[3] > $Hr Then
				$cartesian[2][0] = $x2 + $Hrca
				$cartesian[2][1] = $y2 - $Hrcb
			EndIf
			If $d[3] > $Dr Then
				$cartesian[3][0] = $x1 - $Drca
				$cartesian[3][1] = $y1 + $Drcb
			EndIf
		Case 2
			$Brca = Round($Br * $cosA * $Dpixel)
			$Brcb = Round($Br * $sinA * $Dpixel)
			$Hrca = Round($Hr * $sinB * $Dpixel) ; for jump spell drop edge at troop drop point
			$Hrcb = Round($Hr * $cosB * $Dpixel)
			$Drca = Round($Dr * $cosA * $Dpixel)
			$Drcb = Round($Dr * $sinA * $Dpixel)
			If $d[3] > $Br Then
				$cartesian[1][0] = $x1 + $Brca
				$cartesian[1][1] = $y1 - $Brcb
			EndIf
			If $d[3] > $Hr Then
				$cartesian[2][0] = $x2 - $Hrca
				$cartesian[2][1] = $y2 + $Hrcb
			EndIf
			If $d[3] > $Dr Then
				$cartesian[3][0] = $x1 + $Drca
				$cartesian[3][1] = $y1 - $Drcb
			EndIf
		Case 3
			$Brca = Round($Br * $sinB * $Dpixel)
			$Brcb = Round($Br * $cosB * $Dpixel)
			$Hrca = Round($Hr * $cosA * $Dpixel) ; for jump spell drop edge at troop drop point
			$Hrcb = Round($Hr * $sinA * $Dpixel)
			$Drca = Round($Dr * $sinB * $Dpixel)
			$Drcb = Round($Dr * $cosB * $Dpixel)
			If $d[3] > $Br Then
				$cartesian[1][0] = $x1 + $Brca
				$cartesian[1][1] = $y1 + $Brcb
			EndIf
			If $d[3] > $Hr Then
				$cartesian[2][0] = $x2 - $Hrca
				$cartesian[2][1] = $y2 - $Hrcb
			EndIf
			If $d[3] > $Dr Then
				$cartesian[3][0] = $x1 + $Drca
				$cartesian[3][1] = $y1 + $Drcb
			EndIf
	EndSwitch
	Setlog("Brca: " & $Brca & " Brcb: " & $Brcb)
	Setlog("Hrca: " & $Hrca & " Hrcb: " & $Hrcb)
	Setlog("Drca: " & $Drca & " Drcb: " & $Drcb)
	Setlog("Bx: " & $cartesian[1][0] & " By: " & $cartesian[1][1])
	Setlog("Hx: " & $cartesian[2][0] & " Hy: " & $cartesian[2][1])
	Setlog("Dx: " & $cartesian[3][0] & " Dy: " & $cartesian[3][1])
	Return $cartesian
EndFunc   ;==>GetDropTHDistance

Func TroopTH($xx, $yy, $eTroop, $spots, $numperspot, $Sleep)
	Local $eTroopSlot, $DropTH[2], $total, $plural, $name

	If $eTroop > $eKing Then
		SetLog("Not applicable to King, Queen, CC or Spells")
		Return
	EndIf
	$eTroopSlot = GetTroopSlot($eTroop)
	SelectDropTroop($eTroopSlot)
	$total = $spots * $numperspot
	$plural = 0
	If $total > 1 Then $plural = 1
	$name = NameOfTroop($eTroop, $plural)
	SetLog("Dropping " & $name)
		Switch $THside
			Case 0 ;UL
				;$x < 68
				;$y < 20
				For $i = 1 To $numperspot
					For $j = 1 To $spots
						$DropTH = GetDropTH($xx, $yy, 0, $spots, $j)
						Click($DropTH[0], $DropTH[1], 1, 0, "#0019")
						If _Sleep(Random($iDelayAttackTHGrid2min, $iDelayAttackTHGrid2max)) Then Return
					Next
					If _Sleep(Random($iDelayAttackTHGrid4min, $iDelayAttackTHGrid4max)) Then Return
				Next
			Case 1 ;LL
				;$x < 68
				;$y > 600
				For $i = 1 To $numperspot
					For $j = 1 To $spots
						$DropTH = GetDropTH($xx, $yy, 1, $spots, $j)
						Click($DropTH[0], $DropTH[1], 1, 0, "#0019")
						If _Sleep(Random($iDelayAttackTHGrid2min, $iDelayAttackTHGrid2max)) Then Return
					Next
					If _Sleep(Random($iDelayAttackTHGrid4min, $iDelayAttackTHGrid4max)) Then Return
				Next
			Case 2 ;UR
				;$x > 825
				;$y < 20
				For $i = 1 To $numperspot
					For $j = 1 To $spots
						$DropTH = GetDropTH($xx, $yy, 2, $spots, $j)
						Click($DropTH[0], $DropTH[1], 1, 0, "#0019")
						If _Sleep(Random($iDelayAttackTHGrid2min, $iDelayAttackTHGrid2max)) Then Return
					Next
					If _Sleep(Random($iDelayAttackTHGrid4min, $iDelayAttackTHGrid4max)) Then Return
				Next
			Case 3 ;LR
				;$x > 825
				;$y > 600
				For $i = 1 To $numperspot
					For $j = 1 To $spots
						$DropTH = GetDropTH($xx, $yy, 3, $spots, $j)
						Click($DropTH[0], $DropTH[1], 1, 0, "#0019")
						If _Sleep(Random($iDelayAttackTHGrid2min, $iDelayAttackTHGrid2max)) Then Return
					Next
					If _Sleep(Random($iDelayAttackTHGrid4min, $iDelayAttackTHGrid4max)) Then Return
				Next
		EndSwitch
	If _Sleep($Sleep) Then Return
EndFunc   ;==>TroopTH

Func GetDropTH($xx, $yy, $type, $spots = 1, $spotidx = 1)
	Local $a, $b, $c, $x1, $x2, $y1, $y2
	;Local $cos53 = 0.601815;02315204827991797700044149 cos 53 deg
	Local $intercept = 0
	Local $DropTH[2]
	Local $slope = 0.75355405;010279415707395644862159 tan 37 deg
	Local $cos37 = 0.79863551;004729284628400080406894 cos 37 deg

	$DropTH[0] = $xx
	$DropTH[1] = $yy
	;SetLog("Spots: " & $spots & " index: " & $spotidx)
	If $spots < 1 Then Return $DropTH
	If $spotidx > $spots Then Return $DropTH
	Switch $type
		Case 0
			$intercept = 325
			$x1 = (($yy - $intercept) / -$slope)
			$y1 = (-$slope * $x1 + $intercept)
			$y2 = (-$slope * $xx + $intercept)
			$x2 = (($y2 - $intercept) / -$slope)
			$a = $x1 - $x2
			$b = $y1 - $y2
			$c = Sqrt($a * $a + $b * $b)
			$DropTH[0] = Round($x1 + ($c * $spotidx / ($spots + 1)) * $cos37)
			$DropTH[1] = Round(-$slope * $DropTH[0] + $intercept)
		Case 1
			$intercept = 280
			$x1 = (($yy - $intercept) / $slope)
			$y1 = ($slope * $x1 + $intercept)
			If $yy > 520 Then ; bottom TH
				If Mod($spotidx, 2) = 0 Then ;Switch to Case 3
					$intercept = 925
					$x1 = (($yy - $intercept) / -$slope)
					$y1 = (-$slope * $x1 + $intercept)
					If $yy > 560 Then
						$x1 = ((560 - $intercept) / -$slope)
						$y1 = (-$slope * $x1 + $intercept)
					EndIf
				Else
					If $yy > 560 Then
						$x1 = ((560 - $intercept) / $slope)
						$y1 = ($slope * $x1 + $intercept)
					EndIf
				EndIf
				$DropTH[0] = Round($x1)
				$DropTH[1] = Round($y1)
			Else
				$y2 = ($slope * $xx + $intercept)
				$x2 = (($y2 - $intercept) / $slope)
				$a = $x1 - $x2
				$b = $y1 - $y2
				$c = Sqrt($a * $a + $b * $b)
				$DropTH[0] = Round($x1 + ($c * $spotidx / ($spots + 1)) * $cos37)
				$DropTH[1] = Round($slope * $DropTH[0] + $intercept)
			EndIf
		Case 2
			$intercept = 310
			$x1 = (($yy + $intercept) / $slope)
			$y1 = ($slope * $x1 - $intercept)
			$y2 = ($slope * $xx - $intercept)
			$x2 = (($y2 + $intercept) / $slope)
			$a = $x1 - $x2
			$b = $y1 - $y2
			$c = Sqrt($a * $a + $b * $b)
			$DropTH[0] = Round($x1 - ($c * $spotidx / ($spots + 1)) * $cos37)
			$DropTH[1] = Round($slope * $DropTH[0] - $intercept)
		Case 3
			$intercept = 925
			$x1 = (($yy - $intercept) / -$slope)
			$y1 = (-$slope * $x1 + $intercept)
			If $yy > 520 Then ; bottom TH
				If Mod($spotidx, 2) = 0 Then ;Switch to Case 1
					$intercept = 280
					$x1 = (($yy - $intercept) / $slope)
					$y1 = ($slope * $x1 + $intercept)
					If $yy > 560 Then
						$x1 = ((560 - $intercept) / $slope)
						$y1 = ($slope * $x1 + $intercept)
					EndIf
				Else
					If $yy > 560 Then
						$x1 = ((560 - $intercept) / -$slope)
						$y1 = (-$slope * $x1 + $intercept)
					EndIf
				EndIf
				$DropTH[0] = Round($x1)
				$DropTH[1] = Round($y1)
			Else
				$y2 = (-$slope * $xx + $intercept)
				$x2 = (($y2 - $intercept) / -$slope)
				$a = $x1 - $x2
				$b = $y1 - $y2
				$c = Sqrt($a * $a + $b * $b)
				$DropTH[0] = Round($x1 - ($c * $spotidx / ($spots + 1)) * $cos37)
				$DropTH[1] = Round(-$slope * $DropTH[0] + $intercept)
			EndIF
	EndSwitch
	;Setlog("x1: " & $x1 & " y1: " & $y1)
	;Setlog("x2: " & $x2 & " y2: " & $y2)
	Return $DropTH
EndFunc   ;==>GetDropTH

Func PrepareAttackTHAllIn()
	Local $i
	Local $smallestd = 40
	;Local $tiles = 0
	Local $THnum = 6
	Local $sided[2] = [0, 0]

	If $searchTH == "-" Then
		$THnum = 10
	ElseIf $searchTH <> "4-6" Then
		$THnum = $searchTH
	EndIf
	;$tiles += (12 - $THnum) ^ 2 + (10 - $THnum) * 2
	$sided = GetTHSide($THx,$THy)
	$THside = $sided[0]
	$smallestd = $sided[1]
	SetLog("Shortest distance " & $smallestd & " on side " & $THside)
	;If $smallestd < $tiles Then
	Return True
EndFunc   ;==>PrepareAttackTHAllIn

Func GetDistance($x1, $y1, $x2, $y2, $type=0)
	Local $a, $b, $c, $d[4] = [0, 0, 0, 0]
	Local $Dpixel = 11.6

	Switch $type
		Case 0
			$a = $x1 - $x2
			$b = $y1 - $y2
		Case 1
			$a = $x1 - $x2
			$b = $y2 - $y1
		Case 2
			$a = $x2 - $x1
			$b = $y1 - $y2
		Case 3
			$a = $x2 - $x1
			$b = $y2 - $y1
	EndSwitch
	$d[0] = $a
	$d[1] = $b
	$c = Sqrt($a * $a + $b * $b)
	$d[2] = $c
	$d[3] = $d[2] / $Dpixel
	Return $d
EndFunc   ;==>GetDistance

Func SetOffTraps($THx, $THy, $eTroop, $spotsNum, $setOffTrap = False)
	If Not $setOffTrap Then
		TroopTH($THx, $THy, $eTroop, $spotsNum, 1, 1000)
	EndIf
	Return True
EndFunc   ;==>SetOffTraps

Func GetTHSide($xx,$yy)
	Local $i
	Local $smallestd = 40
	Local $DropTH[2] = [0, 0]
	Local $d[4] = [0, 0, 0, 0]
	Local $sided[2]

	For $i = 0 To 3
		$DropTH = GetDropTH($xx, $yy, $i)
		$d = GetDistance($xx, $yy, $DropTH[0], $DropTH[1], $i)
		If $d[3] < $smallestd Then
			$smallestd = Round($d[3])
			$sided[1] = $smallestd
			$sided[0] = $i
		EndIf
	Next
	Return $sided
EndFunc

Func Greedy($spotsNum, $eKingSlot = -1, $eQueenSlot = -1)
	Local $i, $j
	Local $eBarbCount = 0
	Local $eGoblCount = 0
	Local $eArchCount = 0
	Local $eMiniCount = 0

	SetLog("Greedy mode: Activated")
	If checkDeadBase() Then
		SetLog("Greedy mode: Attacking...")
		$i = Mod($THside + 1, 4)
		$j = 0
		While $j < 4
			$THside = $i
			SetLog("Greedy mode: Side " & $THside)
			CheckHeroesHealth($eKingSlot, $eQueenSlot)
			PrepareAttack($DB, True)
			$eBarbCount = GetTroopCount($eBarb)
			$eArchCount = GetTroopCount($eArch)
			$eMiniCount = GetTroopCount($eMini)
			$eGoblCount = GetTroopCount($eGobl)
			If $eBarbCount > 0 Or $eMiniCount > 0 Or $eArchCount > 0 Or $eGoblCount > 0 Then
				If $eBarbCount > 0 Then
					TroopTH(430, 315, $eBarb, $spotsNum*2, 1, 500)
				EndIf

				If $eGoblCount > 0 Then
					TroopTH(430, 315, $eGobl, $spotsNum*2, 1, 500)
				EndIf

				If $eArchCount > 0 Then
					TroopTH(430, 315, $eArch, $spotsNum*2, 1, 500)
				EndIf

				If $eMiniCount > 0 Then
					TroopTH(430, 315, $eMini, $spotsNum*2, 1, 500)
				EndIf
			EndIf
			$i = Mod($i + 1, 4)
			$j += 1
		WEnd
		If _Sleep(10*1000) Then Return
	Else
		SetLog("Greedy mode: Nothing to loot")
	EndIf
EndFunc