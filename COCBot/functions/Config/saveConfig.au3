; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


Func saveConfig() ;Saves the controls settings to the config
	;General Settings--------------------------------------------------------------------------
	SWHTrainRevertNormal()
	Local $frmBotPos = WinGetPos($sBotTitle)
	IniWrite($config, "general", "cmbProfile", _GUICtrlComboBox_GetCurSel($cmbProfile))
	IniWrite($config, "general", "frmBotPosX", $frmBotPos[0])
	IniWrite($config, "general", "frmBotPosY", $frmBotPos[1])
	IniWrite($config, "general", "villageName", GUICtrlRead($txtVillageName))

	IniWrite($config, "general", "logstyle", _GUICtrlComboBox_GetCurSel($cmbLog))
	$DPos = ControlGetPos($frmBot, "", $divider)
	IniWrite($config, "general", "LogDividerY", $DPos[1])

	If GUICtrlRead($chkAutoStart) = $GUI_CHECKED Then
		IniWrite($config, "general", "AutoStart", 1)
	Else
		IniWrite($config, "general", "AutoStart", 0)
	EndIf
	IniWrite($config, "general", "AutoStartDelay", GUICtrlRead($txtAutostartDelay))



	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		IniWrite($config, "general", "Background", 1)
	Else
		IniWrite($config, "general", "Background", 0)
	EndIf

	If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
		IniWrite($config, "general", "BotStop", 1)
	Else
		IniWrite($config, "general", "BotStop", 0)
	EndIf

	If GUICtrlRead($chkIceBreaker) = $GUI_CHECKED Then
		IniWrite($config, "general", "IceBreaker", 1)
	Else
		IniWrite($config, "general", "IceBreaker", 0)
	EndIf

	If GUICtrlRead($chkKeepAlive) = $GUI_CHECKED Then
		IniWrite($config, "general", "KeepAlive", 1)
	Else
		IniWrite($config, "general", "KeepAlive", 0)
	EndIf

	If GUICtrlRead($chkClanAd) = $GUI_CHECKED Then
		IniWrite($config, "general", "ClanAd", 1)
		IniWrite($config, "general", "ClanAdText", GUICtrlRead($txtClanAd))
	Else
		IniWrite($config, "general", "ClanAd", 0)
	EndIf

	If GUICtrlRead($chkDisposeWindows) = $GUI_CHECKED Then
		IniWrite($config, "general", "DisposeWindows", 1)
	Else
		IniWrite($config, "general", "DisposeWindows", 0)
	EndIf
	IniWrite($config, "general", "DisposeWindowsPos", _GUICtrlComboBox_GetCurSel($cmbDisposeWindowsCond))

	IniWrite($config, "general", "Command", _GUICtrlComboBox_GetCurSel($cmbBotCommand))
	IniWrite($config, "general", "Cond", _GUICtrlComboBox_GetCurSel($cmbBotCond))
	IniWrite($config, "general", "Hour", _GUICtrlComboBox_GetCurSel($cmbHoursStop))


	;Search Settings------------------------------------------------------------------------

	IniWrite($config, "search", "SearchMode", _GUICtrlComboBox_GetCurSel($cmbSearchMode))

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		IniWrite($config, "search", "AlertSearch", 1)
	Else
		IniWrite($config, "search", "AlertSearch", 0)
	EndIf

	If GUICtrlRead($chkAlertSearchError) = $GUI_CHECKED Then
		IniWrite($config, "search", "AlertSearchError", 1)
	Else
		IniWrite($config, "search", "AlertSearchError", 0)
	EndIf

	; deadbase
	If GUICtrlRead($chkDBEnableAfter) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBEnableAfter", 1)
	Else
		IniWrite($config, "search", "DBEnableAfter", 0)
	EndIf

	IniWrite($config, "search", "DBMeetGE", _GUICtrlComboBox_GetCurSel($cmbDBMeetGE))

	If GUICtrlRead($chkDBMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBMeetDE", 1)
	Else
		IniWrite($config, "search", "DBMeetDE", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTrophy) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBMeetTrophy", 1)
	Else
		IniWrite($config, "search", "DBMeetTrophy", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTH) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBMeetTH", 1)
	Else
		IniWrite($config, "search", "DBMeetTH", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTHO) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBMeetTHO", 1)
	Else
		IniWrite($config, "search", "DBMeetTHO", 0)
	EndIf

	If GUICtrlRead($chkDBWeakBase) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBWeakBase", 1)
	Else
		IniWrite($config, "search", "DBWeakBase", 0)
	EndIf

	If GUICtrlRead($chkDBMeetOne) = $GUI_CHECKED Then
		IniWrite($config, "search", "DBMeetOne", 1)
	Else
		IniWrite($config, "search", "DBMeetOne", 0)
	EndIf

	IniWrite($config, "search", "DBEnableAfterCount", GUICtrlRead($txtDBEnableAfter))
	IniWrite($config, "search", "DBsearchGold", GUICtrlRead($txtDBMinGold))
	IniWrite($config, "search", "DBsearchElixir", GUICtrlRead($txtDBMinElixir))
	IniWrite($config, "search", "DBsearchGoldPlusElixir", GUICtrlRead($txtDBMinGoldPlusElixir))
	IniWrite($config, "search", "DBsearchDark", GUICtrlRead($txtDBMinDarkElixir))
	IniWrite($config, "search", "DBsearchTrophy", GUICtrlRead($txtDBMinTrophy))
	IniWrite($config, "search", "DBTHLevel", _GUICtrlComboBox_GetCurSel($cmbDBTH))
	IniWrite($config, "search", "DBWeakMortar", _GUICtrlComboBox_GetCurSel($cmbDBWeakMortar))
	IniWrite($config, "search", "DBWeakWizTower", _GUICtrlComboBox_GetCurSel($cmbDBWeakWizTower))

	;Hero Filters
	IniWrite($config, "search", "SkipCentreDE", _GUICtrlComboBox_GetCurSel($cmbSkipCentreDE))
	IniWrite($config, "search", "SkipUndetectedDE", _GUICtrlComboBox_GetCurSel($cmbSkipUndetectedDE))

	IniWrite($config, "search", "ABMeetGEHero", _GUICtrlComboBox_GetCurSel($cmbABMeetGEHero))

	If GUICtrlRead($chkABMeetDEHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetDEHero", 1)
	Else
		IniWrite($config, "search", "ABMeetDEHero", 0)
	EndIf

	If GUICtrlRead($chkABMeetTrophyHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTrophyHero", 1)
	Else
		IniWrite($config, "search", "ABMeetTrophyHero", 0)
	EndIf

	If GUICtrlRead($chkABMeetTHHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTHHero", 1)
	Else
		IniWrite($config, "search", "ABMeetTHHero", 0)
	EndIf

	If GUICtrlRead($chkABMeetTHOHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTHOHero", 1)
	Else
		IniWrite($config, "search", "ABMeetTHOHero", 0)
	EndIf

	If GUICtrlRead($chkABWeakBaseHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABWeakBaseHero", 1)
	Else
		IniWrite($config, "search", "ABWeakBaseHero", 0)
	EndIf

	If GUICtrlRead($chkABMeetOneHero) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetOneHero", 1)
	Else
		IniWrite($config, "search", "ABMeetOneHero", 0)
	EndIf

	IniWrite($config, "search", "ABsearchGoldHero", GUICtrlRead($txtABMinGoldHero))
	IniWrite($config, "search", "ABsearchElixirHero", GUICtrlRead($txtABMinElixirHero))
	IniWrite($config, "search", "ABsearchGoldPlusElixirHero", GUICtrlRead($txtABMinGoldPlusElixirHero))
	IniWrite($config, "search", "ABsearchDarkHero", GUICtrlRead($txtABMinDarkElixirHero))
	IniWrite($config, "search", "ABsearchTrophyHero", GUICtrlRead($txtABMinTrophyHero))
	IniWrite($config, "search", "ABTHLevelHero", _GUICtrlComboBox_GetCurSel($cmbABTHHero))
	IniWrite($config, "search", "ABWeakMortarHero", _GUICtrlComboBox_GetCurSel($cmbABWeakMortarHero))
	IniWrite($config, "search", "ABWeakWizTowerHero", _GUICtrlComboBox_GetCurSel($cmbABWeakWizTowerHero))

	If GUICtrlRead($chkLBBKFilter) = $GUI_CHECKED Then
		IniWrite($config, "search", "LBBKFilter", 1)
	Else
		IniWrite($config, "search", "LBBKFilter", 0)
	EndIf
	If GUICtrlRead($chkLBAQFilter) = $GUI_CHECKED Then
		IniWrite($config, "search", "LBAQFilter", 1)
	Else
		IniWrite($config, "search", "LBAQFilter", 0)
	EndIf


		;any base
	If GUICtrlRead($chkABEnableAfter) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABEnableAfter", 1)
	Else
		IniWrite($config, "search", "ABEnableAfter", 0)
	EndIf

	IniWrite($config, "search", "ABMeetGE", _GUICtrlComboBox_GetCurSel($cmbABMeetGE))

	If GUICtrlRead($chkABMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetDE", 1)
	Else
		IniWrite($config, "search", "ABMeetDE", 0)
	EndIf

	If GUICtrlRead($chkABMeetTrophy) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTrophy", 1)
	Else
		IniWrite($config, "search", "ABMeetTrophy", 0)
	EndIf

	If GUICtrlRead($chkABMeetTH) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTH", 1)
	Else
		IniWrite($config, "search", "ABMeetTH", 0)
	EndIf

	If GUICtrlRead($chkABMeetTHO) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetTHO", 1)
	Else
		IniWrite($config, "search", "ABMeetTHO", 0)
	EndIf

	If GUICtrlRead($chkABWeakBase) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABWeakBase", 1)
	Else
		IniWrite($config, "search", "ABWeakBase", 0)
	EndIf

	If GUICtrlRead($chkABMeetOne) = $GUI_CHECKED Then
		IniWrite($config, "search", "ABMeetOne", 1)
	Else
		IniWrite($config, "search", "ABMeetOne", 0)
	EndIf

	IniWrite($config, "search", "ABEnableAfterCount", GUICtrlRead($txtABEnableAfter))
	IniWrite($config, "search", "ABsearchGold", GUICtrlRead($txtABMinGold))
	IniWrite($config, "search", "ABsearchElixir", GUICtrlRead($txtABMinElixir))
	IniWrite($config, "search", "ABsearchGoldPlusElixir", GUICtrlRead($txtABMinGoldPlusElixir))
	IniWrite($config, "search", "ABsearchDark", GUICtrlRead($txtABMinDarkElixir))
	IniWrite($config, "search", "ABsearchTrophy", GUICtrlRead($txtABMinTrophy))
	IniWrite($config, "search", "ABTHLevel", _GUICtrlComboBox_GetCurSel($cmbABTH))
	IniWrite($config, "search", "ABWeakMortar", _GUICtrlComboBox_GetCurSel($cmbABWeakMortar))
	IniWrite($config, "search", "ABWeakWizTower", _GUICtrlComboBox_GetCurSel($cmbABWeakWizTower))

	If GUICtrlRead($chkSearchReduction) = $GUI_CHECKED Then
		IniWrite($config, "search", "reduction", 1)
	Else
		IniWrite($config, "search", "reduction", 0)
	EndIf

	IniWrite($config, "search", "reduceCount", GUICtrlRead($txtSearchReduceCount))
	IniWrite($config, "search", "reduceGold", GUICtrlRead($txtSearchReduceGold))
	IniWrite($config, "search", "reduceElixir", GUICtrlRead($txtSearchReduceElixir))
	IniWrite($config, "search", "reduceGoldPlusElixir", GUICtrlRead($txtSearchReduceGoldPlusElixir))
	IniWrite($config, "search", "reduceDark", GUICtrlRead($txtSearchReduceDark))
	IniWrite($config, "search", "reduceTrophy", GUICtrlRead($txtSearchReduceTrophy))

	;Attack Basic Settings-------------------------------------------------------------------------
	IniWrite($config, "attack", "DBDeploy", _GUICtrlComboBox_GetCurSel($cmbDBDeploy))
	IniWrite($config, "attack", "DBUnitD", _GUICtrlComboBox_GetCurSel($cmbDBUnitDelay))
	IniWrite($config, "attack", "DBWaveD", _GUICtrlComboBox_GetCurSel($cmbDBWaveDelay))
	IniWrite($config, "attack", "DBRandomSpeedAtk", GUICtrlRead($chkDBRandomSpeedAtk))
	IniWrite($config, "attack", "DBSelectTroop", _GUICtrlComboBox_GetCurSel($cmbDBSelectTroop))

	If GUICtrlRead($chkDBSmartAttackRedArea) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBSmartAttackRedArea", 1)
	Else
		IniWrite($config, "attack", "DBSmartAttackRedArea", 0)
	EndIf

	IniWrite($config, "attack", "DBSmartAttackDeploy", _GUICtrlComboBox_GetCurSel($cmbDBSmartDeploy))

	If GUICtrlRead($chkDBAttackNearGoldMine) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBSmartAttackGoldMine", 1)
	Else
		IniWrite($config, "attack", "DBSmartAttackGoldMine", 0)
	EndIf

	If GUICtrlRead($chkDBAttackNearElixirCollector) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBSmartAttackElixirCollector", 1)
	Else
		IniWrite($config, "attack", "DBSmartAttackElixirCollector", 0)
	EndIf

	If GUICtrlRead($chkDBAttackNearDarkElixirDrill) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBSmartAttackDarkElixirDrill", 1)
	Else
		IniWrite($config, "attack", "DBSmartAttackDarkElixirDrill", 0)
	EndIf

	IniWrite($config, "attack", "ABDeploy", _GUICtrlComboBox_GetCurSel($cmbABDeploy))
	IniWrite($config, "attack", "ABUnitD", _GUICtrlComboBox_GetCurSel($cmbABUnitDelay))
	IniWrite($config, "attack", "ABWaveD", _GUICtrlComboBox_GetCurSel($cmbABWaveDelay))
	IniWrite($config, "attack", "ABRandomSpeedAtk", GUICtrlRead($chkABRandomSpeedAtk))
	IniWrite($config, "attack", "ABSelectTroop", _GUICtrlComboBox_GetCurSel($cmbABSelectTroop))

	If GUICtrlRead($chkABSmartAttackRedArea) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABSmartAttackRedArea", 1)
	Else
		IniWrite($config, "attack", "ABSmartAttackRedArea", 0)
	EndIf

	IniWrite($config, "attack", "ABSmartAttackDeploy", _GUICtrlComboBox_GetCurSel($cmbABSmartDeploy))

	If GUICtrlRead($chkABAttackNearGoldMine) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABSmartAttackGoldMine", 1)
	Else
		IniWrite($config, "attack", "ABSmartAttackGoldMine", 0)
	EndIf

	If GUICtrlRead($chkABAttackNearElixirCollector) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABSmartAttackElixirCollector", 1)
	Else
		IniWrite($config, "attack", "ABSmartAttackElixirCollector", 0)
	EndIf

	If GUICtrlRead($chkABAttackNearDarkElixirDrill) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABSmartAttackDarkElixirDrill", 1)
	Else
		IniWrite($config, "attack", "ABSmartAttackDarkElixirDrill", 0)
	EndIf

	If GUICtrlRead($chkABDEUseSpell) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABDEUseSpell", 1)
	Else
		IniWrite($config, "attack", "ABDEUseSpell", 0)
	EndIf

	IniWrite($config, "attack", "ABDEUseSpellType", _GUICtrlComboBox_GetCurSel($cmbABDEUseSpellType))

	If GUICtrlRead($chkDBKingAttack) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBKingAtk", 1)
	Else
		IniWrite($config, "attack", "DBKingAtk", 0)
	EndIf
	If GUICtrlRead($chkABKingAttack) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABKingAtk", 1)
	Else
		IniWrite($config, "attack", "ABKingAtk", 0)
	EndIf

	If GUICtrlRead($chkDBQueenAttack) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBQueenAtk", 1)
	Else
		IniWrite($config, "attack", "DBQueenAtk", 0)
	EndIf
	If GUICtrlRead($chkABQueenAttack) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABQueenAtk", 1)
	Else
		IniWrite($config, "attack", "ABQueenAtk", 0)
	EndIf

	If GUICtrlRead($chkDBDropCC) = $GUI_CHECKED Then
		IniWrite($config, "attack", "DBDropCC", 1)
	Else
		IniWrite($config, "attack", "DBDropCC", 0)
	EndIf

	If GUICtrlRead($chkABDropCC) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ABDropCC", 1)
	Else
		IniWrite($config, "attack", "ABDropCC", 0)
	EndIf

	If GUICtrlRead($chkUseCCBalanced) = $GUI_CHECKED Then
		IniWrite($config, "attack", "BalanceCC", 1)
	Else
		IniWrite($config, "attack", "BalanceCC", 0)
	EndIf

	IniWrite($config, "attack", "BalanceCCDonated", _GUICtrlComboBox_GetCurSel($cmbCCDonated) + 1)
	IniWrite($config, "attack", "BalanceCCReceived", _GUICtrlComboBox_GetCurSel($cmbCCReceived) + 1)

	If GUICtrlRead($radManAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Manual")
	ElseIf GUICtrlRead($radAutoAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Auto")
	EndIf

	IniWrite($config, "attack", "delayActivateKQ", GUICtrlRead($txtManAbilities))

	If GUICtrlRead($chkTakeLootSS) = $GUI_CHECKED Then
		IniWrite($config, "attack", "TakeLootSnapShot", 1)
	Else
		IniWrite($config, "attack", "TakeLootSnapShot", 0)
	EndIf

	If GUICtrlRead($chkScreenshotLootInfo) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ScreenshotLootInfo", 1)
	Else
		IniWrite($config, "attack", "ScreenshotLootInfo", 0)
	EndIf

	;End Battle Settings------------------------------------------------------------------------
	IniWrite($config, "endbattle", "txtTimeStopAtk", GUICtrlRead($txtTimeStopAtk))
	IniWrite($config, "endbattle", "chkTimeStopAtk", GUICtrlRead($chkTimeStopAtk))

	IniWrite($config, "endbattle", "txtTimeStopAtk2", GUICtrlRead($txtTimeStopAtk2))
	IniWrite($config, "endbattle", "chkTimeStopAtk2", GUICtrlRead($chkTimeStopAtk2))

	IniWrite($config, "endbattle", "txtMinGoldStopAtk2", GUICtrlRead($txtMinGoldStopAtk2))
	IniWrite($config, "endbattle", "txtMinElixirStopAtk2", GUICtrlRead($txtMinElixirStopAtk2))
	IniWrite($config, "endbattle", "txtMinDarkElixirStopAtk2", GUICtrlRead($txtMinDarkElixirStopAtk2))

	IniWrite($config, "endbattle", "chkEndOneStar", GUICtrlRead($chkEndOneStar))
	IniWrite($config, "endbattle", "chkEndTwoStars", GUICtrlRead($chkEndTwoStars))

	If GUICtrlRead($chkEndNoResources) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkEndNoResources", 1)
	Else
		IniWrite($config, "endbattle", "chkEndNoResources", 0)
	EndIf


	If GUICtrlRead($chkDESideEB) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkDESideEB", 1)
	Else
		IniWrite($config, "endbattle", "chkDESideEB", 0)
	EndIf
	IniWrite($config, "endbattle", "txtDELowEndMin", GUICtrlRead($txtDELowEndMin))
	If GUICtrlRead($chkDisableOtherEBO) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkDisableOtherEBO", 1)
	Else
		IniWrite($config, "endbattle", "chkDisableOtherEBO", 0)
	EndIf
	If GUICtrlRead($chkDEEndAq) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkDEEndAq", 1)
	Else
		IniWrite($config, "endbattle", "chkDEEndAq", 0)
	EndIf
	If GUICtrlRead($chkDEEndBk) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkDEEndBk", 1)
	Else
		IniWrite($config, "endbattle", "chkDEEndBk", 0)
	EndIf
	If GUICtrlRead($chkDEEndOneStar) = $GUI_CHECKED Then
		IniWrite($config, "endbattle", "chkDEEndOneStar", 1)
	Else
		IniWrite($config, "endbattle", "chkDEEndOneStar", 0)
	EndIf


	;Advanced Settings--------------------------------------------------------------------------
	If GUICtrlRead($chkAttackNow) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "attacknow", 1)
	Else
		IniWrite($config, "advanced", "attacknow", 0)
	EndIf
	IniWrite($config, "advanced", "attacknowdelay", _GUICtrlComboBox_GetCurSel($cmbAttackNowDelay) + 1)

	If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "townhall", 1)
	Else
		IniWrite($config, "advanced", "townhall", 0)
	EndIf

	;	If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
	;		IniWrite($config, "advanced", "hitDElightning", 1)
	;	Else
	;		IniWrite($config, "advanced", "hitDElightning", 0)
	;	EndIf
	;	IniWrite($config, "advanced", "QLSpell", _GUICtrlComboBox_GetCurSel($cmbiLSpellQ) + 1)

	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "BullyMode", 1)
	Else
		IniWrite($config, "advanced", "BullyMode", 0)
	EndIf

	IniWrite($config, "advanced", "ATBullyMode", GUICtrlRead($txtATBullyMode))
	IniWrite($config, "advanced", "YourTH", _GUICtrlComboBox_GetCurSel($cmbYourTH))
	If GUICtrlRead($radUseDBAttack) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "THBullyAttackMode", 0)
	ElseIf GUICtrlRead($radUseLBAttack) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "THBullyAttackMode", 1)
	EndIf
	If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "TrophyMode", 1)
	Else
		IniWrite($config, "advanced", "TrophyMode", 0)
	EndIf

	;Train Spells
	;IniWrite($config, "advanced", "cmbTrainNormalSpellType", _GUICtrlComboBox_GetCurSel($cmbTrainNormalSpellType))
	;IniWrite($config, "advanced", "cmbTrainDarkSpellType", _GUICtrlComboBox_GetCurSel($cmbTrainDarkSpellType))

	If GUICtrlRead($chkTrainLSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainLSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainLSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainHSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainHSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainHSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainRSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainRSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainRSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainJSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainJSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainJSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainFSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainFSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainFSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainPSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainPSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainPSpell", "0")
	EndIf
	If GUICtrlRead($chkTrainESpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainESpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainESpell", "0")
	EndIf
	If GUICtrlRead($chkTrainHaSpell) = $GUI_CHECKED Then
	    IniWrite($config, "advanced", "chkTrainHaSpell", "1")
	Else
	    IniWrite($config, "advanced", "chkTrainHaSpell", "0")
	EndIf


	If GUICtrlRead($chkIgnoreTraps) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "IgnoreTraps", 1)
	Else
		IniWrite($config, "advanced", "IgnoreTraps", 0)
	EndIf
	If GUICtrlRead($chkIgnoreAirTraps) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "IgnoreAirTraps", 1)
	Else
		IniWrite($config, "advanced", "IgnoreAirTraps", 0)
	EndIf
	If GUICtrlRead($chkParanoid) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "Paranoid", 1)
	Else
		IniWrite($config, "advanced", "Paranoid", 0)
	EndIf
	If GUICtrlRead($chkGreedy) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "Greedy", 1)
	Else
		IniWrite($config, "advanced", "Greedy", 0)
	EndIf
	IniWrite($config, "advanced", "THaddTiles", GUICtrlRead($txtTHaddtiles))
	IniWrite($config, "advanced", "AttackTHType", _GUICtrlComboBox_GetCurSel($cmbAttackTHType))
	;Attack bottom townhall type
	;IniWrite($config, "advanced", "BottomTHType", _GUICtrlComboBox_GetCurSel($cmbAttackbottomType))

	If GUICtrlRead($chkAlertPBVillage) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "AlertPBVillage", 1)
	Else
		IniWrite($config, "advanced", "AlertPBVillage", 0)
	EndIf

	If GUICtrlRead($chkAlertPBLastRaidTxt) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBLastRaidTxt", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBLastRaidTxt", 0)
	EndIf


	If GUICtrlRead($chkAlertPBLastAttack) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "AlertPBLastAttack", 1)
	Else
		IniWrite($config, "advanced", "AlertPBLastAttack", 0)
	EndIf


	If GUICtrlRead($chkAlertPBCampFull) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertCampFull", 1)
	Else
		IniWrite($config, "pushbullet", "AlertCampFull", 0)
	EndIf
	;	If  GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
	;		IniWrite($config, "advanced", "chkUnbreakable", 1)
	;	Else
	;		IniWrite($config, "advanced", "chkUnbreakable", 0)
	;	EndIf
	IniWrite($config, "advanced", "UnbreakableWait", GUICtrlRead($txtUnbreakable))
	IniWrite($config, "advanced", "minUnBrkgold", GUICtrlRead($txtUnBrkMinGold))
	IniWrite($config, "advanced", "minUnBrkelixir", GUICtrlRead($txtUnBrkMinElixir))
	IniWrite($config, "advanced", "minUnBrkdark", GUICtrlRead($txtUnBrkMinDark))

	IniWrite($config, "advanced", "maxUnBrkgold", GUICtrlRead($txtUnBrkMaxGold))
	IniWrite($config, "advanced", "maxUnBrkelixir", GUICtrlRead($txtUnBrkMaxElixir))
	IniWrite($config, "advanced", "maxUnBrkdark", GUICtrlRead($txtUnBrkMaxDark))

	;atk their king
	;attk their queen

	;Donate Settings-------------------------------------------------------------------------
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkRequest", 1)
	Else
		IniWrite($config, "donate", "chkRequest", 0)
	EndIf

	IniWrite($config, "donate", "txtRequest", GUICtrlRead($txtRequest))

	If GUICtrlRead($chkDonate) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonate", 1)
	Else
		IniWrite($config, "donate", "chkDonate", 0)
	EndIf

	If GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateBarbarians", 0)
	EndIf

	If GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllBarbarians", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateBarbarians", StringReplace(GUICtrlRead($txtDonateBarbarians), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistBarbarians", StringReplace(GUICtrlRead($txtBlacklistBarbarians), @CRLF, "|"))

	If GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateArchers", 0)
	EndIf

	If GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllArchers", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateArchers", StringReplace(GUICtrlRead($txtDonateArchers), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistArchers", StringReplace(GUICtrlRead($txtBlacklistArchers), @CRLF, "|"))

	If GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateGiants", 0)
	EndIf

	If GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGiants", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateGiants", StringReplace(GUICtrlRead($txtDonateGiants), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistGiants", StringReplace(GUICtrlRead($txtBlacklistGiants), @CRLF, "|"))

	If GUICtrlRead($chkDonateGoblins) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateGoblins", 1)
	Else
		IniWrite($config, "donate", "chkDonateGoblins", 0)
	EndIf

	If GUICtrlRead($chkDonateAllGoblins) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllGoblins", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGoblins", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateGoblins", StringReplace(GUICtrlRead($txtDonateGoblins), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistGoblins", StringReplace(GUICtrlRead($txtBlacklistGoblins), @CRLF, "|"))

	If GUICtrlRead($chkDonateWallBreakers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateWallBreakers", 1)
	Else
		IniWrite($config, "donate", "chkDonateWallBreakers", 0)
	EndIf

	If GUICtrlRead($chkDonateAllWallBreakers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllWallBreakers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllWallBreakers", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateWallBreakers", StringReplace(GUICtrlRead($txtDonateWallBreakers), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistWallBreakers", StringReplace(GUICtrlRead($txtBlacklistWallBreakers), @CRLF, "|"))

	If GUICtrlRead($chkDonateBalloons) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateBalloons", 1)
	Else
		IniWrite($config, "donate", "chkDonateBalloons", 0)
	EndIf

	If GUICtrlRead($chkDonateAllBalloons) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllBalloons", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllBalloons", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateBalloons", StringReplace(GUICtrlRead($txtDonateBalloons), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistBalloons", StringReplace(GUICtrlRead($txtBlacklistBalloons), @CRLF, "|"))

	If GUICtrlRead($chkDonateWizards) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateWizards", 1)
	Else
		IniWrite($config, "donate", "chkDonateWizards", 0)
	EndIf

	If GUICtrlRead($chkDonateAllWizards) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllWizards", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllWizards", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateWizards", StringReplace(GUICtrlRead($txtDonateWizards), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistWizards", StringReplace(GUICtrlRead($txtBlacklistWizards), @CRLF, "|"))

	If GUICtrlRead($chkDonateHealers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateHealers", 1)
	Else
		IniWrite($config, "donate", "chkDonateHealers", 0)
	EndIf

	If GUICtrlRead($chkDonateAllHealers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllHealers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllHealers", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateHealers", StringReplace(GUICtrlRead($txtDonateHealers), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistHealers", StringReplace(GUICtrlRead($txtBlacklistHealers), @CRLF, "|"))

	If GUICtrlRead($chkDonateDragons) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateDragons", 1)
	Else
		IniWrite($config, "donate", "chkDonateDragons", 0)
	EndIf

	If GUICtrlRead($chkDonateAllDragons) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllDragons", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllDragons", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateDragons", StringReplace(GUICtrlRead($txtDonateDragons), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistDragons", StringReplace(GUICtrlRead($txtBlacklistDragons), @CRLF, "|"))

	If GUICtrlRead($chkDonatePekkas) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonatePekkas", 1)
	Else
		IniWrite($config, "donate", "chkDonatePekkas", 0)
	EndIf

	If GUICtrlRead($chkDonateAllPekkas) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllPekkas", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllPekkas", 0)
	EndIf

	IniWrite($config, "donate", "txtDonatePekkas", StringReplace(GUICtrlRead($txtDonatePekkas), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistPekkas", StringReplace(GUICtrlRead($txtBlacklistPekkas), @CRLF, "|"))

	If GUICtrlRead($chkDonateMinions) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateMinions", 1)
	Else
		IniWrite($config, "donate", "chkDonateMinions", 0)
	EndIf

	If GUICtrlRead($chkDonateAllMinions) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllMinions", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllMinions", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateMinions", StringReplace(GUICtrlRead($txtDonateMinions), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistMinions", StringReplace(GUICtrlRead($txtBlacklistMinions), @CRLF, "|"))

	If GUICtrlRead($chkDonateHogRiders) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateHogRiders", 1)
	Else
		IniWrite($config, "donate", "chkDonateHogRiders", 0)
	EndIf

	If GUICtrlRead($chkDonateAllHogRiders) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllHogRiders", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllHogRiders", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateHogRiders", StringReplace(GUICtrlRead($txtDonateHogRiders), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistHogRiders", StringReplace(GUICtrlRead($txtBlacklistHogRiders), @CRLF, "|"))

	If GUICtrlRead($chkDonateValkyries) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateValkyries", 1)
	Else
		IniWrite($config, "donate", "chkDonateValkyries", 0)
	EndIf

	If GUICtrlRead($chkDonateAllValkyries) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllValkyries", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllValkyries", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateValkyries", StringReplace(GUICtrlRead($txtDonateValkyries), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistValkyries", StringReplace(GUICtrlRead($txtBlacklistValkyries), @CRLF, "|"))

	If GUICtrlRead($chkDonateGolems) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateGolems", 1)
	Else
		IniWrite($config, "donate", "chkDonateGolems", 0)
	EndIf

	If GUICtrlRead($chkDonateAllGolems) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllGolems", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGolems", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateGolems", StringReplace(GUICtrlRead($txtDonateGolems), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistGolems", StringReplace(GUICtrlRead($txtBlacklistGolems), @CRLF, "|"))

	If GUICtrlRead($chkDonateWitches) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateWitches", 1)
	Else
		IniWrite($config, "donate", "chkDonateWitches", 0)
	EndIf

	If GUICtrlRead($chkDonateAllWitches) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllWitches", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllWitches", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateWitches", StringReplace(GUICtrlRead($txtDonateWitches), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistWitches", StringReplace(GUICtrlRead($txtBlacklistWitches), @CRLF, "|"))

	If GUICtrlRead($chkDonateLavaHounds) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateLavaHounds", 1)
	Else
		IniWrite($config, "donate", "chkDonateLavaHounds", 0)
	EndIf

	If GUICtrlRead($chkDonateAllLavaHounds) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllLavaHounds", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllLavaHounds", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateLavaHounds", StringReplace(GUICtrlRead($txtDonateLavaHounds), @CRLF, "|"))
	IniWrite($config, "donate", "txtBlacklistLavaHounds", StringReplace(GUICtrlRead($txtBlacklistLavaHounds), @CRLF, "|"))

	;;; Custom Combination Donate by ChiefM3
	If GUICtrlRead($chkDonateCustom) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateCustom", 1)
	Else
		IniWrite($config, "donate", "chkDonateCustom", 0)
	EndIf
	If GUICtrlRead($chkDonateAllCustom) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllCustom", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllCustom", 0)
	EndIf
	IniWrite($config, "donate", "txtDonateCustom", StringReplace(GUICtrlRead($txtDonateCustom), @CRLF, "|"))

	IniWrite($config, "donate", "txtBlacklistCustom", StringReplace(GUICtrlRead($txtBlacklistCustom), @CRLF, "|"))

	IniWrite($config, "donate", "cmbDonateCustom1", _GUICtrlComboBox_GetCurSel($cmbDonateCustom1))
	IniWrite($config, "donate", "txtDonateCustom1", GUICtrlRead($txtDonateCustom1))
	IniWrite($config, "donate", "cmbDonateCustom2", _GUICtrlComboBox_GetCurSel($cmbDonateCustom2))
	IniWrite($config, "donate", "txtDonateCustom2", GUICtrlRead($txtDonateCustom2))
	IniWrite($config, "donate", "cmbDonateCustom3", _GUICtrlComboBox_GetCurSel($cmbDonateCustom3))
	IniWrite($config, "donate", "txtDonateCustom3", GUICtrlRead($txtDonateCustom3))
	IniWrite($config, "donate", "txtBlacklist", StringReplace(GUICtrlRead($txtBlacklist), @CRLF, "|"))

	;Troop Settings--------------------------------------------------------------------------
	IniWrite($config, "troop", "TroopComposition", _GUICtrlComboBox_GetCurSel($cmbTroopComp))

	If GUICtrlRead($chkUsePercent) = $GUI_CHECKED Then
		IniWrite($config, "troop", "Percent", 1)
	Else
		IniWrite($config, "troop", "Percent", 0)
	EndIf

	For $i = 0 To UBound($TroopName) - 1
		IniWrite($config, "troop", $TroopName[$i], GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		IniWrite($config, "troop", $TroopDarkName[$i], GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
	Next

	IniWrite($config, "troop", "troop1", _GUICtrlComboBox_GetCurSel($cmbBarrack1))
	IniWrite($config, "troop", "troop2", _GUICtrlComboBox_GetCurSel($cmbBarrack2))
	IniWrite($config, "troop", "troop3", _GUICtrlComboBox_GetCurSel($cmbBarrack3))
	IniWrite($config, "troop", "troop4", _GUICtrlComboBox_GetCurSel($cmbBarrack4))

	IniWrite($config, "troop", "darktroop1", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack1))
	IniWrite($config, "troop", "darktroop2", _GUICtrlComboBox_GetCurSel($cmbDarkBarrack2))

	IniWrite($config, "troop", "fulltroop", GUICtrlRead($txtFullTroop))
	IniWrite($config, "troop", "TrainITDelay", GUICtrlRead($sldTrainITDelay))

	;barracks boost not saved (no use)

	If GUICtrlRead($radAccuracy) = $GUI_CHECKED Then
		IniWrite($config, "troop", "Speed", 0)
	ElseIf GUICtrlRead($radSpeed) = $GUI_CHECKED Then
		IniWrite($config, "troop", "Speed", 1)
	EndIf

	;Misc Settings--------------------------------------------------------------------------
	If $ichkWalls = 1 Then
		IniWrite($config, "other", "auto-wall", 1)
	Else
		IniWrite($config, "other", "auto-wall", 0)
	EndIf

	If GUICtrlRead($UseGold) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 0)
	ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 1)
	ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 2)
	EndIf

	If $iSaveWallBldr = 1 Then
		IniWrite($config, "other", "savebldr", 1)
	Else
		IniWrite($config, "other", "savebldr", 0)
	EndIf

	IniWrite($config, "other", "walllvl", _GUICtrlComboBox_GetCurSel($cmbWalls))
	IniWrite($config, "other", "minwallgold", GUICtrlRead($txtWallMinGold))
	IniWrite($config, "other", "minwallelixir", GUICtrlRead($txtWallMinElixir))

	IniWrite($config, "other", "minrestartgold", GUICtrlRead($txtRestartGold ))
	IniWrite($config, "other", "minrestartelixir", GUICtrlRead($txtRestartElixir))
	IniWrite($config, "other", "minrestartdark", GUICtrlRead($txtRestartDark ))


	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkTrap", 1)
	Else
		IniWrite($config, "other", "chkTrap", 0)
	EndIf
	If GUICtrlRead($chkCollect) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkCollect", 1)
	Else
		IniWrite($config, "other", "chkCollect", 0)
	EndIf
	If GUICtrlRead($chkTombstones) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkTombstones", 1)
	Else
		IniWrite($config, "other", "chkTombstones", 0)
	EndIf
	IniWrite($config, "other", "txtTimeWakeUp", GUICtrlRead($txtTimeWakeUp))
	IniWrite($config, "other", "VSDelay", GUICtrlRead($sldVSDelay))

	IniWrite($config, "other", "MaxTrophy", GUICtrlRead($txtMaxTrophy))
	IniWrite($config, "other", "MinTrophy", GUICtrlRead($txtdropTrophy))
	If GUICtrlRead($chkTrophyHeroes) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkTrophyHeroes", 1)
	Else
		IniWrite($config, "other", "chkTrophyHeroes", 0)
	EndIf

	If GUICtrlRead($chkTrophyAtkDead) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkTrophyAtkDead", 1)
	Else
		IniWrite($config, "other", "chkTrophyAtkDead", 0)
	EndIf

	;laboratory
	If GUICtrlRead($chkLab) = $GUI_CHECKED Then
		IniWrite($config, "upgrade", "upgradetroops", 1)
	Else
		IniWrite($config, "upgrade", "upgradetroops", 0)
	EndIf
	IniWrite($config, "upgrade", "upgradetroopname", _GUICtrlComboBox_GetCurSel($cmbLaboratory))
	IniWrite($building, "upgrade", "LabPosX", $aLabPos[0])
	IniWrite($building, "upgrade", "LabPosY", $aLabPos[1])
	;

	For $iz = 0 To 11 ; Save Upgrades data
		IniWrite($building, "upgrade", "xupgrade" & $iz, $aUpgrades[$iz][0])
		IniWrite($building, "upgrade", "yupgrade" & $iz, $aUpgrades[$iz][1])
		IniWrite($building, "upgrade", "upgradevalue" & $iz, $aUpgrades[$iz][2])
		IniWrite($building, "upgrade", "upgradetype" & $iz, $aUpgrades[$iz][3])
		IniWrite($building, "upgrade", "upgradestatusicon" & $iz, $ipicUpgradeStatus[$iz])
		If GUICtrlRead($chkbxUpgrade[$iz]) = $GUI_CHECKED Then
			IniWrite($building, "upgrade", "upgradechk" & $iz, 1)
		Else
			IniWrite($building, "upgrade", "upgradechk" & $iz, 0)
		EndIf
	Next
	IniWrite($building, "upgrade", "minupgrgold", GUICtrlRead($txtUpgrMinGold))
	IniWrite($building, "upgrade", "minupgrelixir", GUICtrlRead($txtUpgrMinElixir))
	IniWrite($building, "upgrade", "minupgrdark", GUICtrlRead($txtUpgrMinDark))

	IniWrite($building, "other", "xTownHall", $TownHallPos[0])
	IniWrite($building, "other", "yTownHall", $TownHallPos[1])
	IniWrite($building, "other", "LevelTownHall", $iTownHallLevel)

	IniWrite($building, "other", "xCCPos", $aCCPos[0])
	IniWrite($building, "other", "yCCPos", $aCCPos[1])

	IniWrite($building, "other", "xKingPos", $KingPos[0])
	IniWrite($building, "other", "yKingPos", $KingPos[1])

	IniWrite($building, "other", "xQueenPos", $QueenPos[0])
	IniWrite($building, "other", "yQueenPos", $QueenPos[1])
	IniWrite($building, "other", "xArmy", $ArmyPos[0])
	IniWrite($building, "other", "yArmy", $ArmyPos[1])

	If GUICtrlRead($chkUpgradeKing) = $GUI_CHECKED Then ;==>upgradeking
	    IniWrite($building, "other", "UpKing", 1)
	Else
	    IniWrite($building, "other", "UpKing", 0)
	EndIf

	If GUICtrlRead($chkUpgradeQueen) = $GUI_CHECKED Then ;==>upgradequeen
	    IniWrite($building, "other", "UpQueen", 1)
	Else
	    IniWrite($building, "other", "UpQueen", 0)
	EndIf
	;IniWrite($building, "other", "barrackNum", $barrackNum)
	;IniWrite($building, "other", "barrackDarkNum", $barrackDarkNum)

	IniWrite($building, "other", "listResource", $listResourceLocation)

	;For $i = 0 To 3 ;Covers all 4 Barracks
	IniWrite($building, "other", "xBarrack", $barrackPos[0])
	IniWrite($building, "other", "yBarrack", $barrackPos[1])
	;Next

	IniWrite($building, "other", "xSpellfactory", $SFPos[0])
	IniWrite($building, "other", "ySpellfactory", $SFPos[1])

	;PushBullet Settings----------------------------------------
	IniWrite($config, "pushbullet", "AccountToken", GUICtrlRead($PushBTokenValue))
	IniWrite($config, "pushbullet", "OrigPushB", GUICtrlRead($txtVillageName))

	If GUICtrlRead($chkAlertPBVillage) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBVillage", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBVillage", 0)
	EndIf

	If GUICtrlRead($chkAlertPBLastAttack) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBLastAttack", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBLastAttack", 0)
	EndIf

	If GUICtrlRead($chkPBenabled) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "PBEnabled", 1)
	Else
		IniWrite($config, "pushbullet", "PBEnabled", 0)
	EndIf

	If GUICtrlRead($chkPBRemote) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "PBRemote", 1)
	Else
		IniWrite($config, "pushbullet", "PBRemote", 0)
	EndIf

	If GUICtrlRead($chkDeleteAllPushes) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "DeleteAllPBPushes", 1)
	Else
		IniWrite($config, "pushbullet", "DeleteAllPBPushes", 0)
	EndIf

	If GUICtrlRead($chkAlertPBVMFound) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBVMFound", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBVMFound", 0)
	EndIf

	If GUICtrlRead($chkAlertPBLastRaid) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBLastRaid", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBLastRaid", 0)
	EndIf

	If GUICtrlRead($chkAlertPBWallUpgrade) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBWallUpgrade", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBWallUpgrade", 0)
	EndIf

	If GUICtrlRead($chkAlertPBOOS) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBOOS", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBOOS", 0)
	EndIf

	If GUICtrlRead($chkAlertPBVBreak) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBVBreak", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBVBreak", 0)
	EndIf

	If GUICtrlRead($chkAlertPBOtherDevice) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "AlertPBOtherDevice", 1)
	Else
		IniWrite($config, "pushbullet", "AlertPBOtherDevice", 0)
	EndIf

	IniWrite($config, "pushbullet", "HoursPushBullet", _GUICtrlComboBox_GetCurSel($cmbHoursPushBullet) + 1)

	If GUICtrlRead($chkDeleteOldPushes) = $GUI_CHECKED Then
		IniWrite($config, "pushbullet", "DeleteOldPushes", 1)
	Else
		IniWrite($config, "pushbullet", "DeleteOldPushes", 0)
	EndIf

	IniWrite($config, "other", "WAOffsetX", GUICtrlRead($txtWAOffsetX))
	IniWrite($config, "other", "WAOffsetY", GUICtrlRead($txtWAOffsetY))


	; delete Files
	If GUICtrlRead($chkDeleteLogs) = $GUI_CHECKED Then
		IniWrite($config, "deletefiles", "DeleteLogs", 1)
	Else
		IniWrite($config, "deletefiles", "DeleteLogs", 0)
	EndIf
	IniWrite($config, "deletefiles", "DeleteLogsDays", GUICtrlRead($txtDeleteLogsDays))

	If GUICtrlRead($chkDeleteTemp) = $GUI_CHECKED Then
		IniWrite($config, "deletefiles", "DeleteTemp", 1)
	Else
		IniWrite($config, "deletefiles", "DeleteTemp", 0)
	EndIf
	IniWrite($config, "deletefiles", "DeleteTempDays", GUICtrlRead($txtDeleteTempDays))

	If GUICtrlRead($chkDeleteLoots) = $GUI_CHECKED Then
		IniWrite($config, "deletefiles", "DeleteLoots", 1)
	Else
		IniWrite($config, "deletefiles", "DeleteLoots", 0)
	EndIf
	IniWrite($config, "deletefiles", "DeleteLootsDays", GUICtrlRead($txtDeleteLootsDays))

	; planned
	If GUICtrlRead($chkRequestCCHours) = $GUI_CHECKED Then
		IniWrite($config, "planned", "RequestHoursEnable", 1)
	Else
		IniWrite($config, "planned", "RequestHoursEnable", 0)
	EndIf
	If GUICtrlRead($chkDonateHours) = $GUI_CHECKED Then
		IniWrite($config, "planned", "DonateHoursEnable", 1)
	Else
		IniWrite($config, "planned", "DonateHoursEnable", 0)
	EndIf
	If GUICtrlRead($chkDropCCHours) = $GUI_CHECKED Then
		IniWrite($config, "planned", "DropCCEnable", 1)
	Else
		IniWrite($config, "planned", "DropCCEnable", 0)
	EndIf

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkDonateHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWrite($config, "planned", "DonateHours", $string)

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkRequestCCHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWrite($config, "planned", "RequestHours", $string)

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkDropCCHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWrite($config, "planned", "DropCCHours", $string)

	;Share Attack Settings----------------------------------------
	IniWrite($config, "shareattack", "minGold", GUICtrlRead($txtShareMinGold))
	IniWrite($config, "shareattack", "minElixir", GUICtrlRead($txtShareMinElixir))
	IniWrite($config, "shareattack", "minDark", GUICtrlRead($txtShareMinDark))
	IniWrite($config, "shareattack", "Message", StringReplace(GUICtrlRead($txtShareMessage), @CRLF, "|"))
	If GUICtrlRead($chkShareAttack) = $GUI_CHECKED Then
		IniWrite($config, "shareattack", "ShareAttack", 1)
	Else
		IniWrite($config, "shareattack", "ShareAttack", 0)
	EndIf




	;screenshot
	If GUICtrlRead($chkScreenshotType) = $GUI_CHECKED Then
		IniWrite($config, "other", "ScreenshotType", 1)
	Else
		IniWrite($config, "other", "ScreenshotType", 0)
	EndIf

	If GUICtrlRead($chkScreenshotHideName) = $GUI_CHECKED Then
		IniWrite($config, "other", "ScreenshotHideName", 1)
	Else
		IniWrite($config, "other", "ScreenshotHideName", 0)
	EndIf


	; debug
	If GUICtrlRead($chkDebugClick) = $GUI_CHECKED Then
		IniWrite($config, "debug", "debugClick", 1)
	Else
		IniWrite($config, "debug", "debugClick", 0)
	EndIf

	If $DevMode = 1 Then
		If GUICtrlRead($chkDebugSetLog) = $GUI_CHECKED Then
			IniWrite($config, "debug", "debugsetlog", 1)
		Else
			IniWrite($config, "debug", "debugsetlog", 0)
		EndIf
		If GUICtrlRead($chkDebugOcr) = $GUI_CHECKED Then
			IniWrite($config, "debug", "debugocr", 1)
		Else
			IniWrite($config, "debug", "debugocr", 0)
		EndIf
	Else
		IniDelete($config, "debug", "debugocr")
		IniDelete($config, "debug", "debugsetlog")
	EndIf

	;forced Total Camp values
	If GUICtrlRead($ChkTotalCampForced) = $GUI_CHECKED Then
		IniWrite($config, "other", "ChkTotalCampForced", 1)
	Else
		IniWrite($config, "other", "ChkTotalCampForced", 0)
	EndIf
	IniWrite($config, "other", "ValueTotalCampForced", GUICtrlRead($txtTotalCampForced))


	If GUICtrlRead($ChkLanguage) = $GUI_CHECKED Then
		IniWrite($config, "General", "ChkLanguage", 1)
	Else
		IniWrite($config, "General", "ChkLanguage", 0)
	EndIf

	If GUICtrlRead($chkVersion) = $GUI_CHECKED Then
		IniWrite($config, "General", "ChkVersion", 1)
	Else
		IniWrite($config, "General", "ChkVersion", 0)
	EndIf
    ;;; Toolbox
    If GUICtrlRead($chkToolboxModeBot) = $GUI_CHECKED Then
        IniWrite($config, "Toolbox", "ModeBot", 1)
    Else
        IniWrite($config, "Toolbox", "ModeBot", 0)
    EndIf

    If GUICtrlRead($chkToolboxModeSearch) = $GUI_CHECKED Then
        IniWrite($config, "Toolbox", "ModeSearch", 1)
    Else
        IniWrite($config, "Toolbox", "ModeSearch", 0)
    EndIf

    If GUICtrlRead($chkToolboxDetach) = $GUI_CHECKED Then
        IniWrite($config, "Toolbox", "Detach", 1)
    Else
        IniWrite($config, "Toolbox", "Detach", 0)
    EndIf

    If GUICtrlRead($chkToolboxSavePos) = $GUI_CHECKED Then
        IniWrite($config, "Toolbox", "SavePos", 1)
        Local $winPos = WinGetPos ($sToolboxTitle)
        IniWrite($config, "Toolbox", "xToolbox", $winPos[0])
        IniWrite($config, "Toolbox", "yToolbox", $winPos[1])
    Else
        IniWrite($config, "Toolbox", "SavePos", 0)
        IniWrite($config, "Toolbox", "xToolbox", 0)
        IniWrite($config, "Toolbox", "yToolbox", 0)
    EndIf
