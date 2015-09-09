; #FUNCTION# ====================================================================================================================
; Name ..........: algorith_AllTroops
; Description ...: This file contens all functions to attack algorithm will all Troops , using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Syntax ........: algorithm_AllTroops()
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: Didipe (May-2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
	$King = -1
	$Queen = -1
	$CC = -1
	For $i = 0 To UBound($atkTroops) - 1
		If $atkTroops[$i][0] = $eCastle Then
			$CC = $i
		ElseIf $atkTroops[$i][0] = $eKing Then
			$King = $i
		ElseIf $atkTroops[$i][0] = $eQueen Then
			$Queen = $i
		EndIf
	Next

	If _Sleep($iDelayalgorithm_AllTroops1) Then Return

	If $iMatchMode = $TS Or ($chkATH = 1 And SearchTownHallLoc()) Then
		If $allTroops = True Then ; added
            AttackTrappedTH() ; added
        Else ; added
		Switch $AttackTHType
			Case 0
				algorithmTH()
				;_CaptureRegion()
				If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then AttackTHNormal() ;if 'no' use another attack mode.
			Case 1
				AttackTHNormal();Good for Masters
			Case 2
				AttackTHXtreme();Good for Champ
			Case 3
				AttackTHGbarch()
			Case 4
				AttackTHSmartBarch(); Good for Snipe While Train
			Case 5
				MasterGiBAM() ;Excellent for champions and all
			Case 6
				AttackTHPB6()
			Case 7
                AttackTHWizard() ; Good for Master to Champ
		    Case 8
				AttackTHDragon() ; Good for master to Champ
		EndSwitch
		If $zoomedin = True Then
			ZoomOut()
			$zoomedin = False
			$zCount = 0
			$sCount = 0
		EndIf
		EndIf ; added
	EndIf

	;If $OptTrophyMode = 1 And SearchTownHallLoc() Then; Return ;Exit attacking if trophy hunting and not bullymode
	If $iMatchMode = $TS Then; Return ;Exit attacking if trophy hunting and not bullymode
		For $i = 1 To 30
			;_CaptureRegion()
			If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then ExitLoop ;exit if not 'no star'
			_Sleep($iDelayalgorithm_AllTroops2)
		Next

		ClickP($aSurrenderButton, 1, 0, "#0030") ;Click Surrender
		If _Sleep($iDelayalgorithm_AllTroops3) Then Return
		ClickP($aConfirmSurrender, 1, 0, "#0031") ;Click Confirm
		Return
	EndIf

	If ($iChkRedArea[$iMatchMode]) Then
		SetLog("Calculating Smart Attack Strategy", $COLOR_BLUE)
		Local $hTimer = TimerInit()
		_WinAPI_DeleteObject($hBitmapFirst)
		$hBitmapFirst = _CaptureRegion2()
		_GetRedArea()

		SetLog("Calculated  (in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds) :")
		;SetLog("	[" & UBound($PixelTopLeft) & "] pixels TopLeft")
		;SetLog("	[" & UBound($PixelTopRight) & "] pixels TopRight")
		;SetLog("	[" & UBound($PixelBottomLeft) & "] pixels BottomLeft")
		;SetLog("	[" & UBound($PixelBottomRight) & "] pixels BottomRight")


		If ($iChkSmartAttack[$iMatchMode][0] = 1 Or $iChkSmartAttack[$iMatchMode][1] = 1 Or $iChkSmartAttack[$iMatchMode][2] = 1) Then
			SetLog("Locating Mines, Collectors & Drills", $COLOR_BLUE)
			$hTimer = TimerInit()
			Global $PixelMine[0]
			Global $PixelElixir[0]
			Global $PixelDarkElixir[0]
			Global $PixelNearCollector[0]
			; If drop troop near gold mine
			If ($iChkSmartAttack[$iMatchMode][0] = 1) Then
				$PixelMine = GetLocationMine()
				If (IsArray($PixelMine)) Then
					_ArrayAdd($PixelNearCollector, $PixelMine)
				EndIf
			EndIf
			; If drop troop near elixir collector
			If ($iChkSmartAttack[$iMatchMode][1] = 1) Then
				$PixelElixir = GetLocationElixir()
				If (IsArray($PixelElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelElixir)
				EndIf
			EndIf
			; If drop troop near dark elixir drill
			If ($iChkSmartAttack[$iMatchMode][2] = 1) Then
				$PixelDarkElixir = GetLocationDarkElixir()
				If (IsArray($PixelDarkElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelDarkElixir)
				EndIf
			EndIf
			SetLog("Located  (in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds) :")
			SetLog("[" & UBound($PixelMine) & "] Gold Mines")
			SetLog("[" & UBound($PixelElixir) & "] Elixir Collectors")
			SetLog("[" & UBound($PixelDarkElixir) & "] Dark Elixir Drill/s")
		EndIf

	EndIf

	;############################################# LSpell Attack ############################################################
	; DropLSpell()
	;########################################################################################################################
	Local $nbSides = 0
	Switch $iChkDeploySettings[$iMatchMode]
		Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on a single side", $COLOR_BLUE)
			$nbSides = 1
		Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on two sides", $COLOR_BLUE)
			$nbSides = 2
		Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on three sides", $COLOR_BLUE)
			$nbSides = 3
		Case 3 ;All sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on all sides", $COLOR_BLUE)
			$nbSides = 4
		Case 4 ;Four Finger Style~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking with four fingers", $COLOR_BLUE)
			$nbSides = 5
		Case 5
			SetLog("Attacking using PB6")
			AttackTHPB6()
		Case 6
			SetLog("Attacking using PB6:Lavaloonion")
			AttackTHLavaloonion()
	    Case 7 ;DE Side - Live Base only ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on Dark Elixir Side.", $COLOR_BLUE)
			$nbSides = 1
			GetDEEdge()
	EndSwitch
	If ($nbSides = 0) Then Return
	If _Sleep($iDelayalgorithm_AllTroops2) Then Return

	If $DESideFound = True Then   ; Customise DE side wave deployment here
		Local $listInfoDeploy[15][5] = [[$eGiant, $nbSides, 1, 1, 0] _
			, [$eWall, $nbSides, 1, 2, 1] _
			, [$eBarb, $nbSides, 1, 2, 0] _
			, [$eArch, $nbSides, 1, 3, 0] _
			, [$eBarb, $nbSides, 2, 2, 0] _
			, [$eArch, $nbSides, 2, 3, 0] _
			, ["CC", 1, 1, 1, 1] _
			, ["HEROES", 1, 2, 1, 0] _
			, ["SPELL", 1, 1, 1, 1] _
			, [$eWall, $nbSides, 2, 2, 1] _
			, [$eHogs, $nbSides, 1, 1, 1] _
			, [$eWiza, $nbSides, 1, 1, 0] _
			, [$eMini, $nbSides, 1, 1, 0] _
			, [$eArch, $nbSides, 3, 3, 1] _
			, [$eGobl, $nbSides, 1, 1, 0] _
			]

	ElseIf $nbSides = 5 then ; Customise Four Finger wave Deployment here
	    Local $listInfoDeploy[11][5] = [[$eGiant, $nbSides, 1, 1, 0] _
			, [$eBarb, $nbSides, 1, 1, 0] _
			, [$eArch, $nbSides, 1, 1, 0] _
			, [$eMini, $nbSides, 1, 1, 0] _
			, [$eWall, $nbSides, 1, 1, 1] _
			, [$eGobl, $nbSides, 1, 2, 0] _
			, ["CC", 1, 1, 1, 1] _
			, [$eHogs, $nbSides, 1, 1, 1] _
			, [$eWiza, $nbSides, 1, 1, 0] _
			, [$eGobl, $nbSides, 2, 2, 0] _
			, ["HEROES", 1, 2, 1, 1] _
			]

	Else
		Local $listInfoDeploy[13][5] = [[$eGiant, $nbSides, 1, 1, 2] _
			, [$eBarb, $nbSides, 1, 2, 0] _
			, [$eWall, $nbSides, 1, 1, 1] _
			, [$eArch, $nbSides, 1, 2, 0] _
			, [$eBarb, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 1, 2, 0] _
			, ["CC", 1, 1, 1, 1] _
			, [$eHogs, $nbSides, 1, 1, 1] _
			, [$eWiza, $nbSides, 1, 1, 0] _
			, [$eMini, $nbSides, 1, 1, 0] _
			, [$eArch, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 2, 2, 0] _
			, ["HEROES", 1, 2, 1, 1] _
			]
	EndIf

	LaunchTroop2($listInfoDeploy, $CC, $King, $Queen)

	If _Sleep($iDelayalgorithm_AllTroops4) Then Return
	SetLog("Dropping left over troops", $COLOR_BLUE)
	For $x = 0 To 1
		PrepareAttack($iMatchMode, True) ;Check remaining quantities
		For $i = $eBarb To $eLava ; lauch all remaining troops
			;If $i = $eBarb Or $i = $eArch Then
			LauchTroop($i, $nbSides, 0, 1)
			CheckHeroesHealth()
			;Else
			;	 LauchTroop($i, $nbSides, 0, 1, 2)
			;EndIf
			If _Sleep($iDelayalgorithm_AllTroops5) Then Return
		Next
	Next

	;Activate KQ's power
	If ($checkKPower Or $checkQPower) And $iActivateKQCondition = "Manual" Then
		SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating Hero abilities", $COLOR_BLUE)
		_Sleep($delayActivateKQ)
		If $checkKPower Then
			SetLog("Activating King's power", $COLOR_BLUE)
			SelectDropTroop($King)
			$checkKPower = False
		EndIf
		If $checkQPower Then
			SetLog("Activating Queen's power", $COLOR_BLUE)
			SelectDropTroop($Queen)
			$checkQPower = False
		EndIf
	EndIf

	SetLog("Finished Attacking, waiting for the battle to end")
EndFunc   ;==>algorithm_AllTroops

