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

Func cmbTroopComp()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $icmbTroopComp Then
		$icmbTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		For $i = 0 To UBound($TroopName) - 1
			Assign("Cur" & $TroopName[$i], 1)
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			Assign("Cur" & $TroopDarkName[$i], 1)
		Next
		SetComboTroopComp()
	EndIf
EndFunc   ;==>cmbTroopComp

Func SetComboTroopComp()
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumArch, "100")
		Case 1
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumBarb, "100")
		Case 2
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumGobl, "100")
		Case 3
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			GUICtrlSetData($txtNumBarb, "50")
			GUICtrlSetData($txtNumArch, "50")
		Case 4
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			GUICtrlSetData($txtNumBarb, "10")
			GUICtrlSetData($txtNumArch, "50")
			GUICtrlSetData($txtNumGobl, "30")
			GUICtrlSetData($txtNumGiant, "10")

		Case 5
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			GUICtrlSetData($txtNumBarb, "40")
			GUICtrlSetData($txtNumArch, "50")
			GUICtrlSetData($txtNumGiant, "10")
		Case 6
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumBarb, "20")
			GUICtrlSetData($txtNumArch, "50")
			GUICtrlSetData($txtNumGobl, "30")
		Case 7
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_CHECKED)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			GUICtrlSetData($txtNumBarb, "10")
			GUICtrlSetData($txtNumArch, "50")
			GUICtrlSetData($txtNumGobl, "25")
			GUICtrlSetData($txtNumGiant, "10")
			GUICtrlSetData($txtNumWall, "5")
		Case 8
			GUICtrlSetState($cmbBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_ENABLE)
			;GUICtrlSetState($txtCapacity, $GUI_DISABLE)
			GUICtrlSetState($radAccuracy, $GUI_DISABLE)
			GUICtrlSetState($radSpeed, $GUI_DISABLE)
			GUICtrlSetState($chkUsePercent, $GUI_DISABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_DISABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_DISABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), False)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
			Next
		Case 9
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbDarkBarrack2, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($radAccuracy, $GUI_ENABLE)
			GUICtrlSetState($radSpeed, $GUI_ENABLE)
			GUICtrlSetState($chkUsePercent, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), False)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), False)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), Eval($TroopName[$i] & "Comp"))
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
			Next

	EndSwitch
	lblTotalCount()
EndFunc   ;==>SetComboTroopComp

Func lblTotalCount()
	Local $i

	If GUICtrlRead($chkUsePercent) = $GUI_CHECKED Then
		$ichkUsePercent = 1
	Else
		$ichkUsePercent = 0
	EndIf

	If $ichkUsePercent = 1 Then
		GUICtrlSetData($lblTotalCount, GUICtrlRead($txtNumBarb) + GUICtrlRead($txtNumArch) + GUICtrlRead($txtNumGiant) + GUICtrlRead($txtNumGobl) + GUICtrlRead($txtNumWall) + GUICtrlRead($txtNumBall) + GUICtrlRead($txtNumWiza) + GUICtrlRead($txtNumHeal) + GUICtrlRead($txtNumDrag) + GUICtrlRead($txtNumPekk) + GUICtrlRead($txtNumMini) + GUICtrlRead($txtNumHogs) + GUICtrlRead($txtNumValk) + GUICtrlRead($txtNumGole) + GUICtrlRead($txtNumWitc) + GUICtrlRead($txtNumLava))
		$i = 100
	Else
		GUICtrlSetData($lblTotalCount, GUICtrlRead($txtNumBarb) + GUICtrlRead($txtNumArch) + GUICtrlRead($txtNumGiant)*5 + GUICtrlRead($txtNumGobl) + GUICtrlRead($txtNumWall)*2 + GUICtrlRead($txtNumBall)*5 + GUICtrlRead($txtNumWiza)*4 + GUICtrlRead($txtNumHeal)*14 + GUICtrlRead($txtNumDrag)*20 + GUICtrlRead($txtNumPekk)*25 + GUICtrlRead($txtNumMini)*2 + GUICtrlRead($txtNumHogs)*5 + GUICtrlRead($txtNumValk)*8 + GUICtrlRead($txtNumGole)*30 + GUICtrlRead($txtNumWitc)*12 + GUICtrlRead($txtNumLava)*30)
		$i = $TotalCamp
	EndIf
	If GUICtrlRead($lblTotalCount) = $i Then
		GUICtrlSetBkColor($lblTotalCount, $COLOR_MONEYGREEN)
	ElseIf GUICtrlRead($lblTotalCount) < $i Then
		GUICtrlSetBkColor($lblTotalCount, $COLOR_ORANGE)
	Else
		GUICtrlSetBkColor($lblTotalCount, $COLOR_RED)
	EndIf
EndFunc   ;==>lblTotalCount
