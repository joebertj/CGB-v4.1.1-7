; #FUNCTION# ====================================================================================================================
; Name ..........: Train
; Description ...: Train the troops (Fill the barracks), Uses the location of manually set Barracks to train specified troops
; Syntax ........: Train()
; Parameters ....:
; Return values .: None
; Author ........: Hungle
; Modified ......: ProMac (June 2015), Sardo (June/July 2015), KnowJack(July 2105), barracoda (July/Aug 2015), Sardo 2015-08
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func Train()

	Local $anotherTroops, $trainCount, $trainKind, $hasTrained
	Local $eBarbTrainRem=0, $eArchTrainRem=0, $eGiantTrainRem=0, $eGoblTrainRem=0, $eWallTrainRem=0, $eBallTrainRem=0, $eWizaTrainRem=0, $eHealTrainRem=0, $eDragTrainRem=0, $ePekkTrainRem=0, $eMiniTrainRem=0, $eHogsTrainRem=0, $eValkTrainRem=0, $eGoleTrainRem=0, $eWitcTrainRem=0, $eLavaTrainRem=0
	Local $eBarbTrainRemOnce=False, $eArchTrainRemOnce=False, $eGiantTrainRemOnce=False, $eGoblTrainRemOnce=False, $eWallTrainRemOnce=False, $eBallTrainRemOnce=False, $eWizaTrainRemOnce=False, $eHealTrainRemOnce=False, $eDragTrainRemOnce=False, $ePekkTrainRemOnce=False, $eMiniTrainRemOnce=False, $eHogsTrainRemOnce=False, $eValkTrainRemOnce=False, $eGoleTrainRemOnce=False, $eWitcTrainRemOnce=False, $eLavaTrainRemOnce=False

	If $debugSetlog = 1 Then SetLog("Func Train ", $COLOR_PURPLE)
	If $bTrainEnabled = False Then Return

	If $debugSetlog = 1 Then SetLog("Halt enabled, $TotalTrainedTroops= " & $TotalTrainedTroops & ", Adj TotalCamp= " & $TotalCamp - 8, $COLOR_PURPLE)
	If ($CommandStop = 0) And ($TotalTrainedTroops <> 0) And ($TotalTrainedTroops >= ($TotalCamp - 8)) Then
		CheckOverviewFullArmy(True)
		If $fullarmy = True Then
			If $debugSetlog = 1 Then SetLog("FullArmy & TotalTrained = skip training", $COLOR_PURPLE)
			Return
		EndIf
	EndIf

	; ###########################################  1st Stage : Prepare training & Variables & Values ##############################################

	If $FirstStart And $OptTrophyMode = 1 And $icmbTroopComp <> 8 Then
		$ArmyComp = $CurCamp
	EndIf

	; Is necessary Check Total Army Camp and existent troops inside of ArmyCamp
	; $icmbTroopComp - variable used to differentiate the Troops Composition selected in GUI
	; Inside of checkArmyCamp exists:
	; $CurCamp - quantity of troops existing in ArmyCamp  / $TotalCamp - your total troops capacity
	; BarracksStatus() - Verifying how many barracks / spells factory exists and if are available to use.
	; $numBarracksAvaiables returns to be used as the divisor to assign the amount of kind troops each barracks | $TroopName+EBarrack
	;

	;If $icmbTroopComp <> 9  Or $ichkUsePercent = 0 Then
		checkArmyCamp()
	;EndIf

	SetLog("Training Troops...", $COLOR_BLUE)
	If _Sleep($iDelayTrain1) Then Return
	ClickP($aAway, 1, 0, "#0268") ;Click Away

	;OPEN ARMY OVERVIEW WITH NEW BUTTON
	If _Sleep($iDelayTrain1) Then Return
	Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293") ; Button Army Overview

	;EXAMINE STATUS
	;BarracksStatus(false)

	; exit if I'm not in train page
	If Not (IsTrainPage()) Then Return

	;check Full army
	If Not $fullarmy Then CheckFullArmy() ;if armycamp not full, check full by barrack
	_CaptureRegion()
	Local $NextPos = _PixelSearch(749, 311, 787, 322, Hex(0xF08C40, 6), 5)
	Local $PrevPos = _PixelSearch(70, 311, 110, 322, Hex(0xF08C40, 6), 5)

	;GO TO LAST NORMAL BARRACK
	; find last barrack $i
	Local $lastbarrack = 0, $i = 4
	While $lastbarrack = 0 And $i > 1
		If $Trainavailable[$i] = 1 Then $lastbarrack = $i
		$i -= 1
	WEnd


	If $lastbarrack = 0 Then
		Setlog("No barrack avaiable, cannot start train")
		Return ;exit from train
	Else
		If $debugSetlog = 1 Then Setlog("LAST BARRACK = " & $lastbarrack, $COLOR_PURPLE)
		;GO TO LAST BARRACK
		Local $j = 0
		While Not _ColorCheck(_GetPixelColor($btnpos[0][0], $btnpos[0][1], True), Hex(0xE8E8E0, 6), 20)
			If $debugSetlog = 1 Then Setlog("OverView TabColor=" & _GetPixelColor($btnpos[0][0], $btnpos[0][1], True), $COLOR_PURPLE)
			If _Sleep($iDelayTrain1) Then Return ; wait for Train Window to be ready.
			$j += 1
			If $j > 15 Then ExitLoop
		WEnd
		If $j > 15 Then
			SetLog("Training Overview Window didn't open", $COLOR_RED)
			Return
		EndIf
		If Not (IsTrainPage()) Then Return ;exit if no train page
		Click($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], 1, $iDelayTrain5, "#0336") ; Click on tab and go to last barrack
		Local $j = 0
		While Not _ColorCheck(_GetPixelColor($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], True), Hex(0xE8E8E0, 6), 20)
			If $debugSetlog = 1 Then Setlog("Last Barrack TabColor=" & _GetPixelColor($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], True), $COLOR_PURPLE)
			If _Sleep($iDelayTrain1) Then Return
			$j += 1
			If $j > 15 Then ExitLoop
		WEnd
		If $j > 15 Then
			SetLog("some error occurred, cannot open barrack", $COLOR_RED)
		EndIf
	EndIf

	; PREPARE TROOPS IF FULL ARMY
	; Baracks status to false , after the first loop and train Selected Troops composition = True
	;
	If $fullarmy Then
		$BarrackStatus[0] = False
		$BarrackStatus[1] = False
		$BarrackStatus[2] = False
		$BarrackStatus[3] = False
		$BarrackDarkStatus[0] = False
		$BarrackDarkStatus[1] = False
		SetLog("Your Army Camps are now Full", $COLOR_RED)
		If $pEnabled = 1 And $ichkAlertPBCampFull = 1 Then PushMsg("CampFull")
	Else
	EndIf

	; ########################################  2nd Stage : Training & Calculating of Troop to Make ##############################################

	If $debugSetlog = 1 Then SetLog("Total ArmyCamp :" & $TotalCamp)

	$brrNum = 0
	If $icmbTroopComp = 8 Then
		If $debugSetlog = 1 Then
			Setlog("", $COLOR_PURPLE)
			SetLog("---------TRAIN BARRACK MODE------------------------", $COLOR_PURPLE)
		EndIf

		;USE BARRACK
		While isBarrack()
			_CaptureRegion()
			If $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					If Not (IsTrainPage()) Then Return
					Click(496, 197, 10, 0, "#0273")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			$brrNum += 1
			If Not (IsTrainPage()) Then Return ; exit from train if no train page
			Switch $barrackTroop[$brrNum - 1]
				Case 0
					TrainClick(220, 320, 75, 10, $FullBarb, $GemBarb, "#0274") ;Barbarian
				Case 1
					TrainClick(331, 320, 75, 10, $FullArch, $GemArch, "#0275") ;Archer
				Case 2
					TrainClick(432, 320, 15, 10, $FullGiant, $GemGiant, "#0276") ;Giant
				Case 3
					TrainClick(546, 320, 75, 10, $FullGobl, $GemGobl, "#0277") ;Goblin
				Case 4
					TrainClick(647, 320, 37, 10, $FullWall, $GemWall, "#0278") ;Wall Breaker
				Case 5
					TrainClick(220, 425, 15, 10, $FullBall, $GemBall, "#0279") ;Balloon
				Case 6
					TrainClick(331, 425, 18, 10, $FullWiza, $GemWiza, "#0280") ;Wizard
				Case 7
					TrainClick(432, 425, 5, 10, $FullHeal, $GemHeal, "#0281") ;Healer
				Case 8
					TrainClick(546, 425, 3, 10, $FullDrag, $GemDrag, "#0282") ;;Dragon
				Case 9
					TrainClick(647, 425, 3, 10, $FullPekk, $GemPekk, "#0283") ; Pekka
			EndSwitch
			If $OutOfElixir = 1 Then
				Setlog("Not enough Elixir to train troops!", $COLOR_RED)
				Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 16 ; set stay online
				If CheckFullArmy() = False Then $Restart = True ;If the army camp is full, use it to refill storages
				Return ; We are out of Elixir stop training.
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			If _Sleep($iDelayTrain3) Then ExitLoop
			;endif
		WEnd
		$brrNum = 0
		;USE DARK BARRACK
		While Not isDarkBarrack()
			_TrainMoveBtn(-1)
			If _Sleep($iDelayTrain2) Then Return
		WEnd
		While isDarkBarrack()
			_CaptureRegion()
			If $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					If Not (IsTrainPage()) Then Return
					Click(496, 197, 10, 0, "#0284")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			$brrNum += 1
			If Not (IsTrainPage()) Then Return ; exit from train if no train page
			Switch $darkbarrackTroop[$brrNum - 1]
				Case 0
					TrainClick(220, 320, 75, 10, $FullMini, $GemMini, "#0284") ;Minion
				Case 1
					TrainClick(331, 320, 75, 10, $FullHogs, $GemHogs, "#0285") ;Hog Rider
				Case 2
					TrainClick(432, 320, 15, 10, $FullValk, $GemValk, "#0286") ;Valkyrie
				Case 3
					TrainClick(546, 320, 75, 10, $FullGole, $GemGole, "#0287") ;Golem
				Case 4
					TrainClick(647, 320, 37, 10, $FullWitc, $GemWitc, "#0288") ;Witch
				Case 5
					TrainClick(220, 425, 15, 10, $FullLava, $GemLava, "#0289") ;Lava Hound
					;Case 6
					;ContinueLoop
			EndSwitch
			If $OutOfDarkElixir = 1 Then
				Setlog("Not enough Dark Elixir to train troops!", $COLOR_RED)
				Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 16 ; set stay online
				If CheckFullArmy() = False Then $Restart = True ;If the army camp is full, use it to refill storages
				Return ; We are out of Elixir stop training.
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If $brrNum >= 2 Then ExitLoop ; make sure no more infiniti loop
			If _Sleep($iDelayTrain3) Then ExitLoop
			;endif
		WEnd
	ElseIf $icmbTroopComp <> 8 Then
		If $debugSetlog = 1 Then
			Setlog("", $COLOR_PURPLE)
			SetLog("---------TRAIN CUSTOM ARMY MODE------------------------", $COLOR_PURPLE)
		EndIf
		;SetLog("$fullarmy: " & $fullarmy)
		;SetLog("$eDragTrain: " & $eDragTrain)
		If $fullarmy Then ; double temporarily to train
			If $trainFiller = True Then
				$BarbComp = GUICtrlRead($txtNumBarb)
				$ArchComp = GUICtrlRead($txtNumArch) ; restore ArchComp
				$GoblComp = GUICtrlRead($txtNumGobl)
				$MiniComp = GUICtrlRead($txtNumMini) ; restore MiniComp
				$trainFiller = False
				If $ichkUsePercent = 1 Then
					$BarbComp = Round($BarbComp * $TotalCamp / 100)
					$ArchComp = Round($ArchComp * $TotalCamp / 100)
					$GoblComp = Round($GoblComp * $TotalCamp / 100)
					$MiniComp = Round($MiniComp * $TotalCamp / 100)
				EndIf
			EndIf
			If $debugSetlog = 1 Then SetLog("fullarmy $ArchComp: " & $ArchComp & " $eBallComp" & $BallComp & " $eMiniComp: " & $MiniComp)
			$BarbComp = $BarbComp * 3 - $eBarbCount
			$ArchComp = $ArchComp * 3 - $eArchCount
			$GoblComp = $GoblComp * 3 - $eGoblCount
			$GiantComp = $GiantComp * 3 - $eGiantCount
			$WallComp = $WallComp * 3 - $eWallCount
			$WizaComp = $WizaComp * 3 - $eWizaCount
			$MiniComp = $MiniComp * 3 - $eMiniCount
			$HogsComp = $HogsComp * 3 - $eHogsCount
			$DragComp = $DragComp * 3 - $eDragCount
			$BallComp = $BallComp * 3 - $eBallCount
			$PekkComp = $PekkComp * 3 - $ePekkCount
			$HealComp = $HealComp * 3 - $eHealCount
			$ValkComp = $ValkComp * 3 - $eValkCount
			$GoleComp = $GoleComp * 3 - $eGoleCount
			$WitcComp = $WitcComp * 3 - $eWitcCount
			$LavaComp = $LavaComp * 3 - $eLavaCount
		EndIf
		$notTraining = 0 ; reset before training
		$notTrainingDark = 0
		While isBarrack()
			_CaptureRegion()
			If ($iSpeed = 0 And $FirstStart) Or $RemoveTroops Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					If Not (IsTrainPage()) Then Return
					Click(496, 197, 10, 0, "#0273")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			$brrNum += 1
			If Not (IsTrainPage()) Then Return ; exit from train if no train page
			If $numBarracksAvaiables = 0 Then
				SetLog("Will not ever be able to train since no barracks are available")
				ExitLoop
			EndIf
			$trainKind = 0
			$hasTrained = False
			; train units by training time, longer to train first then by size
			If $ePekkCount + $ePekkTrainOld < $PekkComp Then
				$trainCount = Floor(($PekkComp - $ePekkCount - $ePekkTrainOld) / $numBarracksAvaiables)
				If Not $ePekkTrainRemOnce Then
					$ePekkTrainRemOnce = True
					$ePekkTrainRem = Mod($PekkComp - $ePekkCount - $ePekkTrainOld, $numBarracksAvaiables)
				EndIf
				If $ePekkTrainRem > 0 Then
					$ePekkTrainRem -= 1
				Else
					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					; if troop creation will create a deadlock, skip train
					If Not $fullarmy And getHouseSpace($ePekk) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(647, 425, 1, 50, $FullPekk, $GemPekk, "#0283") Then ; Pekka
						$ePekkTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1 ;max 9 on queue
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eDragCount + $eDragTrainOld < $DragComp Then
				$trainCount = Floor(($DragComp - $eDragCount - $eDragTrainOld) / $numBarracksAvaiables)
				If Not $eDragTrainRemOnce Then
					$eDragTrainRemOnce = True
					$eDragTrainRem = Mod($DragComp - $eDragCount - $eDragTrainOld, $numBarracksAvaiables)
				EndIf
				If $eDragTrainRem > 0 Then
					$eDragTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eDrag) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(546, 425, 1, 50, $FullDrag, $GemDrag, "#0282") Then ;;Dragon
						$eDragTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eHealCount + $eHealTrainOld < $HealComp Then
				$trainCount = Floor(($HealComp - $eHealCount - $eHealTrainOld) / $numBarracksAvaiables)
				If Not $eHealTrainRemOnce Then
					$eHealTrainRemOnce = True
					$eHealTrainRem = Mod($HealComp - $eHealCount - $eHealTrainOld, $numBarracksAvaiables)
				EndIf
				If $eHealTrainRem > 0 Then
					$eHealTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eHeal) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(432, 425, 1, 50, $FullHeal, $GemHeal, "#0281") Then ;Healer
						$eHealTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eBallCount + $eBallTrainOld < $BallComp Then
				$trainCount = Floor(($BallComp - $eBallCount - $eBallTrainOld) / $numBarracksAvaiables)
				If Not $eBallTrainRemOnce Then
					$eBallTrainRemOnce = True
					$eBallTrainRem = Mod($BallComp - $eBallCount - $eBallTrainOld, $numBarracksAvaiables)
				EndIf
				If $eBallTrainRem > 0 Then
					$eBallTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eBall) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(220, 425, 1, 50, $FullBall, $GemBall, "#0279") Then ;Balloon
						$eBallTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eWizaCount + $eWizaTrainOld < $WizaComp Then
				$trainCount = Floor(($WizaComp - $eWizaCount - $eWizaTrainOld) / $numBarracksAvaiables)
				If Not $eWizaTrainRemOnce Then
					$eWizaTrainRemOnce = True
					$eWizaTrainRem = Mod($WizaComp - $eWizaCount - $eWizaTrainOld, $numBarracksAvaiables)
				EndIf
				If $eWizaTrainRem > 0 Then
					$eWizaTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eWiza) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(331, 425, 1, 50, $FullWiza, $GemWiza, "#0280") Then ;Wizard
						$eWizaTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eGiantCount + $eGiantTrainOld < $GiantComp Then
				$trainCount = Floor(($GiantComp - $eGiantCount - $eGiantTrainOld) / $numBarracksAvaiables)
				If Not $eGiantTrainRemOnce Then
					$eGiantTrainRemOnce = True
					$eGiantTrainRem = Mod($GiantComp - $eGiantCount - $eGiantTrainOld, $numBarracksAvaiables)
				EndIf
				If $eGiantTrainRem > 0 Then
					$eGiantTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eGiant) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(432, 320, 1, 50, $FullGiant, $GemGiant, "#0276") Then ;Giant
						$eGiantTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eWallCount + $eWallTrainOld < $WallComp Then
				$trainCount = Floor(($WallComp - $eWallCount - $eWallTrainOld) / $numBarracksAvaiables)
				If Not $eWallTrainRemOnce Then
					$eWallTrainRemOnce = True
					$eWallTrainRem = Mod($WallComp - $eWallCount - $eWallTrainOld, $numBarracksAvaiables)
				EndIf
				If $eWallTrainRem > 0 Then
					$eWallTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eWall) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(647, 320, 1, 50, $FullWall, $GemWall, "#0278") Then ;Wall Breaker
						$eWallTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			;SetLog("$eArchCount: " & $eArchCount & " $eArchTrain: " & $eArchTrain & " $eArchTrainOld: " & $eArchTrainOld & " Comp: " & $ArchComp)
			If $eArchCount + $eArchTrainOld < $ArchComp Then
				$trainCount = Floor(($ArchComp - $eArchCount - $eArchTrainOld) / $numBarracksAvaiables)
				If Not $eArchTrainRemOnce Then
					$eArchTrainRemOnce = True
					$eArchTrainRem = Mod($ArchComp - $eArchCount - $eArchTrainOld, $numBarracksAvaiables)
				;SetLog("$eArchTrainRem: " & $eArchTrainRem & " $trainCount: " & $trainCount)
				EndIf
				If $eArchTrainRem > 0 Then
					$eArchTrainRem -= 1

					$trainCount += 1
				EndIf
				;SetLog("$eArchTrainRem: " & $eArchTrainRem & " $trainCount: " & $trainCount)
				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eArch) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(331, 320, 1, 50, $FullArch, $GemArch, "#0275") Then ;Archer
						$eArchTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			;SetLog("$eBarbCount: " & $eBarbCount & " $eBarbTrain: " & $eBarbTrain & " $eBarbTrainOld: " & $eBarbTrainOld & " Comp: " & $BarbComp)
			If $eBarbCount + $eBarbTrainOld < $BarbComp Then
				$trainCount = Floor(($BarbComp - $eBarbCount - $eBarbTrainOld) / $numBarracksAvaiables)
				If Not $eBarbTrainRemOnce Then
					$eBarbTrainRemOnce = True
					$eBarbTrainRem = Mod($BarbComp - $eBarbCount - $eBarbTrainOld, $numBarracksAvaiables)
				;SetLog("$eBarbTrainRem: " & $eBarbTrainRem & " $trainCount: " & $trainCount)
				EndIf
				If $eBarbTrainRem > 0 Then
					$eBarbTrainRem -= 1

					$trainCount += 1
				EndIf
				;SetLog("$eBarbTrainRem: " & $eBarbTrainRem & " $trainCount: " & $trainCount)
				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eBarb) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(220, 320, 1, 50, $FullBarb, $GemBarb, "#0274") Then ;Barbarian
						$eBarbTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If $trainKind < 9 Then ;only up to 9 troops can be queued
				If _Sleep($iDelayTrain6) Then Return
				If $eGoblCount + $eGoblTrainOld < $GoblComp Then
					$trainCount = Floor(($GoblComp - $eGoblCount - $eGoblTrainOld) / $numBarracksAvaiables)
					If Not $eGoblTrainRemOnce Then
					$eGoblTrainRemOnce = True
					$eGoblTrainRem = Mod($GoblComp - $eGoblCount - $eGoblTrainOld, $numBarracksAvaiables)
					EndIf
				If $eGoblTrainRem > 0 Then
						$eGoblTrainRem -= 1

						$trainCount += 1
					EndIf
					For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eGobl) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
						If TrainClick(546, 320, 1, 50, $FullGobl, $GemGobl, "#0277") Then ;Goblin
							$eGoblTrain += 1
						Else
							ExitLoop
						EndIf
					Next
				EndIf
			EndIf
			If _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) Then $notTraining += 1
			If $OutOfElixir = 1 Then
				Setlog("Not enough Elixir to train troops!", $COLOR_RED)
				Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 16 ; set stay online
				If CheckFullArmy() = False Then $Restart = True ;If the army camp is full, use it to refill storages
				Return ; We are out of Elixir stop training.
			EndIf
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If _Sleep($iDelayTrain2) Then ExitLoop
			If $brrNum >= $numBarracksAvaiables Then ExitLoop
		WEnd
		;SetLog("$notTraining: " & $notTraining & " $trainKind: " & $trainKind)
		$eBarbTrainOld=$eBarbTrain
		$eArchTrainOld=$eArchTrain
		$eGiantTrainOld=$eGiantTrain
		$eGoblTrainOld=$eGoblTrain
		$eWallTrainOld=$eWallTrain
		$eBallTrainOld=$eBallTrain
		$eWizaTrainOld=$eWizaTrain
		$eHealTrainOld=$eHealTrain
		$eDragTrainOld=$eDragTrain
		$ePekkTrainOld=$ePekkTrain
		$hasTrained = False
		$brrNum = 0
		;USE DARK BARRACK
		While Not isDarkBarrack()
			_TrainMoveBtn(-1)
			If _Sleep($iDelayTrain2) Then Return
			If $brrNum > 9 Then ExitLoop ; anti infinite loop
			$brrNum += 1
		WEnd
		$brrNum = 0
		While isDarkBarrack()
			_CaptureRegion()
			If ($iSpeed =0 And $FirstStart) Or $RemoveTroops Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					If Not (IsTrainPage()) Then Return
					Click(496, 197, 10, 0, "#0284")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep($iDelayTrain2) Then ExitLoop
			$brrNum += 1
			If Not (IsTrainPage()) Then Return ; exit from train if no train page
			If $numDarkBarracksAvaiables = 0 Then
				SetLog("Will not ever be able to train since no dark barracks are available")
				ExitLoop
			EndIf
			; train units by training time, longer to train first then by size, finally cost
			If $eGoleCount + $eGoleTrainOld < $GoleComp Then
				$trainCount = Floor(($GoleComp - $eGoleCount - $eGoleTrainOld) / $numDarkBarracksAvaiables)
				If Not $eGoleTrainRemOnce Then
					$eGoleTrainRemOnce = True
					$eGoleTrainRem = Mod($GoleComp - $eGoleCount - $eGoleTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eGoleTrainRem > 0 Then
					$eGoleTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eGole) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(546, 320, 1, 50, $FullGole, $GemGole, "#0287") Then ;Golem
						$eGoleTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eLavaCount + $eLavaTrainOld < $LavaComp Then
				$trainCount = Floor(($LavaComp - $eLavaCount - $eLavaTrainOld) / $numDarkBarracksAvaiables)
				If Not $eLavaTrainRemOnce Then
					$eLavaTrainRemOnce = True
					$eLavaTrainRem = Mod($LavaComp - $eLavaCount - $eLavaTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eLavaTrainRem > 0 Then
					$eLavaTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eLava) > $TotalCamp-$CurCamp Then
						$trainFiller=True
						ExitLoop
					EndIf
					If TrainClick(220, 425, 1, 50, $FullLava, $GemLava, "#0289") Then ;Lava Hound
						$eLavaTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eWitcCount + $eWitcTrainOld < $WitcComp Then
				$trainCount = Floor(($WitcComp - $eWitcCount - $eWitcTrainOld) / $numDarkBarracksAvaiables)
				If Not $eWitcTrainRemOnce Then
					$eWitcTrainRemOnce = True
					$eWitcTrainRem = Mod($WitcComp - $eWitcCount - $eWitcTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eWitcTrainRem > 0 Then
					$eWitcTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eWitc) > $TotalCamp-$CurCamp Then
						$trainFillerDark=True
						ExitLoop
					EndIf
					If TrainClick(647, 320, 1, 50, $FullWitc, $GemWitc, "#0288") Then ;Witch
						$eWitcTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eValkCount + $eValkTrainOld < $ValkComp Then
				$trainCount = Floor(($ValkComp - $eValkCount - $eValkTrainOld) / $numDarkBarracksAvaiables)
				If Not $eValkTrainRemOnce Then
					$eValkTrainRemOnce = True
					$eValkTrainRem = Mod($ValkComp - $eValkCount - $eValkTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eValkTrainRem > 0 Then
					$eValkTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eValk) > $TotalCamp-$CurCamp Then
						$trainFillerDark=True
						ExitLoop
					EndIf
					If TrainClick(432, 320, 1, 50, $FullValk, $GemValk, "#0286") Then ;Valkyrie
						$eValkTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eHogsCount + $eHogsTrainOld < $HogsComp Then
				$trainCount = Floor(($HogsComp - $eHogsCount - $eHogsTrainOld) / $numDarkBarracksAvaiables)
				If Not $eHogsTrainRemOnce Then
					$eHogsTrainRemOnce = True
					$eHogsTrainRem = Mod($HogsComp - $eHogsCount - $eHogsTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eHogsTrainRem > 0 Then
					$eHogsTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eHogs) > $TotalCamp-$CurCamp Then
						$trainFillerDark=True
						ExitLoop
					EndIf
					If TrainClick(331, 320, 1, 50, $FullHogs, $GemHogs, "#0285") Then ;Hog Rider
						$eHogsTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _Sleep($iDelayTrain6) Then Return
			If $eMiniCount + $eMiniTrainOld < $MiniComp Then
				;SetLog("$eMiniCount: " & $eMiniCount & " $eMiniTrain: " & $eMiniTrain & " $eMiniTrainOld: " & $eMiniTrainOld & " $MiniComp: " & $MiniComp)
				$trainCount = Floor(($MiniComp - $eMiniCount - $eMiniTrainOld) / $numDarkBarracksAvaiables)
				If Not $eMiniTrainRemOnce Then
					$eMiniTrainRemOnce = True
					$eMiniTrainRem = Mod($MiniComp - $eMiniCount - $eMiniTrainOld, $numDarkBarracksAvaiables)
				EndIf
				If $eMiniTrainRem > 0 Then
					$eMiniTrainRem -= 1

					$trainCount += 1
				EndIf

				For $i = 1 to $trainCount
					If Not $fullarmy And getHouseSpace($eMini) > $TotalCamp-$CurCamp Then
						$trainFillerDark=True
						ExitLoop
					EndIf
					;SetLog("$i: " & $i & " $numDarkBarracksAvaiables: " & $numDarkBarracksAvaiables & " $trainCount: " & $trainCount)
					If TrainClick(220, 320, 1, 50, $FullMini, $GemMini, "#0284") Then ;Minion
						$eMiniTrain += 1
						$hasTrained = True
					Else
						ExitLoop
					EndIf
				Next
				If $hasTrained Then
					$hasTrained = False
					$trainKind += 1
				EndIf
			EndIf
			If _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) Then $notTrainingDark += 1
			If $OutOfDarkElixir = 1 Then
				Setlog("Not enough Dark Elixir to train troops!", $COLOR_RED)
				Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 16 ; set stay online
				If CheckFullArmy() = False Then $Restart = True ;If the army camp is full, use it to refill storages
				Return ; We are out of Elixir stop training.
			EndIf
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If _Sleep($iDelayTrain2) Then ExitLoop
			If $brrNum >= $numDarkBarracksAvaiables Then ExitLoop
		WEnd
		If $RemoveTroops Then $RemoveTroops = False
		$eMiniTrainOld=$eMiniTrain
		$eHogsTrainOld=$eHogsTrain
		$eValkTrainOld=$eValkTrain
		$eGoleTrainOld=$eGoleTrain
		$eWitcTrainOld=$eWitcTrain
		$eLavaTrainOld=$eLavaTrain
		If $debugSetlog = 1 Then SetLog("$fullarmy: " & $fullarmy & " $trainFiller: " & $trainFiller)
		If $trainFiller = True Then
			If $BarbComp > 0 Then
				$BarbComp += ($TotalCamp - $CurCamp)
			ElseIf $GoblComp > 0 Then
				$GoblComp += ($TotalCamp - $CurCamp)
			Else
				$ArchComp += ($TotalCamp - $CurCamp)
			EndIf
		EndIf
		If $trainFillerDark = True Then
			$MiniComp += ($TotalCamp - $CurCamp)
		EndIf
		If $debugSetlog = 1 Then SetLog("$notTrainingDark: " & $notTrainingDark & " $trainKind: " & $trainKind)
		If $fullarmy Then ; restore original values
			$BarbComp =  GUICtrlRead($txtNumBarb)
			$ArchComp =  GUICtrlRead($txtNumArch)
			$GoblComp =  GUICtrlRead($txtNumGobl)
			$GiantComp =  GUICtrlRead($txtNumGiant)
			$WallComp =  GUICtrlRead($txtNumWall)
			$WizaComp =  GUICtrlRead($txtNumWiza)
			$MiniComp =  GUICtrlRead($txtNumMini)
			$HogsComp =  GUICtrlRead($txtNumHogs)
			$DragComp =  GUICtrlRead($txtNumDrag)
			$BallComp =  GUICtrlRead($txtNumBall)
			$PekkComp =  GUICtrlRead($txtNumPekk)
			$HealComp =  GUICtrlRead($txtNumHeal)
			$ValkComp =  GUICtrlRead($txtNumValk)
			$GoleComp =  GUICtrlRead($txtNumGole)
			$WitcComp =  GUICtrlRead($txtNumWitc)
			$LavaComp =  GUICtrlRead($txtNumLava)
			If $ichkUsePercent = 1 Then
				PercentComp()
			EndIf
		EndIf
	Else
		If $debugSetlog = 1 Then SetLog("---------TRAIN NEW BARRACK MODE------------------------")

		While isBarrack() And $isNormalBuild
			$brrNum += 1
			If $fullarmy Or $FirstStart Then
				;CLICK REMOVE TROOPS
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					If Not (IsTrainPage()) Then Return ;exit if no train page
					Click(496, 197, 10, 0, "#0284") ; remove troops
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 7", $COLOR_PURPLE)
			EndIf
			If _Sleep($iDelayTrain1) Then ExitLoop
			For $i = 0 To UBound($TroopName) - 1
				If Eval($TroopName[$i] & "Comp") <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopFirst" & $TroopName[$i]) = 0 Then
						If _Sleep($iDelayTrain1) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			;Too few troops, train first
			For $i = 0 To UBound($TroopName) - 1
				If Eval("tooFew" & $TroopName[$i]) = 1 Then
					TrainIt(Eval("e" & $TroopName[$i]), Eval($TroopName[$i] & "Comp") / $numBarracksAvaiables)
					$BarrackStatus[$brrNum - 1] = True
				EndIf
			Next
			;Balanced troops train in normal order
			For $i = 0 To UBound($TroopName) - 1
				If Eval($TroopName[$i] & "Comp") <> "0" And Eval("Cur" & $TroopName[$i]) > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopName[$i]) > 0 Then
						If Not (IsTrainPage()) Then Return ;exit from train
						If Eval($TroopName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), 1)
							$BarrackStatus[$brrNum - 1] = True
						ElseIf Eval($TroopName[$i] & "EBarrack") >= Eval("Cur" & $TroopName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]))
							$BarrackStatus[$brrNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), Eval($TroopName[$i] & "EBarrack"))
							$BarrackStatus[$brrNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopName) - 1 ; put troops at end of queue if there are too many
				If Eval("tooMany" & $TroopName[$i]) = 1 Then
					If Not (IsTrainPage()) Then Return ;exit from train
					TrainIt(Eval("e" & $TroopName[$i]), Eval($TroopName[$i] & "Comp") / $numBarracksAvaiables)
					$BarrackStatus[$brrNum - 1] = True
				EndIf
			Next
			If _Sleep($iDelayTrain1) Then ExitLoop
			For $i = 0 To UBound($TroopName) - 1
				If Eval($TroopName[$i] & "Comp") <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog(("troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop))), $COLOR_PURPLE)
					Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopName[$i]) = 0 Then
						If _Sleep($iDelayTrain1) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			$troopNameCooking = ""
			For $i = 0 To UBound($TroopName) - 1
				If Eval("troopSecond" & $TroopName[$i]) > Eval("troopFirst" & $TroopName[$i]) And Eval($TroopName[$i] & "Comp") <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])) * $TroopHeight[$i]
					If $debugSetlog = 1 Then SetLog(("###Cur" & $TroopName[$i]) & " = " & Eval("Cur" & $TroopName[$i]) & " - (" & Eval("troopSecond" & $TroopName[$i]) & " - " & Eval("troopFirst" & $TroopName[$i]) & ")", $COLOR_PURPLE)
					Assign(("Cur" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]) - (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])))
				EndIf
				If Eval("troopSecond" & $TroopName[$i]) > 0 Then
					$troopNameCooking = $troopNameCooking & $i & ";"
				EndIf
			Next

			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xD2D0C3, 6), 5) Or $troopNameCooking = "" Then
				$BarrackStatus[$brrNum - 1] = False
			Else
				$BarrackStatus[$brrNum - 1] = True
			EndIf
			If $debugSetlog = 1 Then SetLog("BARRACK " & $brrNum - 1 & " STATUS: " & $BarrackStatus[$brrNum - 1], $COLOR_PURPLE)

			If $BarrackStatus[0] = False And $BarrackStatus[1] = False And $BarrackStatus[2] = False And $BarrackStatus[3] = False And Not $FirstStart Then
				If Not $isDarkBuild Or ($BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False) Then
					If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Arch", $COLOR_PURPLE)
					If Not (IsTrainPage()) Then Return ;exit from train
					TrainIt($eArch, 20)
				EndIf
			EndIf
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If _Sleep($iDelayTrain2) Then ExitLoop
			If $brrNum >= $numBarracksAvaiables Then ExitLoop ; make sure no more infiniti loop
		WEnd


	;dark here
	If $isDarkBuild Then
		$iBarrHere = 0
		$brrDarkNum = 0
		While 1
			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			$iBarrHere += 1
			If _Sleep($iDelayTrain3) Then ExitLoop
			If (isDarkBarrack() Or $iBarrHere = 5) Then ExitLoop
		WEnd
		While isDarkBarrack()
			$brrDarkNum += 1
			If $debugSetlog = 1 Then SetLog("====== Check Dark Barrack: " & $brrDarkNum & " ======", $COLOR_PURPLE)
			If StringInStr($sBotDll, "CGBPlugin.dll") < 1 Then
				ExitLoop
			EndIf
			If $fullarmy Or $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0287")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 9", $COLOR_PURPLE)
			EndIf
			If _Sleep($iDelayTrain1) Then ExitLoop
			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval($TroopDarkName[$i] & "Comp") <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf

					;read troops in windows troopsfirst
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst.." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopFirst" & $TroopDarkName[$i]) = 0 Then
						If _Sleep($iDelayTrain1) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst..." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			;Too few troops, train first
			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval("tooFew" & $TroopDarkName[$i]) = 1 Then
					TrainIt(Eval("e" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
					$BarrackDarkStatus[$brrDarkNum - 1] = True
				EndIf
			Next
			;Balanced troops, train in normal order
			For $i = 0 To UBound($TroopDarkName) - 1
				If $debugSetlog = 1 Then SetLog("** " & $TroopDarkName[$i] & " : " & "txtNum" & $TroopDarkName[$i] & " = " & Eval($TroopDarkName[$i] & "Comp") & "  Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & "txtNum" & $TroopDarkName[$i] & "=" & Eval($TroopDarkName[$i] & "Comp"), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If Eval($TroopDarkName[$i] & "Comp") <> "0" And Eval("Cur" & $TroopDarkName[$i]) > 0 Then

					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopDarkName[$i]) > 0 Then
						If Not (IsTrainPage()) Then Return ;exit from train
						If Eval($TroopDarkName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), 1)
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						ElseIf Eval($TroopDarkName[$i] & "EBarrack") >= Eval("Cur" & $TroopDarkName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "EBarrack"))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopDarkName) - 1 ; put troops at end of queue if there are too man
				If Eval("tooMany" & $TroopDarkName[$i]) = 1 Then
					If Not (IsTrainPage()) Then Return ;exit from train
					TrainIt(Eval("e" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
					$BarrackDarkStatus[$brrDarkNum - 1] = True
				EndIf
			Next
			If _Sleep($iDelayTrain1) Then ExitLoop
			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval($TroopDarkName[$i] & "Comp") <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopDarkName[$i]) = 0 Then
						If _Sleep($iDelayTrain1) Then ExitLoop
						If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval("troopSecond" & $TroopDarkName[$i]) > Eval("troopFirst" & $TroopDarkName[$i]) And Eval($TroopDarkName[$i] & "Comp") <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
					If $debugSetlog = 1 Then SetLog("#Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]) & " - (" & Eval("troopSecond" & $TroopDarkName[$i]) & " - " & Eval("troopFirst" & $TroopDarkName[$i]) & ")", $COLOR_PURPLE)
					Assign(("Cur" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]) - (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])))
					If $debugSetlog = 1 Then SetLog("**** " & "txtNum" & $TroopDarkName[$i] & "=" & Eval($TroopDarkName[$i] & "Comp"), $COLOR_PURPLE)
					If $debugSetlog = 1 Then SetLog("**** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
					If $debugSetlog = 1 Then SetLog("**** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				EndIf
			Next
			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xD2D0C3, 6), 5) Then
				$BarrackDarkStatus[$brrDarkNum - 1] = False
			Else
				$BarrackDarkStatus[$brrDarkNum - 1] = True
			EndIf

			If Not (IsTrainPage()) Then Return
			_TrainMoveBtn(-1) ;click prev button
			If _Sleep($iDelayTrain2) Then ExitLoop
			$icount = 0
