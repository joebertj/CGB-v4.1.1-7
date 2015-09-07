
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
	Local $isTHOut = False

	$sided = GetTHSide($Thx, $Thy)
	If $searchTH <> "-" Then
		If Not FilterTH() Then Return False
		For $i = 0 To 20
			If $Thx < 114 + $i * 19 + Ceiling(($THaddtiles - 2) / 2 * 19) And $Thy < 359 - $i * 14 + Ceiling(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 0
				$isTHOut = True
			EndIf
			If $Thx < 117 + $i * 19 + Ceiling(($THaddtiles - 2) / 2 * 19) And $Thy > 268 + $i * 14 - Floor(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 1
				$isTHOut = True
			EndIf
			If $Thx > 743 - $i * 19 - Floor(($THaddtiles - 2) / 2 * 19) And $Thy < 358 - $i * 14 + Ceiling(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 2
				$isTHOut = True
			EndIf
			If $Thx > 742 - $i * 19 - Floor(($THaddtiles - 2) / 2 * 19) And $Thy > 268 + $i * 14 - Floor(($THaddtiles - 2) / 2 * 14) Then
				$THi = $i
				$THside = 3
				$isTHOut = True
			EndIf
		Next
		If $sided[1] < 3 + $THaddtiles Then
			If Not $isTHOut Then
				SetLog("Old formula says TH is Inside")
				$isTHOut = True
			EndIf
		EndIf
		If $isTHOut And $THside <> $sided[0] Then
			SetLog("THside using old formula: " & $THside & " while using new formula: " & $sided[0])
			$THside = $sided[0]
		EndIf
	EndIf
	Return $isTHOut
EndFunc   ;==>SearchTownHallLoc

Func FilterTH() ; Check for impossible TH location
	For $i = 0 To 20
		If $Thx < 52 + $i * 19 And $Thy < 315 - $i * 14 Then Return False
		If $Thx < 52 + $i * 19 And $Thy > 315 + $i * 14 Then Return False
		If $Thx > 802 - $i * 19 And $Thy < 315 - $i * 14 Then Return False
		If $Thx > 802 - $i * 19 And $Thy > 315 + $i * 14 Then Return False
	Next
	Return True
EndFunc   ;==>FilterTH

