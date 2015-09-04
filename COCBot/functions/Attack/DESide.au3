Func DESpellDP()
	local $xLimit = 0
	local $yLimit = 0
	local $HSDist[2] = [60, 55]
	local $MaxDist[2] = [90, 90]
	$SpellDP[0] = 0
	$SpellDP[1] = 0

	If $DESLoc = 0 Then
		; assume the DE is in the center
		$DESLocx = $MapCenter[0]
		$DESLocy = $MapCenter[1]
	Endif
	If $DEEdge = 0 Then
		$xLimit = $MapCenter[0] + $MaxDist[0]
		$yLimit = $MapCenter[1] + $MaxDist[1]
		$SpellDP[0] = $DESLocx + $HSDist[0]
		$SpellDP[1] = $DESLocy + $HSDist[1]
		if $SpellDP[0] > $xLimit Then
			$SpellDP[0] = $xLimit
		Endif
		if $SpellDP[1] >  $yLimit Then
			$SpellDP[1] = $yLimit
		Endif
	ElseIf $DEEdge = 3 Then
		$xLimit = $MapCenter[0] + $MaxDist[0]
		$yLimit = $MapCenter[1] - $MaxDist[1]
		$SpellDP[0] = $DESLocx + $HSDist[0]
		$SpellDP[1] = $DESLocy - $HSDist[1]
		if $SpellDP[0] > $xLimit Then
			$SpellDP[0] = $xLimit
		Endif
		if $SpellDP[1] < $yLimit  Then
			$SpellDP[1] = $yLimit
		Endif
	ElseIf $DEEdge = 1 Then
		$xLimit = $MapCenter[0] - $MaxDist[0]
		$yLimit = $MapCenter[1] - $MaxDist[1]
		$SpellDP[0] = $DESLocx - $HSDist[0]
		$SpellDP[1] = $DESLocy - $HSDist[1]
		if $SpellDP[0] < $xLimit Then
			$SpellDP[0] = $xLimit
		Endif
		if $SpellDP[1] <  $yLimit Then
			$SpellDP[1] = $yLimit
		Endif
	ElseIf $DEEdge = 2 Then
		$xLimit = $MapCenter[0] - $MaxDist[0]
		$yLimit = $MapCenter[1] + $MaxDist[1]
		$SpellDP[0] = $DESLocx - $HSDist[0]
		$SpellDP[1] = $DESLocy + $HSDist[1]
		if $SpellDP[0] < $xLimit Then
			$SpellDP[0] = $xLimit
		Endif
		if $SpellDP[1] > $yLimit  Then
			$SpellDP[1] = $yLimit
		Endif
	EndIf
	SetLog ("Spell drop point: " & $SpellDP[0] & ", " & $SpellDP[1] , $COLOR_BLUE)
EndFunc	;==>DESpellDP

Func GetDEEdge() ;Using $DESLoc x y we are finding which side de is located.
	DExy()
	$DESideFound = True
	If $DESLoc = 1 Then
		If ($DESLocx = $MapCenter[0]) And ($DESLocy = $MapCenter[1]) Then
			SetLog("DE Storage Located in Middle... Attacking Random Side", $COLOR_BLUE)
			$DEEdge = (Random(Round(0, 3)))

		ElseIf ($DESLocx >= $MapCenter[0]) And ($DESLocy >= $MapCenter[1]) Then
			SetLog("DE Storage Located Bottom Right... Attacking Bottom Right", $COLOR_BLUE)
			$DEEdge = 0
		ElseIf ($DESLocx > $MapCenter[0]) And ($DESLocy < $MapCenter[1]) Then
			SetLog("DE Storage Located Top Right... Attacking Top Right", $COLOR_BLUE)
			$DEEdge = 3
		ElseIf ($DESLocx <= $MapCenter[0]) And ($DESLocy <= $MapCenter[1]) Then
			SetLog("DE Storage Located Top Left... Attacking Top Left", $COLOR_BLUE)
			$DEEdge = 1
		ElseIf ($DESLocx < $MapCenter[0]) And ($DESLocy > $MapCenter[1]) Then
			SetLog("DE Storage Located Bottom Left... Attacking Bottom Left", $COLOR_BLUE)
			$DEEdge = 2
		EndIf
	ElseIf $DESLoc = 0 Then
		SetLog("DE Storage Not Located... Attacking Random Side", $COLOR_BLUE)
		$DEEdge = (Random(Round(0, 3)))
	EndIf
EndFunc   ;==>GetDEEdge

Func CheckfoundorcoreDE()
	DExy()
	If $iSkipUndetectedDE = 1 Or ($iSkipUndetectedDE = 2 And $LBHeroFilter = 1) Then
		If $DESLoc = 0 Then
			SetLog("DE Storage Not Located, Skipping ", $COLOR_BLUE)
			Return False
		EndIf
	EndIf
	If $DESLoc = 1 And ($iSkipCentreDE = 1 Or ($iSkipCentreDE = 2 And $LBHeroFilter = 1))  Then
		If $DESLocy < ($DECorepix + $MapCenter[1]) And $DESLocy > ($DECorepix - $MapCenter[1]) And $DESLocx < ($DECorepix + $MapCenter[0]) And $DESLocx > ($DECorepix - $MapCenter[0]) Then
			SetLog("DE Storage Located in Core, Skipping", $COLOR_BLUE)
			Return False
		EndIf
	EndIf
	Return True
EndFunc	   ;==>CheckfoundorcoreDE