;~ 			While Not isDarkBarrack()
;~ 				If _Sleep($iDelayTrain4) Then ExitLoop
;~ 				$icount = $icount + 1
;~ 				If $icount = 5 Then ExitLoop
;~ 			WEnd
			If $brrDarkNum >= $numDarkBarracksAvaiables Then ExitLoop ; make sure no more infiniti loop
		WEnd
		;end dark
	EndIf
	EndIf
	If $debugSetlog = 1 Then SetLog("---=====================END TRAIN =======================================---", $COLOR_PURPLE)
	TrainSpells()

	If $iChkLightSpell = 1 Or $iChkDEUseSpell = 1 Then
		$iBarrHere = 0
		While Not (isSpellFactory())
			If Not (IsTrainPage()) Then Return
			If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
			$iBarrHere += 1
			If _Sleep($iDelayTrain3) Then ExitLoop
			If $iBarrHere = 7 Then ExitLoop
		WEnd
		If isSpellFactory() Then
			Local $x = 0
			Local $Spellslot = -1
			If $iChkLightSpell = 1 Then
				$Spellslot = 0
			ElseIf $iChkDEUseSpell = 1 Then
				$Spellslot = $iChkDEUseSpellType + 1
			EndIf
			If $Spellslot <> -1 Then
				While 1
					_CaptureRegion()
					If _sleep($iDelayTrain2) Then Return
					If _ColorCheck(_GetPixelColor(237, 354, True), Hex(0xFFFFFF, 6), 20) = False Then
						setlog("Not enough Elixir to create Spell", $COLOR_RED)
						ExitLoop
					ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x1A1A1A, 6), 20) Then
						setlog("Spell Factory Full", $COLOR_RED)
						ExitLoop
					Else
						GemClick(252 + ($Spellslot * 105), 354, 1, 20, "#0290")
						$x = $x + 1
					EndIf
					If $x = 5 Then
						ExitLoop
					EndIf
				WEnd
				If $x = 0 Then
				Else
					SetLog("Created " & $x & " Spell(s)", $COLOR_BLUE)
				EndIf
			EndIf
		Else
			SetLog("Spell Factory not found...", $COLOR_BLUE)
		EndIf
	EndIf ; End Spell Factory
	If _Sleep($iDelayTrain4) Then Return
	ClickP($aAway, 2, $iDelayTrain5, "#0291"); Click away twice with 250ms delay
	$FirstStart = False
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
	EndIf