If GUICtrlRead($chkSnipeWhileTrain) = $GUI_CHECKED Then ; Snipe While Train MOD by ChiefM3
   IniWrite($config, "advanced", "chkSnipeWhileTrain", 1)
   Else
   IniWrite($config, "advanced", "chkSnipeWhileTrain", 0)
   EndIf

	If GUICtrlRead($gtfo) = $GUI_CHECKED Then
       IniWrite($config, "donate", "gtfo", 1)
    Else
       IniWrite($config, "donate", "gtfo", 0)
    EndIf
       IniWrite($config, "donate", "GTFOKickCount", _GUICtrlComboBox_GetCurSel($cmbgtfo))

    If GUICtrlRead($donateAllSub) = $GUI_CHECKED Then
       IniWrite($config, "donate", "donateAllSub", 1)
    Else
       IniWrite($config, "donate", "donateAllSub", 0)
    EndIf
     IniWrite($config, "donate", "donateAllSubTroop", _GUICtrlComboBox_GetCurSel($cmbDonateAllSub))

	;Profile Switch Settings
	If GUICtrlRead($chkGoldSwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkGoldSwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkGoldSwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbGoldMaxProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMaxProfile))
	IniWrite($config, "profiles", "txtMaxGoldAmount", GUICtrlRead($txtMaxGoldAmount))

	If GUICtrlRead($chkGoldSwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkGoldSwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkGoldSwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbGoldMinProfile", _GUICtrlComboBox_GetCurSel($cmbGoldMinProfile))
	IniWrite($config, "profiles", "txtMinGoldAmount", GUICtrlRead($txtMinGoldAmount))

	If GUICtrlRead($chkElixirSwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkElixirSwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkElixirSwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbElixirMaxProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMaxProfile))
	IniWrite($config, "profiles", "txtMaxElixirAmount", GUICtrlRead($txtMaxElixirAmount))

	If GUICtrlRead($chkElixirSwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkElixirSwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkElixirSwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbElixirMinProfile", _GUICtrlComboBox_GetCurSel($cmbElixirMinProfile))
	IniWrite($config, "profiles", "txtMinElixirAmount", GUICtrlRead($txtMinElixirAmount))

	If GUICtrlRead($chkDESwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkDESwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkDESwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbDEMaxProfile", _GUICtrlComboBox_GetCurSel($cmbDEMaxProfile))
	IniWrite($config, "profiles", "txtMaxDEAmount", GUICtrlRead($txtMaxDEAmount))

	If GUICtrlRead($chkDESwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkDESwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkDESwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbDEMinProfile", _GUICtrlComboBox_GetCurSel($cmbDEMinProfile))
	IniWrite($config, "profiles", "txtMinDEAmount", GUICtrlRead($txtMinDEAmount))

	If GUICtrlRead($chkTrophySwitchMax) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkTrophySwitchMax", 1)
	Else
		IniWrite($config, "profiles", "chkTrophySwitchMax", 0)
	EndIf
	IniWrite($config, "profiles", "cmbTrophyMaxProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMaxProfile))
	IniWrite($config, "profiles", "txtMaxTrophyAmount", GUICtrlRead($txtMaxTrophyAmount))

	If GUICtrlRead($chkTrophySwitchMin) = $GUI_CHECKED Then
		IniWrite($config, "profiles", "chkTrophySwitchMin", 1)
	Else
		IniWrite($config, "profiles", "chkTrophySwitchMin", 0)
	EndIf
	IniWrite($config, "profiles", "cmbTrophyMinProfile", _GUICtrlComboBox_GetCurSel($cmbTrophyMinProfile))
	IniWrite($config, "profiles", "txtMinTrophyAmount", GUICtrlRead($txtMinTrophyAmount))



EndFunc   ;==>saveConfig
