;l; #FUNCTION# ====================================================================================================================
; Name ..........: checkDefense
; Description ...: This file Includes the Variables and functions to detect certain defenses near TH, based on checkTownhall.au3
; Syntax ........: checkDefense()
; Parameters ....: None
; Return values .: $Defx, $Defy
; Author ........: barracoda
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#cs
	*******************************************************************
	HOW TO USE:
	1) If you're using "Normal" TH Snipe algorithm (or one that uses Ground & Air troops), set both $grdTroops & $airTroops to 1.
	If you set $grdTroops to 1, it will ignore air defense. If you set $airTroops to 1, it will ignore mortars.
	3) Set $chkMortar, $chkWiz, $chkInferno, $chkTesla, $chkAir to 1 if you want to skip bases that have these near the TH. Otherwise set them to 0. By default, only inferno is set to 1.
	4) The default algorithms are not recommended, as they use both ground and air troops (B.A.M.).
	*******************************************************************
#ce
Global $chkWall = 1, $chkMortar = 1, $chkWiz = 1, $chkInferno = 1, $chkTesla = 1, $chkAir = 1, $grdTroops = 0, $airTroops = 0

Global $trapTH[5][20]

;Global $trapTHtxt[5][20] = [["L3M Inferno", "L3M Inferno", "L3S Inferno", "L2M Inferno", "L2M Inferno", "L2S Inferno", "L1M Inferno", "L1M Inferno", "L1S Inferno", "", "", "", "", "", "", "", "", "", "", ""], ["L8 Tesla", "L8 Tesla", "L7 Tesla", "L7 Tesla", "L7 Tesla", "L6 Tesla", "L6 Tesla", "L6 Tesla", "", "", "", "", "", "", "", "", "", "", "", ""], ["L8 Mortar", "L7 Mortar", "L6 Mortar", "L5 Mortar", "L7 Mortar", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""], ["L8 Wiz Tower", "L7 Wiz Tower", "L6 Wiz Tower", "L5 Wiz Tower", "L4 Wiz Tower", "L7 Wiz Tower", "", "", "", "", "", "", "", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]]

;Inferno Towers
$trapTH[0][0] = @ScriptDir & "\images\Defense\infe3ma.png"
$trapTH[0][1] = @ScriptDir & "\images\Defense\infe3mb.png"
$trapTH[0][2] = @ScriptDir & "\images\Defense\infe3s.png"
$trapTH[0][3] = @ScriptDir & "\images\Defense\infe2ma.png"
$trapTH[0][4] = @ScriptDir & "\images\Defense\infe2mb.png"
$trapTH[0][5] = @ScriptDir & "\images\Defense\infe2s.png"
$trapTH[0][6] = @ScriptDir & "\images\Defense\infe1ma.png"
$trapTH[0][7] = @ScriptDir & "\images\Defense\infe1mb.png"
$trapTH[0][8] = @ScriptDir & "\images\Defense\infe1s.png"

;Hidden Teslas
$trapTH[1][0] = @ScriptDir & "\images\Defense\tesl8a.png"
$trapTH[1][1] = @ScriptDir & "\images\Defense\tesl8b.png"
$trapTH[1][2] = @ScriptDir & "\images\Defense\tesl7a.png"
$trapTH[1][3] = @ScriptDir & "\images\Defense\tesl7b.png"
$trapTH[1][4] = @ScriptDir & "\images\Defense\tesl7c.png"
$trapTH[1][5] = @ScriptDir & "\images\Defense\tesl6a.png"
$trapTH[1][6] = @ScriptDir & "\images\Defense\tesl6b.png"
$trapTH[1][7] = @ScriptDir & "\images\Defense\tesl6c.png"
;$trapTH[1][8] = @ScriptDir & "\images\Defense\tesl5.png"
;$trapTH[1][9] = @ScriptDir & "\images\Defense\tesl4.png"
;$trapTH[1][5] = @ScriptDir & "\images\Defense\tesl3.png"
;$trapTH[1][6] = @ScriptDir & "\images\Defense\tesla2.png"
;$trapTH[1][7] = @ScriptDir & "\images\Defense\tesla1.png"

;Mortars
$trapTH[2][0] = @ScriptDir & "\images\Defense\mort8.png"
$trapTH[2][1] = @ScriptDir & "\images\Defense\mort7.png"
$trapTH[2][2] = @ScriptDir & "\images\Defense\mort6.png"
$trapTH[2][3] = @ScriptDir & "\images\Defense\mort5.png"
$trapTH[2][4] = @ScriptDir & "\images\Defense\mort7a.png"