EndFunc   ;==>Train

Func IsTrainPage()
	Local $i = 0
	While $i < 10
		If _ColorCheck(_GetPixelColor(780, 546, True), Hex(0x8E4385, 6), 20) Or _ColorCheck(_GetPixelColor(780, 546, True), Hex(0x0F1304, 6), 20) Then ExitLoop
		_Sleep($iDelayIsTrainPage1)
		$i += 1
	WEnd
	If $i < 10 Then
		;If $DebugSetlog = 1 Then Setlog("**TrainPage OK**", $COLOR_PURPLE)
		Return True
	Else
		SetLog("Cannot find train page, return home.", $COLOR_RED)
		Return False
	EndIf
EndFunc   ;==>IsTrainPage

Func getMinInTrain()
	Local $minInTrain = 60

	If $eBarbTrain > 0 Then
		If $minInTrain > 1 Then $minInTrain = 1
	EndIf
	If $eArchTrain > 0 Then
		If $minInTrain > 1 Then $minInTrain = 1
	EndIf
	If $eGiantTrain > 0 Then
		If $minInTrain > 2 Then $minInTrain = 2
	EndIf
	If $eGoblTrain > 0 Then
		If $minInTrain > 1 Then $minInTrain = 1
	EndIf
	If $eWallTrain > 0 Then
		If $minInTrain > 2 Then $minInTrain = 2
	EndIf
	If $eBallTrain > 0 Then
		If $minInTrain > 8 Then $minInTrain = 8
	EndIf
	If $eWizaTrain > 0 Then
		If $minInTrain > 8 Then $minInTrain = 8
	EndIf
	If $eHealTrain > 0 Then
		If $minInTrain > 15 Then $minInTrain = 15
	EndIf
	If $eDragTrain > 0 Then
		If $minInTrain > 30 Then $minInTrain = 30
	EndIf
	If $ePekkTrain > 0 Then
		If $minInTrain > 45 Then $minInTrain = 45
	EndIf
	If $eMiniTrain > 0 Then
		If $minInTrain > 1 Then $minInTrain = 1
	EndIf
	If $eHogsTrain > 0 Then
		If $minInTrain > 2 Then $minInTrain = 2
	EndIf
	If $eValkTrain > 0 Then
		If $minInTrain > 8 Then $minInTrain = 8
	EndIf
	If $eGoleTrain > 0 Then
		If $minInTrain > 45 Then $minInTrain = 45
	EndIf
	If $eWitcTrain > 0 Then
		If $minInTrain > 20 Then $minInTrain = 20
	EndIf
	If $eLavaTrain > 0 Then
		If $minInTrain > 45 Then $minInTrain = 45
	EndIf
	If $minInTrain = 60 Then $minInTrain = -1
	Return $minInTrain
