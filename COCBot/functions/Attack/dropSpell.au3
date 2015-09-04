;Drops Clan Castle troops, given the slot and x, y coordinates.

; #FUNCTION# ====================================================================================================================
; Name ..........: dropSpell
; Description ...: Drops Spell, given the spell and x, y coordinates.
; Syntax ........: dropSpell($x, $y, $spell)
; Parameters ....: $x                   - X location.
;                  $y                   - Y location.
;                  $spell               - spell
; Return values .: None
; Author ........:
; Modified ......:Knowskones 31/7/15 updated for new troop bar.
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func dropSpell($x, $y, $spell) ;Drop Spell
   If $spell <> -1 Then
	 For $i = 0 To 8
		If $atkTroops[$i][0] = $spell Then
		If _Sleep(100) Then Return
		   SetLog("Dropping spell in slot " & $i, $COLOR_BLUE)
		   Click(68 + (72 * $i), 595) ;Select spell (FIXME: add debug info)
		   If _Sleep(500) Then Return
		   Click($x, $y) ; drop it (FIXME: add debug info)
		   exitloop
		Endif
	 Next
   EndIf
EndFunc   ;==>dropSpell