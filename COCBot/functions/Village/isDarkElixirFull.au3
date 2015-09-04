; #FUNCTION# ====================================================================================================================
; Name ..........: isDarkElixirFull
; Description ...: Checks if your Dark Elixir Storages are maxed out
; Syntax ........: isDarkElixirFull()
; Parameters ....:
; Return values .: None
; Author ........: djbooya
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func isDarkElixirFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(700, 132), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(709, 132), Hex(0x190026, 6), 6) Then ;Hex if color of dark elixir (close to black)
			SetLog("Dark Elixir Storages are full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>isDarkElixirFull