EndFunc

Func getMaxInTrain()
	Local $maxInTrain = -1

	If $eBarbTrain > 0 Then
		If $maxInTrain < 1 Then $maxInTrain = 1
	EndIf
	If $eArchTrain > 0 Then
		If $maxInTrain < 1 Then $maxInTrain = 1
	EndIf
	If $eGiantTrain > 0 Then
		If $maxInTrain < 2 Then $maxInTrain = 2
	EndIf
	If $eGoblTrain > 0 Then
		If $maxInTrain < 1 Then $maxInTrain = 1
	EndIf
	If $eWallTrain > 0 Then
		If $maxInTrain < 2 Then $maxInTrain = 2
	EndIf
	If $eBallTrain > 0 Then
		If $maxInTrain < 8 Then $maxInTrain = 8
	EndIf
	If $eWizaTrain > 0 Then
		If $maxInTrain < 8 Then $maxInTrain = 8
	EndIf
	If $eHealTrain > 0 Then
		If $maxInTrain < 15 Then $maxInTrain = 15
	EndIf
	If $eDragTrain > 0 Then
		If $maxInTrain < 30 Then $maxInTrain = 30
	EndIf
	If $ePekkTrain > 0 Then
		If $maxInTrain < 45 Then $maxInTrain = 45
	EndIf
	If $eMiniTrain > 0 Then
		If $maxInTrain < 1 Then $maxInTrain = 1
	EndIf
	If $eHogsTrain > 0 Then
		If $maxInTrain < 2 Then $maxInTrain = 2
	EndIf
	If $eValkTrain > 0 Then
		If $maxInTrain < 8 Then $maxInTrain = 8
	EndIf
	If $eGoleTrain > 0 Then
		If $maxInTrain < 45 Then $maxInTrain = 45
	EndIf
	If $eWitcTrain > 0 Then
		If $maxInTrain < 20 Then $maxInTrain = 20
	EndIf
	If $eLavaTrain > 0 Then
		If $maxInTrain < 45 Then $maxInTrain = 45
	EndIf
	Return $maxInTrain
