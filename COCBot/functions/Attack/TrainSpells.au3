Func TrainSpells()

	If $ichkTrainLSpell = 1 Or $ichkTrainHSpell = 1 Or $ichkTrainRSpell = 1 Or $ichkTrainJSpell = 1 Or $ichkTrainFSpell = 1 Then
		TrainNormalSpells()
	EndIf
	If $ichkTrainPSpell = 1 Or $ichkTrainESpell = 1 Or $ichkTrainHaSpell = 1 Then
		TrainDarkSpells()
	EndIf

EndFunc   ;==>TrainSpells

Func TrainNormalSpells()
	Local $count
	Local $SpellPos[5], $SpellPosTemp[5]
	Local $spellName[5],  $spellNameTemp[5]
	Local $spellCount[5] = [0, 0, 0, 0, 0]
	Local $lightning[2] = [250, "Lightning"], $heal[2] = [357, "Heal"], $Rage[2] = [464, "Rage"], $Jump[2] = [571, "Jump"], $Freeze[2] = [678, "Freeze"]
	Local $multiTrain = False
	Local $i = Random(0, 4, 1)
	Local $j, $k, $l = 0
	Local $spellTrain = 0, $LSpellTrain = 0, $HSpellTrain = 0, $RSpellTrain = 0, $JSpellTrain = 0, $FSpellTrain = 0

	For $k = 0 To 4
	If $ichkTrainLSpell = 1 Then
		$j = Mod($i, 5)
		$SpellPosTemp[$j] = $lightning[0]
		$spellNameTemp[$j] = $lightning[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 5 Then ExitLoop
		$i += 1
		If $LSpellTrain = 0 Then $LSpellTrain = 1
	EndIf

	If $ichkTrainHSpell = 1 Then
		$j = Mod($i, 5)
		$SpellPosTemp[$j] = $heal[0]
		$spellNameTemp[$j] = $heal[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 5 Then ExitLoop
		$i += 1
		If $HSpellTrain = 0 Then $HSpellTrain = 1
	EndIf

	If $ichkTrainRSpell = 1 Then
		$j = Mod($i, 5)
		$SpellPosTemp[$j] = $Rage[0]
		$spellNameTemp[$j] = $Rage[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 5 Then ExitLoop
		$i += 1
		If $RSpellTrain = 0 Then $RSpellTrain = 1
	EndIf

	If $ichkTrainJSpell = 1 Then
		$j = Mod($i, 5)
		$SpellPosTemp[$j] = $Jump[0]
		$spellNameTemp[$j] = $Jump[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 5 Then ExitLoop
		$i += 1
		If $JSpellTrain = 0 Then $JSpellTrain = 1
	EndIf

	If $ichkTrainFSpell = 1 Then
		$j = Mod($i, 5)
		$SpellPosTemp[$j] = $Freeze[0]
		$spellNameTemp[$j] = $Freeze[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 5 Then ExitLoop
		$i += 1
		If $FSpellTrain = 0 Then $FSpellTrain = 1
	EndIf
	Next

	$spellTrain = $LSpellTrain + $HSpellTrain + $RSpellTrain + $JSpellTrain + $FSpellTrain
	If $spellTrain > 1 Then $multiTrain = True

	If $multiTrain Then
		SetLog("Order of creation")
		For $i = 0 To 4
			SetLog($spellName[$i])
		Next
	EndIf

	SetLog("Creating Normal Spells...")

	If $numFactorySpellAvaiables = 1 Then PureClick($btnpos[7][0], $btnpos[7][1])
	If _sleep(500) Then Return

	$count = 0
	While Not (isSpellFactory())
		_TrainMoveBtn(-1) ;click prev button
		$count += 1
		If _sleep(500) Then Return
		If $count >= 7 Then ExitLoop
	WEnd

	If isSpellFactory() Then
		$count = 0
		$i = 0
		While $count < $spellTrain
			$created = True
			If $multiTrain Then $i = $count
			If $debugSetlog = 1 Then SetLog(_GetPixelColor($SpellPos[$i], 375, True))

			If _ColorCheck(_GetPixelColor(250, 375, True), Hex(0x7A7A7A, 6), 20) Then
				SetLog("Spell Factory Full", $COLOR_RED)
				ExitLoop
			EndIf

			If _ColorCheck(_GetPixelColor($SpellPos[$i], 375, True), Hex(0xC945C1, 6), 20) = False Then
				SetLog("Spell isn't avaliable", $COLOR_RED)
				$created = False
				If Not $multiTrain Then ExitLoop
			EndIf

			If _Sleep(500) Then Return

			GemClick($SpellPos[$i], 375, 1, 600, "#0260")
			$count += 1
			If $created Then $spellCount[$i] += 1
		WEnd
		$i = 0
		For $count = 0 To 4
			If $multiTrain Then $i = $count
			If $spellCount[$i] <> 0 Then
				SetLog("Created " & $spellCount[$i] & " " & $spellName[$i] & " Spell(s)", $COLOR_BLUE)
				If Not $multiTrain Then ExitLoop
			EndIf
		Next
	Else
		SetLog("Spell Factory is not available, Skip Create", $COLOR_RED)
	EndIf

EndFunc   ;==>TrainNormalSpells

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Func TrainDarkSpells()
	Local $count
	Local $SpellPos[3], $SpellPosTemp[3]
	Local $spellName[3], $spellNameTemp[3]
	Local $spellCount[3] = [0, 0, 0]
	Local $Poison[2] = [250, "Poison"], $Earthquake[2] = [357, "Earthquake"], $haste[2] = [464, "Haste"]
	Local $multiTrain = False
	Local $i = Random(0, 2, 1)
	Local $j, $k, $l = 0
	Local $spellTrain = 0, $PSpellTrain = 0, $ESpellTrain = 0, $HaSpellTrain = 0

	For $k = 0 To 2
	If $ichkTrainPSpell = 1 Then
		$j = Mod($i, 3)
		$SpellPosTemp[$j] = $Poison[0]
		$spellNameTemp[$j] = $Poison[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 3 Then ExitLoop
		$i += 1
		If $PSpellTrain = 0 Then $PSpellTrain = 1
	EndIf
	If $ichkTrainESpell = 1 Then
		$j = Mod($i, 3)
		$SpellPosTemp[$j] = $Earthquake[0]
		$spellNameTemp[$j] = $Earthquake[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 3 Then ExitLoop
		$i += 1
		If $ESpellTrain = 0 Then $ESpellTrain = 1
	EndIf
	If $ichkTrainHaSpell = 1 Then
		$j = Mod($i, 3)
		$SpellPosTemp[$j] = $haste[0]
		$spellNameTemp[$j] = $haste[1]
		$SpellPos[$l] = $SpellPosTemp[$j]
		$spellName[$l] = $spellNameTemp[$j]
		$l += 1
		If $l = 3 Then ExitLoop
		$i += 1
		If $HaSpellTrain = 0 Then $HaSpellTrain = 1
	EndIf
	Next

	$spellTrain = $PSpellTrain + $ESpellTrain + $HaSpellTrain
	If $spellTrain > 1 Then $multiTrain = True

	If $multiTrain Then
		SetLog("Order of creation")
		For $i = 0 To 2
			SetLog($spellName[$i])
		Next
	EndIf

	SetLog("Creating Dark Spells...")

	If $numFactoryDarkSpellAvaiables = 1 Then PureClick($btnpos[8][0], $btnpos[8][1])
	If _sleep(500) Then Return

	$count = 0
	While Not (isDarkSpellFactory())
		_TrainMoveBtn(-1) ;click prev button
		$count += 1
		If _sleep(500) Then Return
		If $count >= 7 Then ExitLoop
	WEnd


	If isDarkSpellFactory() Then
		$count = 0
		$i = 0
		While $count < $spellTrain
			$created = True
			If $multiTrain Then $i = $count
			If _sleep(500) Then Return

			If $debugSetlog = 1 Then SetLog(_GetPixelColor($SpellPos[$i], 375, True))

			If _ColorCheck(_GetPixelColor(250, 375, True), Hex(0x292929, 6), 10) Then
				SetLog("Dark Spell Factory Full", $COLOR_RED)
				ExitLoop
			EndIf

			If _ColorCheck(_GetPixelColor($SpellPos[$i], 375, True), Hex(0x302238, 6), 20) = False Then
				SetLog("Dark Spell isn't avaliable", $COLOR_RED)
				$created = False
				If Not $multiTrain Then ExitLoop
			EndIf
			If _Sleep(500) Then Return

			GemClick($SpellPos[$i], 375, 1, 600, "#0290")
			$count += 1
			If $created Then $spellCount[$i] += 1

		WEnd
		$i = 0
		For $count = 0 To 2
			If $multiTrain Then $i = $count
			If $spellCount[$i] <> 0 Then
				SetLog("Created " & $spellCount[$i] & " " & $spellName[$i] & " Dark Spell(s)", $COLOR_BLUE)
			EndIf
			If Not $multiTrain Then ExitLoop
		Next

	Else
		SetLog("Dark Spell Factory is not available, Skip Create", $COLOR_RED)
	EndIf

EndFunc   ;==>TrainDarkSpells
