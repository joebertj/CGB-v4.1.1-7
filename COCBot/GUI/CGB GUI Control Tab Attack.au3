; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func chkDBSmartAttackRedArea()
	Local $i

	Switch _GUICtrlComboBox_GetCurSel($cmbDBDeploy)
		Case 0 To 3
			GUICtrlSetState($chkDBSmartAttackRedArea, $GUI_UNCHECKED)
			GUICtrlSetState($chkDBSmartAttackRedArea, $GUI_DISABLE)
			$iChkRedArea[$LB] = 0
			For $i = $lblDBSmartDeploy To $picDBAttackNearDarkElixirDrill
				GUICtrlSetState($i, $GUI_HIDE)
			Next
			GUICtrlSetState($cmbDBSelectTroop, $GUI_ENABLE)
			GUICtrlSetState($cmbDBUnitDelay, $GUI_ENABLE)
			GUICtrlSetState($cmbDBWaveDelay, $GUI_ENABLE)
			GUICtrlSetState($chkDBRandomSpeedAtk, $GUI_ENABLE)
			GUICtrlSetState($chkDBSmartAttackRedArea, $GUI_ENABLE)
		Case 4
			GUICtrlSetState($chkDBSmartAttackRedArea, $GUI_DISABLE)
		Case 5 To 6
			GUICtrlSetState($chkDBSmartAttackRedArea, $GUI_DISABLE)
			GUICtrlSetState($cmbDBSelectTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbDBUnitDelay, $GUI_DISABLE)
			GUICtrlSetState($cmbDBWaveDelay, $GUI_DISABLE)
			GUICtrlSetState($chkDBRandomSpeedAtk, $GUI_DISABLE)
	EndSwitch
	If GUICtrlRead($chkDBSmartAttackRedArea) = $GUI_CHECKED Then
		$iChkRedArea[$DB] = 1
		For $i = $lblDBSmartDeploy To $picDBAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_SHOW)
		Next
	Else
		$iChkRedArea[$DB] = 0
		For $i = $lblDBSmartDeploy To $picDBAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkDBSmartAttackRedArea

Func chkABSmartAttackRedArea()
	chkDESideEB()
	Switch _GUICtrlComboBox_GetCurSel($cmbABDeploy)
		Case 0 To 3
			GUICtrlSetState($chkABSmartAttackRedArea, $GUI_UNCHECKED)
			GUICtrlSetState($chkABSmartAttackRedArea, $GUI_DISABLE)
			$iChkRedArea[$LB] = 0
			For $i = $lblABSmartDeploy To $picABAttackNearDarkElixirDrill
				GUICtrlSetState($i, $GUI_HIDE)
			Next
			GUICtrlSetState($cmbABSelectTroop, $GUI_ENABLE)
			GUICtrlSetState($cmbABUnitDelay, $GUI_ENABLE)
			GUICtrlSetState($cmbABWaveDelay, $GUI_ENABLE)
			GUICtrlSetState($chkABRandomSpeedAtk, $GUI_ENABLE)
			GUICtrlSetState($chkABSmartAttackRedArea, $GUI_ENABLE)
			GUICtrlSetState($chkABDEUseSpell, $GUI_DISABLE)
			GUICtrlSetState($cmbABDEUseSpellType, $GUI_DISABLE)
		Case 4
			GUICtrlSetState($chkABSmartAttackRedArea, $GUI_DISABLE)
			GUICtrlSetState($chkABDEUseSpell, $GUI_DISABLE)
			GUICtrlSetState($cmbABDEUseSpellType, $GUI_DISABLE)
		Case 5 To 6
			GUICtrlSetState($chkABSmartAttackRedArea, $GUI_DISABLE)
			GUICtrlSetState($cmbABSelectTroop, $GUI_DISABLE)
			GUICtrlSetState($cmbABUnitDelay, $GUI_DISABLE)
			GUICtrlSetState($cmbABWaveDelay, $GUI_DISABLE)
			GUICtrlSetState($chkABRandomSpeedAtk, $GUI_DISABLE)
			GUICtrlSetState($chkABDEUseSpell, $GUI_DISABLE)
			GUICtrlSetState($cmbABDEUseSpellType, $GUI_DISABLE)
		Case 7
			GUICtrlSetState($chkABDEUseSpell, $GUI_ENABLE)
			GUICtrlSetState($cmbABDEUseSpellType, $GUI_ENABLE)
	EndSwitch
	If GUICtrlRead($chkABSmartAttackRedArea) = $GUI_CHECKED Then
		$iChkRedArea[$LB] = 1
		For $i = $lblABSmartDeploy To $picABAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_SHOW)
		Next
	Else
		$iChkRedArea[$LB] = 0
		For $i = $lblABSmartDeploy To $picABAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkABSmartAttackRedArea

Func chkBalanceDR()
	If GUICtrlRead($chkUseCCBalanced) = $GUI_CHECKED Then
		GUICtrlSetState($cmbCCDonated, $GUI_ENABLE)
		GUICtrlSetState($cmbCCReceived, $GUI_ENABLE)
	Else
		GUICtrlSetState($cmbCCDonated, $GUI_DISABLE)
		GUICtrlSetState($cmbCCReceived, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBalanceDR

Func cmbBalanceDR()
	If _GUICtrlComboBox_GetCurSel($cmbCCDonated) = _GUICtrlComboBox_GetCurSel($cmbCCReceived) Then
		_GUICtrlComboBox_SetCurSel($cmbCCDonated, 0)
		_GUICtrlComboBox_SetCurSel($cmbCCReceived, 0)
	EndIf
EndFunc   ;==>cmbBalanceDR

Func chkDBRandomSpeedAtk()
	If GUICtrlRead($chkDBRandomSpeedAtk) = $GUI_CHECKED Then
		;$iChkDBRandomSpeedAtk = 1
		GUICtrlSetState($cmbDBUnitDelay, $GUI_DISABLE)
		GUICtrlSetState($cmbDBWaveDelay, $GUI_DISABLE)
	Else
		;$iChkDBRandomSpeedAtk = 0
		GUICtrlSetState($cmbDBUnitDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbDBWaveDelay, $GUI_ENABLE)
	EndIf
EndFunc   ;==>chkDBRandomSpeedAtk

Func chkABRandomSpeedAtk()
	If GUICtrlRead($chkABRandomSpeedAtk) = $GUI_CHECKED Then
		;$iChkABRandomSpeedAtk = 1
		GUICtrlSetState($cmbABUnitDelay, $GUI_DISABLE)
		GUICtrlSetState($cmbABWaveDelay, $GUI_DISABLE)
	Else
		;$iChkABRandomSpeedAtk = 0
		GUICtrlSetState($cmbABUnitDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbABWaveDelay, $GUI_ENABLE)
	EndIf
EndFunc   ;==>chkABRandomSpeedAtk