EndFunc

Func getHouseSpace($eTroop)
	Local $houseSpace = 0

	If $eTroop = $eBarb Then
		$houseSpace = 1

	ElseIf $eTroop = $eArch Then
		$houseSpace = 1

	ElseIf $eTroop = $eGiant Then
		$houseSpace = 5

	ElseIf $eTroop = $eGobl Then
		$houseSpace = 1

	ElseIf $eTroop = $eWall Then
		$houseSpace = 2

	ElseIf $eTroop = $eBall Then
		$houseSpace = 5

	ElseIf $eTroop = $eWiza Then
		$houseSpace = 4

	ElseIf $eTroop = $eHeal Then
		$houseSpace = 14

	ElseIf $eTroop = $eDrag Then
		$houseSpace = 20

	ElseIf $eTroop = $ePekk Then
		$houseSpace = 25

	ElseIf $eTroop = $eMini Then
		$houseSpace = 2

	ElseIf $eTroop = $eHogs Then
		$houseSpace = 5

	ElseIf $eTroop = $eValk Then
		$houseSpace = 8

	ElseIf $eTroop = $eGole Then
		$houseSpace = 30

	ElseIf $eTroop = $eWitc Then
		$houseSpace = 12

	ElseIf $eTroop = $eLava Then
		$houseSpace = 30
	EndIf
	Return $houseSpace
