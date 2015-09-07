; #FUNCTION# ====================================================================================================================
; Name ..........: AttackTHLavaloonion
; Description ...: A polymorph build TH Snipe attack type
; Syntax ........: AttackTHLavaloonion()
; Parameters ....: None
; Return values .: None
; Author ........: mojacka
; Modified ......: 9/7/2015
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func AttackTHLavaloonion()
	Local $i, $j
	Local $eBallCount = 0
	Local $eMiniCount = 0
	Local $eLavaCount
	Local $eKingCount
	Local $eQueenCount
	Local $eCastleCount
	Local $eKingSlot = -1
	Local $eQueenSlot = -1
	Local $eCastleSlot = -1
	Local $DropCoord[4][2] = [[0, 0], [0, 0], [0, 0], [0, 0]]
	Local $DropTH[2] = [0, 0]
	$spotsNum = 5;

	SetLog("THside: " & $THside & " THi: " & $THi)
	Setlog("TH coordinates: ")
	Setlog("THx: " & $THx & " THy: " & $THy)
	$DropTH = GetDropTH($THx, $THy, $THside)
	Setlog("x: " & $DropTH[0] & " y: " & $DropTH[1])
	$DropCoord = GetDropTHDistance($THx, $THy, $DropTH[0], $DropTH[1], $THside)
	Setlog("Calculating drop sequence...")
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
	$eLSpellCount = GetTroopCount($eLSpell)
	$eLSpellSlot = -1
	If $eLSpellCount > 0 Then
		$eLSpellSlot = GetTroopSlot($eLSpell)
	EndIf
	$eESpellCount = GetTroopCount($eESpell)
	$eESpellSlot = -1
	If $eESpellCount > 0 Then
		$eESpellSlot = GetTroopSlot($eESpell)
	EndIf
	$eLavaCount = GetTroopCount($eLava)
	$eKingCount = GetTroopCount($eKing)
	$eQueenCount = GetTroopCount($eQueen)
	$eCastleCount = GetTroopCount($eCastle)
	$eKingSlot = GetTroopSlot($eKing)
	$eQueenSlot = GetTroopSlot($eQueen)
	$eCastleSlot = GetTroopSlot($eCastle)
	$eBallCount = GetTroopCount($eBall)
	$eMiniCount = GetTroopCount($eMini)
	Setlog("Done. Dropping now.")

	SetOffTraps($THx, $THy, $eMini, $spotsNum)
	SetOffTraps($THx, $THy, $eBall, $spotsNum)
	TroopTH($THx, $THy, $eLava, 1, $eLavaCount, 500) ;change THx,THy to ADx,ADy
	TroopTH($THx, $THy, $eBall, $spotsNum, $eBallCount-$spotsNum, 500)
	TroopTH($THx, $THy, $eMini, $spotsNum, $eMiniCount-$spotsNum, 500)

	If $ePSpellCount > 0 Then
		SpellTH($DropCoord[3][0], $DropCoord[3][1], $ePSpellSlot)
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

	If $eCastleCount = 1 Then
		CCTH($DropCoord[0][0], $DropCoord[0][1], $eCastleSlot)
	EndIf

	If $eKingCount = 1 Then
		KingTH($DropCoord[0][0], $DropCoord[0][1], $eKingSlot)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eQueenCount = 1 Then
		QueenTH($DropCoord[0][0], $DropCoord[0][1], $eQueenSlot)
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eLSpellCount > 0 Then
		If $OptParanoid = 0 Then $eLSpellCount = 1
		For $i = 1 To $eLSpellCount
			SpellTH($THx, $THy, $eLSpellSlot)
		Next
	EndIf

	CheckHeroesHealth($eKingSlot, $eQueenSlot)

	If $eESpellCount > 0 Then
		If $OptParanoid = 0 Then $eESpellCount = 1
		For $i = 1 To $eESpellCount
			SpellTH($THx, $THy, $eESpellSlot)
		Next
	EndIf

	SetLog("Activating heroes abilities if not yet used before exit")
	If $eKingCount = 1 Then
		SelectDropTroop($eKingSlot)
	EndIf
	If $eQueenCount = 1 Then
		SelectDropTroop($eQueenSlot)
	EndIf

	SetLog("Finished Attacking, waiting for the battle to end")

EndFunc   ;==>AttackTHLavaloonion

Func PrepareAttackTHLavaloonion()
	$eMiniCount = GetTroopCount($eMini)
	$eBallCount = GetTroopCount($eBall)
	$eLavaCount = GetTroopCount($eLava)
	$eRSpellCount = GetTroopCount($eRSpell)
	If $eLavaCount < 1 Or $eBallCount < 10 Or $eMiniCount < 10 Then
		SetLog("Not attacking this base using Lavaloonion since there is not enough Lava Hound, Baloons, Minions or Rage Spell")
		Return False
	EndIf
	Return True
EndFunc