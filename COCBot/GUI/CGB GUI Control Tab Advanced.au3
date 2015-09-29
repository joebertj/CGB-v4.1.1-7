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

Func chkUnbreakable()
	If GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinDark, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxDark, $GUI_ENABLE)
		$iUnbreakableMode = 1
	ElseIf GUICtrlRead($chkUnbreakable) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinDark, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxDark, $GUI_DISABLE)
		$iUnbreakableMode = 0
	EndIf
EndFunc   ;==>chkUnbreakable

Func chkAttackNow()
	If GUICtrlRead($chkAttackNow) = $GUI_CHECKED Then
		$iChkAttackNow = 1
		GUICtrlSetState($lblAttackNow, $GUI_ENABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_ENABLE)
	Else
		$iChkAttackNow = 0
		GUICtrlSetState($lblAttackNow, $GUI_DISABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkAttackNow

#comments-start
Func GUILightSpell()
	If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
		$iChkLightSpell = 1
		GUICtrlSetState($lbliLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_ENABLE)
	Else
		$iChkLightSpell = 0
		GUICtrlSetState($lbliLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_DISABLE)
	EndIf
EndFunc   ;==>GUILightSpell
#comments-end

Func chkBullyMode()
	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		$OptBullyMode = 1
		GUICtrlSetState($txtATBullyMode, $GUI_ENABLE)
		GUICtrlSetState($cmbYourTH, $GUI_ENABLE)
		GUICtrlSetState($radUseDBAttack, $GUI_ENABLE)
		GUICtrlSetState($radUseLBAttack, $GUI_ENABLE)
	Else
		$OptBullyMode = 0
		GUICtrlSetState($txtATBullyMode, $GUI_DISABLE)
		GUICtrlSetState($cmbYourTH, $GUI_DISABLE)
		GUICtrlSetState($radUseDBAttack, $GUI_DISABLE)
		GUICtrlSetState($radUseLBAttack, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBullyMode

Func chkSnipeMode()
	If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		$OptTrophyMode = 1
		SetTroopsTh()
		GUICtrlSetState($txtTHaddtiles, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_ENABLE)
	    ;GUICtrlSetState($cmbAttackbottomType, $GUI_ENABLE)
		GUICtrlSetState($chkIgnoreTraps, $GUI_ENABLE)
		GUICtrlSetState($chkIgnoreAirTraps, $GUI_ENABLE)
		GUICtrlSetState($chkParanoid, $GUI_ENABLE)
		GUICtrlSetState($chkGreedy, $GUI_ENABLE)
	Else
		$OptTrophyMode = 0
		RevertTroops()
		GUICtrlSetState($txtTHaddtiles, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_DISABLE)
		;GUICtrlSetState($cmbAttackbottomType, $GUI_DISABLE)
		GUICtrlSetState($chkIgnoreTraps, $GUI_DISABLE)
		GUICtrlSetState($chkIgnoreAirTraps, $GUI_DISABLE)
		GUICtrlSetState($chkParanoid, $GUI_DISABLE)
		GUICtrlSetState($chkGreedy, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkSnipeMode
;;; Toolbox
Func chkToolboxModeWar()
    If GUICtrlRead($chkToolboxModeWar) = $GUI_CHECKED Then
        $ToolboxModeWar = True
        $ToolboxModeBot    = False
        $ToolboxModeSearch = False
        If Not $ToolboxActive Then
            _GUI_Toolbox_Show()
        EndIf
    Else
        $ToolboxModeWar = False
        $ToolboxModeBot    = (GUICtrlRead($chkToolboxModeBot) = $GUI_CHECKED)
        $ToolboxModeSearch = (GUICtrlRead($chkToolboxModeSearch) = $GUI_CHECKED)
        If $ToolboxActive Then
            _GUI_Toolbox_Hide()
        EndIf
    EndIf
EndFunc

Func chkToolboxModeBot()
    $ToolboxModeBot = (GUICtrlRead($chkToolboxModeBot) = $GUI_CHECKED)
EndFunc

Func chkToolboxModeSearch()
    $ToolboxModeSearch = (GUICtrlRead($chkToolboxModeSearch) = $GUI_CHECKED)
EndFunc

Func chkToolboxDetach()
    Local $val = (GUICtrlRead($chkToolboxDetach) = $GUI_CHECKED)
    Local $restore = $ToolboxActive
    If $restore Then
        ($ToolboxDetached) ? _GUI_Toolbox_Win_Hide() : _GUI_Toolbox_GUI_Hide()
        ;_GUI_Toolbox_Hide()
    EndIf
    $ToolboxDetached = $val
    If $restore Then
        ($ToolboxDetached) ? _GUI_Toolbox_Win_Show() : _GUI_Toolbox_GUI_Show()
    EndIf
    If $val Then
        _GUICtrlButton_SetText($chkToolboxDetach, "Detached")
    Else
        _GUICtrlButton_SetText($chkToolboxDetach, "Attached")
    EndIf
EndFunc

Func chkToolboxSavePos()
    $ToolboxSavePos = (GUICtrlRead($chkToolboxDetach) = $GUI_CHECKED)
EndFunc
Func SetTroopsTh()
	If $OptTrophyMode = 1 Then
		for $i=0 to Ubound($THSnipeTroopGroup,1) - 1
			$TroopName[$i]         	= $THSnipeTroopGroup[$i][0]
			$TroopNamePosition[$i] 	= $THSnipeTroopGroup[$i][1]
			$TroopHeight[$i]       	= $THSnipeTroopGroup[$i][2]
		next
	EndIf
EndFunc
Func RevertTroops()
	If $OptTrophyMode = 0 and GUICtrlRead($chkSnipeWhileTrain) = $GUI_UNCHECKED Then

	For $i = 0 To UBound($TroopGroup, 1) - 1
	    $TroopName[$i]              = $TroopGroup[$i][0]
	    $TroopNamePosition[$i]      = $TroopGroup[$i][1]
	    $TroopHeight[$i]            = $TroopGroup[$i][2]
    Next

	EndIf
EndFunc