EndFunc

Func ResetCounters()
	; reset training counter
	$eBarbTrain=0
	$eArchTrain=0
	$eGiantTrain=0
	$eGoblTrain=0
	$eWallTrain=0
	$eBallTrain=0
	$eWizaTrain=0
	$eHealTrain=0
	$eDragTrain=0
	$ePekkTrain=0
	$eMiniTrain=0
	$eHogsTrain=0
	$eValkTrain=0
	$eGoleTrain=0
	$eWitcTrain=0
	$eLavaTrain=0
	;reset army camp
	$eBarbCount=0
	$eArchCount=0
	$eGiantCount=0
	$eGoblCount=0
	$eWallCount=0
	$eBallCount=0
	$eWizaCount=0
	$eHealCount=0
	$eDragCount=0
	$ePekkCount=0
	$eMiniCount=0
	$eHogsCount=0
	$eValkCount=0
	$eGoleCount=0
	$eWitcCount=0
	$eLavaCount=0
EndFunc

Func PercentComp()
	$BarbComp = Round($BarbComp * $TotalCamp / 100)
	$ArchComp = Round($ArchComp * $TotalCamp / 100)
	$GoblComp = Round($GoblComp * $TotalCamp / 100)
	$GiantComp = Round($GiantComp * $TotalCamp / 100)
	$WallComp = Round($WallComp * $TotalCamp / 100)
	$WizaComp = Round($WizaComp * $TotalCamp / 100)
	$MiniComp = Round($MiniComp * $TotalCamp / 100)
	$HogsComp = Round($HogsComp * $TotalCamp / 100)
	$DragComp = Round($DragComp * $TotalCamp / 100)
	$BallComp = Round($BallComp * $TotalCamp / 100)
	$PekkComp = Round($PekkComp * $TotalCamp / 100)
	$HealComp = Round($HealComp * $TotalCamp / 100)
	$ValkComp = Round($ValkComp * $TotalCamp / 100)
	$GoleComp = Round($GoleComp * $TotalCamp / 100)
	$WitcComp = Round($WitcComp * $TotalCamp / 100)
	$LavaComp = Round($LavaComp * $TotalCamp / 100)
EndFunc