;Wizard Towers
$trapTH[3][0] = @ScriptDir & "\images\Defense\wiz8.png"
$trapTH[3][1] = @ScriptDir & "\images\Defense\wiz7.png"
$trapTH[3][2] = @ScriptDir & "\images\Defense\wiz6.png"
$trapTH[3][3] = @ScriptDir & "\images\Defense\wiz5.png"
$trapTH[3][4] = @ScriptDir & "\images\Defense\wiz4.png"
$trapTH[3][5] = @ScriptDir & "\images\Defense\wiz7a.png"

;Air Defense
$trapTH[4][0] = @ScriptDir & "\images\Defense\air6.png"
$trapTH[4][1] = @ScriptDir & "\images\Defense\air7.png"

;Global $defTolerance[5][50] = [[15, 15, 15, 15, 40, 10, 8, 8, 8, 1, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [40, 40, 40, 12, 12, 12, 10, 10, 10, 5, 5, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [15, 40, 40, 40, 40, 10, 12, 10, 12, 5, 5, 5, 12, 12, 12, 12, 10, 10, 8, 20, 10, 20, 20, 10, 10, 15, 15, 8, 30, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [15, 15, 15, 15, 15, 15, 10, 10, 10, 10, 5, 5, 5, 15, 20, 15, 20, 5, 20, 15, 5, 20, 20, 10, 10, 30, 30, 30, 30, 30, 30, 40, 40, 30, 40, 40, 40, 40, 40, 40, 40, 40, 30, 30, 40, 40, 40, 30, 40, 40], [20, 20, 20, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

Func checkDefense()
	Local $defSimilarity[5][20] = [[0.92, 0.92, 0.91, 0.92, 0.92, 0.91, 0.92, 0.92, 0.92, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0.94, .92, 0.90, 0.90, 0.90, 0.91, 0.91, 0.96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0.91, 0.905, 0.935, 0.92, 0.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0.94, 0.94, 0.95, 0.94, 0.94, 0.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0.95, 0.95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
	;$defTolerance[5][50] = [[32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], [32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], [32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], [32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], [32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32]]

	$allTroops = False
	$skipBase = False
	Local $numDefFound = 0;

	$airTroops = $OptIgnoreTraps
	$grdTroops = $OptIgnoreAirTraps
	Local $d[4], $e[4], $f[4]

	Local $numWallFound = 0
	Local $icmbWallsLocal = 0
	Local $WallLoopCounter = 0

	If $airTroops = 1 Then
		$chkMortar = 0
		$chkWall = 0
	EndIf
	If $grdTroops = 1 Then
		$chkAir = 0
	EndIf
	If $airTroops = 1 And $grdTroops = 1 Then
		$chkWiz = 0
		$chkInferno = 0
		$chkTesla = 0
	EndIf

	SetLog("Checking Trapped TH", $COLOR_BLUE)

	_CaptureTH()
	For $t = 0 To 4
		For $i = 0 To 9
			If FileExists($trapTH[$t][$i]) Then
				;$DefLocation = _ImageSearch($trapTH[$t][$i], 1, $Defx, $Defy, $defTolerance[$t][$i]) ; Getting Defense Location
				;Setlog("Trying with " & $DefText[$t] & " image " & $i)

				$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
				$res = DllCall($LibDir & "\ImageSearch.dll", "str", "searchTile", "handle", $sendHBitmap, "str", $trapTH[$t][$i], "float", $defSimilarity[$t][$i])
				;_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\checkDefense.png")
				_WinAPI_DeleteObject($sendHBitmap)

				If IsArray($res) Then
					;SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
					If $res[0] = "0" Then
						$res = ""
					ElseIf $res[0] = "-1" Then
						;SetLog("DLL Error", $COLOR_RED)
						Return "DLL Error"
					Else
						$expRet = StringSplit($res[0], "|", 2)
						$Defx = Int($expRet[1])
						$Defy = Int($expRet[1 + 1])
						$numDefFound += 1

						; check if trap is nearer to deployment line than TH
						Switch $THside
							Case 0
								$e = GetDistance(0, 0, $Defx, $Defy)
								$f = GetDistance(0, 0, 125, 90)
							Case 1
								$e = GetDistance(0, 180, $Defx, $Defy)
								$f = GetDistance(0, 180, 125, 90)
							Case 2
								$e = GetDistance(250, 0, $Defx, $Defy)
								$f = GetDistance(250, 0, 125, 90)
							Case 3
								$e = GetDistance(250, 180, $Defx, $Defy)
								$f = GetDistance(250, 180, 125, 90)
						EndSwitch
						;Setlog($trapTHtxt[$t][$i] & " Found")
						$d = GetDistance(125, 90, $Defx, $Defy) ; 250x180 image TH is center
						SetLog($DefText[$t] & " coordinates: " & $Defx & " ," & $Defy)
						SetLog("Distance from TH: " & $d[2] & " pixels or " & $d[3] & " tiles")
						SetLog($DefText[$t] & " distance from deployment side is " & $e[3])
						SetLog("TH distance from deployment side is " & $f[3])
						;minimum 1 tile distance to discount a false positive and minus 1 to maximum range for trap effectivity
						If $chkInferno = 1 And $DefText[$t] = "Inferno Tower" Then
							SetLog("Inferno Tower distance from TH is " & $d[3]);range 9
							If $d[3] > 1 And $d[3] < 9 - 1 Or $e[3] < $f[3] Then
								$skipBase = True
								Return "Inferno Tower found near TH, skipping..."
							EndIf
						ElseIf $chkTesla = 1 And $DefText[$t] = "Hidden Tesla" Then
							SetLog("Hidden Tesla distance is " & $d[3]);range 6-7
							If $d[3] > 1 And $d[3] < 7 - 1 Or $e[3] < $f[3] Then
								$skipBase = True
								Return "Hidden Tesla found near TH, skipping..."
							EndIf
						ElseIf $chkMortar = 1 And $DefText[$t] = "Mortar" Then
							SetLog("Mortar distance is " & $d[3]);range is 4-11, minimum range 4 is not really a factor
							If $d[3] > 1 And $d[3] < 11 - 1 Or $e[3] < $f[3] Then
								$skipBase = True
								Return "Mortar found near TH, skipping..."
							EndIf
						ElseIf $chkWiz = 1 And $DefText[$t] = "Wizard Tower" Then
							SetLog("Wizard Tower distance is " & $d[3]);range is 7
							If $d[3] > 1 And $d[3] < 7 - 1 Or $e[3] < $f[3] Then
								$skipBase = True
								Return "Wizard Tower found near TH, skipping..."
							EndIf
						ElseIf $chkAir = 1 And $DefText[$t] = "Air Defense" Then
							SetLog("Air Defense distance is " & $d[3]);range is 10
							If $d[3] > 1 And $d[3] < 10 - 1 Or $e[3] < $f[3] Then
								$skipBase = True
								Return "Air Defense found near TH, skipping..."
							EndIf
						Else
							If $AttackTHType <> 6 And ($Defx > 5 And $Defx < 245) And ($Defy > 10 And $Defy < 170) Then
								$skipBase = False
								$allTroops = True
								Return $DefText[$t] & " found at " & $Defx & "," & $Defy & ". Using alternative attack strategy!"
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	Next
	; check wall trap
	For $icmbWallsLocal = 0 To 7
		For $ImageIndex = 0 To 2
			If Not FileExists($Wall[$icmbWallsLocal][$ImageIndex]) Then
				SetLog("File Not Found", $COLOR_RED)
				Return False
			EndIf
			$res = ""

			If _Sleep(500) Then Return
			_CaptureTH()
			$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
			$res = DllCall($LibDir & "\ImageSearch.dll", "str", "searchTile", "handle", $sendHBitmap, "str", $Wall[$icmbWallsLocal][$ImageIndex], "float", 0.910)
			_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\checkDefense.png")
			_WinAPI_DeleteObject($sendHBitmap)

			If IsArray($res) Then
				;SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
				If $res[0] = "0" Then
					; failed to find any wall of current Level
					$res = ""
				ElseIf $res[0] = "-1" Then
					SetLog("DLL Error", $COLOR_RED)
					Return False
				ElseIf $res[0] = "-2" Then
					SetLog("Invalid Resolution", $COLOR_RED)
					Return False
				Else

					$expRet = StringSplit($res[0], "|", 2)
					For $j = 1 To UBound($expRet) - 1 Step 2
						$WallX = Int($expRet[$j])
						$WallY = Int($expRet[$j + 1])
						Switch $THside
							Case 0
								$e = GetDistance(0, 0, $WallX, $WallY)
								$f = GetDistance(0, 0, 125, 90)
							Case 1
								$e = GetDistance(0, 180, $WallX, $WallY)
								$f = GetDistance(0, 180, 125, 90)
							Case 2
								$e = GetDistance(250, 0, $WallX, $WallY)
								$f = GetDistance(250, 0, 125, 90)
							Case 3
								$e = GetDistance(250, 180, $WallX, $WallY)
								$f = GetDistance(250, 180, 125, 90)
						EndSwitch
						If $e[3] < $f[3] Then
							$numWallFound += 1
						EndIf
						$WallLoopCounter += 1
						If($WallLoopCounter > 100) Then ExitLoop
					Next
				EndIf
				If _Sleep(250) Then Return
			EndIf
		Next
	Next
	SetLog($numWallFound & " walls found")
	If $chkWall = 1 And $numWallFound > 10 Then
		$skipBase = True
		Return "Wall trap found"
	ElseIf $numWallFound > 0 Then
		Return "Walls found but not a problem."
	ElseIf $numDefFound > 0 Then
		Return "Defense found, but not near TH."
	Else
		Return "No major traps found near TH."
	EndIf
EndFunc   ;==>checkDefense