Func DExy()
	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2(230, 170, 630, 440)
	$DESTOLoc = GetLocationDarkElixirStorage()
	If (UBound($DESTOLoc) > 1) Then
		Local $centerPixel[2] = [430, 313]
		Local $arrPixelCloser = _FindPixelCloser($DESTOLoc, $centerPixel, 1)
		$pixel = $arrPixelCloser[0]
	ElseIf (UBound($DESTOLoc) > 0) Then
		$pixel = $DESTOLoc[0]
	Else
		$pixel = -1
	EndIf
	If $pixel = -1 Then
		$DESLoc = 0
		SetLog(" == DE Storage Not Found ==")
	Else
		$pixel[0] += 230 ; compensate CaptureRegion reduction
		$pixel[1] += 170 ; compensate CaptureRegion reduction
		SetLog("== DE lixir Storage : [" & $pixel[0] & "," & $pixel[1] & "] ==", $COLOR_BLUE)
		If _Sleep(1000) Then Return False
		$DESLocx = $pixel[0] ; compensation for $x center of Storage
		$DESLocy = $pixel[1] ; compensation for $y center of Storage
		$DESLoc = 1
	EndIf
EndFunc   ;==>DExy

Func DELow()
	Local $DarkE = ""
	Local $Dchk = 0
	Local $EndHero80perc = 1
	While $DarkE = "" ;~~~~~~~~Loop 10x or until Dark Elixer is Readable.
		$DarkE = getDarkElixirVillageSearch(48, 125)
		$Dchk += 1
		If _Sleep(50) Then Return
		If $Dchk >= 10 Then
			SetLog("Can't find De", $COLOR_RED)
			Return False
		EndIf
	WEnd
	If Number($DarkE) < (Number($searchDark) * (Number($DELowEndMin) / 100)) Then ; First check if Dark Elixer is below set minimum
		If _Sleep(50) Then Return
		$DarkE = getDarkElixirVillageSearch(48, 125)
		If _Sleep(50) Then Return
		If Number($DarkE) < (Number($searchDark) * (Number($DELowEndMin) / 100)) Then ; Second check if Dark Elixer is below set minimum
			If $DEEndAq = 1 And $dropQueen = True Then
				If $iActivateKQCondition = "Auto" Then
					If $checkQPower = False Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and AQ health Low. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					ElseIf $EndHero80perc = 1 And Not _ColorCheck(_GetPixelColor(87 + (72 * $Queen), 572, True), Hex(0x72F50B, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and AQ health 80%. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					EndIf
				Else
					If $EndHero80perc = 1 And Not _ColorCheck(_GetPixelColor(87 + (72 * $Queen), 572, True), Hex(0x72F50B, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and AQ health Low. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					ElseIf Not _ColorCheck(_GetPixelColor(68 + (72 * $Queen), 572, True), Hex(0x72F50B, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and AQ health 80%. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					EndIf
				EndIf
			EndIf
			If $DEEndBk = 1 And $dropKing = True Then
				If $iActivateKQCondition = "Auto" Then
					If $checkKPower = False Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and BK health Low. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					ElseIf $EndHero80perc = 1 And Not _ColorCheck(_GetPixelColor(87 + (72 * $King), 572, True), Hex(0x4FD404, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and BK health 80%. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					EndIf
				Else
					If $EndHero80perc = 1 And Not _ColorCheck(_GetPixelColor(87 + (72 * $King), 572, True), Hex(0x4FD404, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and BK health 80%. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					ElseIf Not _ColorCheck(_GetPixelColor(68 + (72 * $King), 572, True), Hex(0x4FD404, 6), 120, "Heroes") Then
						$DarkLow = 1
						SetLog("Low De. De = ( " & $DarkE & " ) and BK health Low. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
						Return False
					EndIf
				EndIf
			EndIf
			If $DEEndOneStar = 1 Then
				If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then
					SetLog("Low De. De = ( " & $DarkE & " ) and 1 star achieved. Return to protect Royals.  Returning immediately", $COLOR_GREEN)
					$DarkLow = 1
					Return False
				Else
					SetLog("Low De. ( " & $DarkE & " ) Waiting for 1 star", $COLOR_GREEN)
					$DarkLow = 2
					Return False
				EndIf
			EndIf
			If $DEEndAq = 0 And $DEEndBk = 0 And $DEEndOneStar = 0 Then
				$DarkLow = 1
				SetLog("Low De. De = ( " & $DarkE & " ). Return to protect Royals.  Returning immediately", $COLOR_GREEN)
				Return False
			EndIf
		Else
			SetLog("De EBO Check. Second DE check failed Read as De = ( " & $DarkE & " )", $COLOR_GREEN)
		EndIf
	Else
		SetLog("De EBO Check. De = ( " & $DarkE & " ) waiting for " & Round((Number($searchDark) * (Number($DELowEndMin) / 100)),0) & " Before exiting", $COLOR_GREEN)
		$DarkLow = 0
	EndIf
EndFunc   ;==>DELow

Func SaveandDisableEBO()
	$saveichkEndOneStar = $ichkEndOneStar
	$saveichkEndTwoStars = $ichkEndTwoStars
	$saveichkTimeStopAtk = $ichkTimeStopAtk
	$saveiChkTimeStopAtk2 = $iChkTimeStopAtk2
	$ichkEndOneStar = 0
	$ichkEndTwoStars = 0
	$ichkTimeStopAtk = 0
	$iChkTimeStopAtk2 = 0
EndFunc 	;==>SaveandDisableEBO

Func RevertEBO()
	$ichkEndOneStar = $saveichkEndOneStar
	$ichkEndTwoStars = $saveichkEndTwoStars
	$ichkTimeStopAtk = $saveichkTimeStopAtk
	$iChkTimeStopAtk2 = $saveiChkTimeStopAtk2
EndFunc 	;==>RevertEBO