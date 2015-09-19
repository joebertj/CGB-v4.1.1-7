Func ShowNormalSpellIcon()
	GUICtrlSetState($LightningIcon, $GUI_HIDE)
	GUICtrlSetState($HealIcon, $GUI_HIDE)
	GUICtrlSetState($RageIcon, $GUI_HIDE)
	GUICtrlSetState($JumpIcon, $GUI_HIDE)
	GUICtrlSetState($FreezeIcon, $GUI_HIDE)

	Local $IconNum = _GUICtrlComboBox_GetCurSel($cmbTrainNormalSpellType)
	Switch $IconNum
		Case 1
			GUICtrlSetState($LightningIcon, $GUI_SHOW)
		Case 2
			GUICtrlSetState($HealIcon, $GUI_SHOW)
		Case 3
			GUICtrlSetState($RageIcon, $GUI_SHOW)
		Case 4
			GUICtrlSetState($JumpIcon, $GUI_SHOW)
		Case 5
			GUICtrlSetState($FreezeIcon, $GUI_SHOW)
	EndSwitch

EndFunc   ;==>ShowNormalSpellIcon

Func ShowDarkSpellIcon()
	GUICtrlSetState($PoisonIcon, $GUI_HIDE)
	GUICtrlSetState($EarthquakeIcon, $GUI_HIDE)
	GUICtrlSetState($HasteIcon, $GUI_HIDE)

	Local $IconNum = _GUICtrlComboBox_GetCurSel($cmbTrainDarkSpellType)
	Switch $IconNum
		Case 1
			GUICtrlSetState($PoisonIcon, $GUI_SHOW)
		Case 2
			GUICtrlSetState($EarthquakeIcon, $GUI_SHOW)
		Case 3
			GUICtrlSetState($HasteIcon, $GUI_SHOW)
	EndSwitch


EndFunc   ;==>ShowDarkSpellIcon


Func cmbTrainNormalSpellType()
	IniWrite($config, "advanced", "cmbTrainNormalSpellType", _GUICtrlComboBox_GetCurSel($cmbTrainNormalSpellType))
	ShowNormalSpellIcon()
EndFunc   ;==>cmbTrainNormalSpellType

Func cmbTrainDarkSpellType()
	IniWrite($config, "advanced", "cmbTrainDarkSpellType", _GUICtrlComboBox_GetCurSel($cmbTrainDarkSpellType))
	ShowDarkSpellIcon()
EndFunc   ;==>cmbTrainDarkSpellType

Func TrainSpells()

	If $ichkTrainSpells = 1 Then
		TrainNormalSpells()
		TrainDarkSpells()
	EndIf

EndFunc   ;==>TrainSpells

Func TrainNormalSpells()
	Local $count
	Local $SpellPos[5]
	Local $spellName[5]
	Local $spellCount[5] = [0, 0, 0, 0, 0]
	Local $lightning[2] = [250, "Lightning"], $heal[2] = [357, "Heal"], $Rage[2] = [464, "Rage"], $Jump[2] = [571, "Jump"], $Freeze[2] = [678, "Freeze"]
	Local $multiTrain = False
	Local $i = Random(0, 4, 1)
	Local $j

	Switch (_GUICtrlComboBox_GetCurSel($cmbTrainNormalSpellType) + 1)

		Case 1
			Return
		Case 2
			$SpellPos[0] = $lightning[0]
			$spellName[0] = $lightning[1]
		Case 3
			$SpellPos[0] = $heal[0]
			$spellName[0] = $heal[1]
		Case 4
			$SpellPos[0] = $Rage[0]
			$spellName[0] = $Rage[1]
		Case 5
			$SpellPos[0] = $Jump[0]
			$spellName[0] = $Jump[1]
		Case 6
			$SpellPos[0] = $Freeze[0]
			$spellName[0] = $Freeze[1]
		Case 7
			$SpellPos[$i] = $Freeze[0]
			$spellName[$i] = $Freeze[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Jump[0]
			$spellName[$j] = $Jump[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Rage[0]
			$spellName[$j] = $Rage[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $heal[0]
			$spellName[$j] = $heal[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $lightning[0]
			$spellName[$j] = $lightning[1]
			$multiTrain = True
		Case 8
			$SpellPos[$i] = $Rage[0]
			$spellName[$i] = $Rage[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $heal[0]
			$spellName[$j] = $heal[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Rage[0]
			$spellName[$j] = $Rage[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $heal[0]
			$spellName[$j] = $heal[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Rage[0]
			$spellName[$j] = $Rage[1]
			$multiTrain = True
		Case 9
			$SpellPos[$i] = $Jump[0]
			$spellName[$i] = $Jump[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Rage[0]
			$spellName[$j] = $Rage[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Jump[0]
			$spellName[$j] = $Jump[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Rage[0]
			$spellName[$j] = $Rage[1]
			$i += 1
			$j = Mod($i, 5)
			$SpellPos[$j] = $Jump[0]
			$spellName[$j] = $Jump[1]
			$multiTrain = True
	EndSwitch

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
		While $count < 5
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
	Local $SpellPos[3]
	Local $spellName[3]
	Local $spellCount[3] = [0, 0, 0]
	Local $Poison[2] = [250, "Poison"], $Earthquake[2] = [357, "Earthquake"], $haste[2] = [464, "Haste"]
	Local $multiTrain = False
	Local $i = Random(0, 2, 1)
	Local $j

	Switch (_GUICtrlComboBox_GetCurSel($cmbTrainDarkSpellType) + 1)

		Case 1
			Return
		Case 2
			$SpellPos[0] = $Poison[0]
			$spellName[0] = $Poison[1]
		Case 3
			$SpellPos[0] = $Earthquake[0]
			$spellName[0] = $Earthquake[1]
		Case 4
			$SpellPos[0] = $haste[0]
			$spellName[0] = $haste[1]
		Case 5
			$SpellPos[$i] = $haste[0]
			$spellName[$i] = $haste[1]
			$i += 1
			$j = Mod($i, 3)
			$SpellPos[$j] = $Earthquake[0]
			$spellName[$j] = $Earthquake[1]
			$i += 1
			$j = Mod($i, 3)
			$SpellPos[$j] = $Poison[0]
			$spellName[$j] = $Poison[1]
			$multiTrain = True
	EndSwitch

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
		While $count < 6
			$created = True
			If $multiTrain Then $i = Mod($count, 3)
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
