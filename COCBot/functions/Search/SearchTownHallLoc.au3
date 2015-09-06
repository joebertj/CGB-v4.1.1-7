
; #FUNCTION# ====================================================================================================================
; Name ..........: SearchTownHallLoc
; Description ...:
; Syntax ........: SearchTownHallLoc()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #5
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func SearchTownHallLoc()
	Local $sided[2] = [0, 0]

	If $searchTH <> "-" Then
		If FilterTH() = False Then Return False



		For $i = 0 To 20

			If $Thx < 114 + $i * 19 + Ceiling(($THaddtiles - 2) / 2 * 19) And $Thy < 359 - $i * 14 + Ceiling(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 0
				Return True
			EndIf
			If $Thx < 117 + $i * 19 + Ceiling(($THaddtiles - 2) / 2 * 19) And $Thy > 268 + $i * 14 - Floor(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 1
				Return True
			EndIf
			If $Thx > 743 - $i * 19 - Floor(($THaddtiles - 2) / 2 * 19) And $Thy < 358 - $i * 14 + Ceiling(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 2
				Return True
			EndIf
			If $Thx > 742 - $i * 19 - Floor(($THaddtiles - 2) / 2 * 19) And $Thy > 268 + $i * 14 - Floor(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 3
				Return True
			EndIf
		Next
		$sided = GetTHSide($Thx, $Thy)
		If $THside <> $sided[0] Then
			SetLog("THside using old formula: " & $THside & " THside using new formula: " & $sided[0])
			$THside = $sided[0]
		EndIf
	EndIf
	Return False
EndFunc   ;==>SearchTownHallLoc

Func FilterTH()
	For $i = 0 To 20
		If $Thx < 52 + $i * 19 And $Thy < 315 - $i * 14 Then Return False
		If $Thx < 52 + $i * 19 And $Thy > 315 + $i * 14 Then Return False
		If $Thx > 802 - $i * 19 And $Thy < 315 - $i * 14 Then Return False
		If $Thx > 802 - $i * 19 And $Thy > 315 + $i * 14 Then Return False
	Next
	Return True
EndFunc   ;==>FilterTH

