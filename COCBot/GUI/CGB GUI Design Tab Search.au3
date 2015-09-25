; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GKevinOD (2014)
; Modified ......: DkEd, Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

;~ -------------------------------------------------------------
;~ Search Tab
;~ -------------------------------------------------------------

$tabSearch = GUICtrlCreateTabItem("Search")
	Local $x = 30, $y = 150
	$grpSearchMode = GUICtrlCreateGroup("Search Mode", $x - 20, $y - 20, 160, 55)
		$cmbSearchMode = GUICtrlCreateCombo("", $x - 10 , $y, 140, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Only Deadbases: full collectors. Most loot outside of village." & @CRLF & _
						"Only LiveBases: full storages. Most loot inside of village." & @CRLF & "Dual Mode: Search for both, whatever comes first is attacked."
			GUICtrlSetData(-1, "Only DeadBases|Only LiveBases|Both Dead & LiveBases", "Only DeadBases")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "cmbSearchMode")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 195
	$grpAlert = GUICtrlCreateGroup("Alert when a base", $x - 10, $y - 20, 170, 60)
		$chkAlertSearch = GUICtrlCreateCheckbox("is found", $x, $y - 5, -1, -1, $BS_MULTILINE)
			GUICtrlSetTip(-1, "Check this if you want an Audio alarm & a Balloon Tip when a Base to attack is found.")
			GUICtrlSetState(-1, $GUI_CHECKED)
		$chkAlertSearchError = GUICtrlCreateCheckbox("can't be determined", $x, $y + 15, -1, -1, $BS_MULTILINE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)


	Local $x = 30, $y = 210
	$grpDeadBaseConditions = GUICtrlCreateGroup("DeadBase Conditions", $x - 20, $y - 20, 225, 255)
		$chkDBEnableAfter = GUICtrlCreateCheckbox("Delay Start:", $x, $y, -1, -1)
			$txtTip = "Search for a Dead Base after this No. of searches, start searching for Live Bases first.."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkDBEnableAfter")
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDBEnableAfter = GUICtrlCreateInput("150", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "No. of searches to wait before activating this mode."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetState(-1, $GUI_HIDE)
		$lblDBEnableAfter = GUICtrlCreateLabel("search(es).", $x + 132, $y + 4, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 21
		$cmbDBMeetGE = GUICtrlCreateCombo("", $x , $y + 10, 65, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Search for a base that meets the values set for Gold And/Or/Plus Elixir." & @CRLF & "AND: Both conditions must meet, Gold and Elixir." & @CRLF & "OR: One condition must meet, Gold or Elixir." & @CRLF & "+ (PLUS): Total amount of Gold + Elixir must meet."
			GUICtrlSetData(-1, "G And E|G Or E|G + E", "G And E")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "cmbDBGoldElixir")
		$txtDBMinGold = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Gold to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBMinGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$txtDBMinElixir = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picDBMinElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y -= 11
		$txtDBMinGoldPlusElixir = GUICtrlCreateInput("160000", $x + 80, $y, 50, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Gold + Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picDBMinGPEGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$lblDBMinGPE = GUICtrlCreateLabel("+", $x + 147, $y + 1, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picDBMinGPEElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 153, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$y += 31
		$chkDBMeetDE = GUICtrlCreateCheckbox("Dark Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Dark Elixir."
			GUICtrlSetOnEvent(-1, "chkDBMeetDE")
			GUICtrlSetTip(-1, $txtTip)
		$txtDBMinDarkElixir = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Dark Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
			_GUICtrlEdit_SetReadOnly(-1, True)
		$picDBMinDarkElixir = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkDBMeetTrophy = GUICtrlCreateCheckbox("Trophies", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Trophies."
			GUICtrlSetOnEvent(-1, "chkDBMeetTrophy")
			GUICtrlSetTip(-1, $txtTip)
		$txtDBMinTrophy = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Trophies to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetLimit(-1, 2)
		$picDBMinTrophies = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkDBMeetTH = GUICtrlCreateCheckbox("Townhall", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Max. Townhall Level."
			GUICtrlSetOnEvent(-1, "chkDBMeetTH")
			GUICtrlSetTip(-1, $txtTip)
		$cmbDBTH = GUICtrlCreateCombo("", $x + 80, $y - 1, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Townhall to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
		$picDBMaxTH1 = GUICtrlCreateIcon($pIconLib, $eIcnTH1, $x + 131, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$lblDBMaxTH = GUICtrlCreateLabel("-", $x + 156, $y + 1, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$picDBMaxTH10 = GUICtrlCreateIcon($pIconLib, $eIcnTH10, $x + 160, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkDBMeetTHO = GUICtrlCreateCheckbox("Townhall Outside", $x, $y, -1, -1)
			$txtTip = "Search for a base that has an exposed Townhall. (Outside of Walls)"
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkDBWeakBase = GUICtrlCreateCheckbox("WeakBase", $x, $y, -1, -1)
			$txtTip = "Search for a base that has low defences."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkDBWeakBase")
		$cmbDBWeakMortar = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Mortar to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 5")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picDBWeakMortar = GUICtrlCreateIcon($pIconLib, $eIcnMortar, $x + 131, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y +=23
		$cmbDBWeakWizTower = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Wizard Tower to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 4")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picDBWeakWizTower = GUICtrlCreateIcon($pIconLib, $eIcnWizTower, $x + 131, $y - 2, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 30
		$chkDBMeetOne = GUICtrlCreateCheckbox("Meet One Then Attack", $x, $y, -1, -1)
			$txtTip = "Just meet only ONE of the above conditions, then Attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 260, $y = 210
	$grpLiveBaseConditions = GUICtrlCreateGroup("LiveBase Conditions", $x - 20, $y - 20, 220, 255)
		$chkABEnableAfter = GUICtrlCreateCheckbox("Delay Start:", $x, $y, -1, -1)
			$txtTip = "Search for a Live Base after this No. of searches, start searching for Dead Bases first.."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkABEnableAfter")
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtABEnableAfter = GUICtrlCreateInput("150", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "No. of searches to wait before activating this mode."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetState(-1, $GUI_HIDE)
		$lblABEnableAfter = GUICtrlCreateLabel("search(es).", $x + 132, $y + 4, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 21
		$cmbABMeetGE = GUICtrlCreateCombo("", $x , $y + 10, 65, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Search for a base that meets the values set for Min. Gold, Elixir."
			GUICtrlSetData(-1, "G And E|G Or E|G + E", "G + E")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "cmbABGoldElixir")
		$txtABMinGold = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Gold to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picABMinGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$y += 21
		$txtABMinElixir = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picABMinElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$y -= 11
		$txtABMinGoldPlusElixir = GUICtrlCreateInput("160000", $x + 80, $y, 50, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Gold + Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picABMinGPEGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$lblABMinGPE = GUICtrlCreateLabel("+", $x + 147, $y + 1, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$picABMinGPEElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 153, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
		$y += 31
		$chkABMeetDE = GUICtrlCreateCheckbox("Dark Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Dark Elixir."
			GUICtrlSetOnEvent(-1, "chkABMeetDE")
			GUICtrlSetTip(-1, $txtTip)
		$txtABMinDarkElixir = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Dark Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
			_GUICtrlEdit_SetReadOnly(-1, True)
		$picABMinDarkElixir = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkABMeetTrophy = GUICtrlCreateCheckbox("Trophies", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Trophies."
			GUICtrlSetOnEvent(-1, "chkABMeetTrophy")
			GUICtrlSetTip(-1, $txtTip)
		$txtABMinTrophy = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the Min. amount of Trophies to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetLimit(-1, 2)
		$picABMinTrophies = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 131, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkABMeetTH = GUICtrlCreateCheckbox("Townhall", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Max. Townhall Level."
			GUICtrlSetOnEvent(-1, "chkABMeetTH")
			GUICtrlSetTip(-1, $txtTip)
		$cmbABTH = GUICtrlCreateCombo("", $x + 80, $y - 1, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Townhall to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
		$picABMaxTH1 = GUICtrlCreateIcon($pIconLib, $eIcnTH1, $x + 131, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$lblABMaxTH = GUICtrlCreateLabel("-", $x + 156, $y + 1, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$picABMaxTH10 = GUICtrlCreateIcon($pIconLib, $eIcnTH10, $x + 160, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkABMeetTHO = GUICtrlCreateCheckbox("Townhall Outside", $x, $y, -1, -1)
			$txtTip = "Search for a base that has an exposed Townhall. (Outside of Walls)"
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$chkABWeakBase = GUICtrlCreateCheckbox("WeakBase", $x, $y, -1, -1)
			$txtTip = "Search for a base that has low defences."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkABWeakBase")
		$cmbABWeakMortar = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Mortar to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 5")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picABWeakMortar = GUICtrlCreateIcon($pIconLib, $eIcnMortar, $x + 131, $y - 3, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y +=23
		$cmbABWeakWizTower = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Set the Max. level of the Wizard Tower to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 4")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picABWeakWizTower = GUICtrlCreateIcon($pIconLib, $eIcnWizTower, $x + 131, $y - 2, 24, 24)
			GUICtrlSetTip(-1, $txtTip)
		$y += 30
		$chkABMeetOne = GUICtrlCreateCheckbox("Meet One Then Attack", $x, $y, -1, -1)
			$txtTip = "Just meet only ONE of the above conditions, then Attack."
			GUICtrlSetTip(-1, $txtTip)
		For $i = $cmbABMeetGE To $chkABMeetOne
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 470
	$grpSearchReduction = GUICtrlCreateGroup("Search Reduction", $x - 20, $y - 20, 450, 55)
		$chkSearchReduction = GUICtrlCreateCheckbox("Lower Aim, Every:", $x , $y, -1, -1)
			$txtTip = "Check this if you want the search values to automatically be lowered after a certain amount of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkSearchReduction")
		$txtSearchReduceCount = GUICtrlCreateInput("20", $x + 105, $y + 2, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Enter the No. of searches to wait before each reduction occures."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$lblSearchReduceCount = GUICtrlCreateLabel("search(es).", $x + 145, $y + 3, -1, -1)
		$x += 210
		$y -= 9
		$lblSearchReduceGold = GUICtrlCreateLabel("-", $x, $y + 3, -1, 17)
			$txtTip = "Lower value for Gold by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceGold = GUICtrlCreateInput("2000", $x + 5, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$picSearchReduceGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 46, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$lblSearchReduceElixir = GUICtrlCreateLabel("-", $x, $y + 3, -1, 17)
			$txtTip = "Lower value for Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceElixir = GUICtrlCreateInput("2000", $x + 5, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$picSearchReduceElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 46, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$x += 70
		$y -= 10
		$lblSearchReduceGoldPlusElixir = GUICtrlCreateLabel("-", $x, $y + 3, -1, 17)
			$txtTip = "Lower total sum for G+E by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceGoldPlusElixir = GUICtrlCreateInput("4000", $x + 5, $y, 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$picSearchReduceGPEGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 46, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$lblSearchReduceGPE = GUICtrlCreateLabel("+", $x + 62, $y + 1, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$picSearchReduceGPEElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 68, $y + 1, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$x += 90
		$y -= 11
		$lblSearchReduceDark = GUICtrlCreateLabel("-", $x, $y + 3, -1, 17)
			$txtTip = "Lower value for Dark Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceDark = GUICtrlCreateInput("100", $x + 5, $y, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$picSearchReduceDark = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 41, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
		$y += 21
		$lblSearchReduceTrophy = GUICtrlCreateLabel("-", $x, $y + 3, -1, 17)
			$txtTip = "Lower value for Trophies by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceTrophy = GUICtrlCreateInput("2", $x + 5, $y, 35, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 1)
		$picSearchReduceTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 41, $y, 16, 16)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

		Local $x = 380, $y = 150
		$grpHeroFilterSwitch = GUICtrlCreateGroup("Advanced Search", $x - 20, $y - 20, 100, 55)
		$btnHeroSwitch = GUICtrlCreateButton("Normal Filters", $x - 15, $y - 5, 90, 35)
			IF $btnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
			GUICtrlSetOnEvent($btnHeroSwitch, "hidenormal")
			GUICtrlSetState($btnHeroSwitch, $GUI_HIDE)
		$btnNormalSwitch = GUICtrlCreateButton("Advanced Filters", $x - 15, $y - 5, 90, 35)
			IF $btnColor then GUICtrlSetBkColor(-1, 0xDB4D4D)
			GUICtrlSetOnEvent($btnNormalSwitch, "hidehero")
		GUICtrlCreateGroup("", -99, -99, 1, 1)





	Local $x = 30, $y = 150
	$grpSkipCentreDE = GUICtrlCreateGroup("Skip Centre DE", $x - 20, $y - 20, 170, 55)
	GUICtrlSetState (-1, $GUI_HIDE)
		$cmbSkipCentreDE = GUICtrlCreateCombo("", $x - 15 , $y, 160, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Always attack centre De storage no filter" & @CRLF & _
						"Always skip base when de is in the centre." & @CRLF & "Only skip centre de base if either bk or aq filter enabled and they are healing."
			GUICtrlSetData(-1, "Always Attack Centre DE|Always Skip Centre DE|Skip When BK/AQ Sleeping", "Always Attack Centre DE")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 205
	$grpSkipUndetectedDE = GUICtrlCreateGroup("Skip Undetected DE", $x - 20, $y - 20, 170, 55)
	GUICtrlSetState (-1, $GUI_HIDE)
		$cmbSkipUndetectedDE = GUICtrlCreateCombo("", $x - 15 , $y, 160, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Always attack centre De storage no filter" & @CRLF & _
						"Always skip base when de is not found." & @CRLF & "Only skip undetected de base if either bk or aq filter enabled and they are healing."
			GUICtrlSetData(-1, "Always Attack Centre DE|Always Skip Centre DE|Skip When BK/AQ Sleeping", "Always Attack Centre DE")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState (-1, $GUI_HIDE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

		Local $x = 30, $y = 210
			$grpLiveBaseConditionsKing = GUICtrlCreateGroup("King Filter", $x - 20, $y - 20, 225, 130)
			GUICtrlSetState (-1, $GUI_HIDE)
			GUICtrlCreatePic (@ScriptDir & "\Icons\KingAbility.jpg", $x, $y - 5, 60, 94)
			GUICtrlSetState (-1, $GUI_HIDE)
			$chkLBBKFilter = GUICtrlCreateCheckbox("Enable For Bk", $x + 70, $y + 45, -1, -1)
				$txtTip = "Enable this so that when King is healing bot will use new search conditions for Live Bases"
				GUICtrlSetTip(-1, $txtTip)
				GUICtrlSetState(-1, $GUI_HIDE)
			$grpLiveBaseConditionsQueen = GUICtrlCreateGroup("Queen Filter", $x - 20, $y + 110, 225, 125)
			GUICtrlSetState (-1, $GUI_HIDE)
			GUICtrlCreatePic (@ScriptDir & "\Icons\QueenAbility.jpg", $x, $y + 125, 60, 94)
			GUICtrlSetState (-1, $GUI_HIDE)
			$chkLBAQFilter = GUICtrlCreateCheckbox("Enable For Aq", $x + 70, $y + 165, -1, -1)
				$txtTip = "Enable this so that when Queen is healing bot will use new search conditions for Live Bases"
				GUICtrlSetTip(-1, $txtTip)
				GUICtrlSetState(-1, $GUI_HIDE)

		Local $x = 260, $y = 210
			;Hero Heal Feature.
				$grpLiveBaseConditionsHero = GUICtrlCreateGroup("LiveBase No Hero Filter Conditions", $x - 20, $y - 20, 220, 255)
				$y += 21
				$cmbABMeetGEHero = GUICtrlCreateCombo("", $x , $y + 10, 65, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$txtTip = "Search for a base that meets the values set for Min. Gold, Elixir."
					GUICtrlSetData(-1, "G And E|G Or E|G + E", "G + E")
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetOnEvent(-1, "cmbABGoldElixirHero")
				$txtABMinGoldHero = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
					$txtTip = "Set the Min. amount of Gold to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetLimit(-1, 6)
					GUICtrlSetState (-1, $GUI_HIDE)
				$picABMinGoldHero = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetState (-1, $GUI_HIDE)
				$y += 21
				$txtABMinElixirHero = GUICtrlCreateInput("80000", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
					$txtTip = "Set the Min. amount of Elixir to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetLimit(-1, 6)
					GUICtrlSetState (-1, $GUI_HIDE)
				$picABMinElixirHero = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 131, $y, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetState (-1, $GUI_HIDE)
				$y -= 11
				$txtABMinGoldPlusElixirHero = GUICtrlCreateInput("160000", $x + 80, $y, 50, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
					$txtTip = "Set the Min. amount of Gold + Elixir to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetLimit(-1, 6)
				$picABMinGPEGoldHero = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 131, $y + 1, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
				$lblABMinGPEHero = GUICtrlCreateLabel("+", $x + 147, $y + 1, -1, -1)
					GUICtrlSetTip(-1, $txtTip)
				$picABMinGPEElixirHero = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 153, $y + 1, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
				$y += 31
				$chkABMeetDEHero = GUICtrlCreateCheckbox("Dark Elixir", $x , $y, -1, -1)
					$txtTip = "Search for a base that meets the value set for Min. Dark Elixir."
					GUICtrlSetOnEvent(-1, "chkABMeetDEHero")
					GUICtrlSetTip(-1, $txtTip)
				$txtABMinDarkElixirHero = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
					$txtTip = "Set the Min. amount of Dark Elixir to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetLimit(-1, 5)
					_GUICtrlEdit_SetReadOnly(-1, True)
				$picABMinDarkElixirHero = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 131, $y, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
				$y += 21
				$chkABMeetTrophyHero = GUICtrlCreateCheckbox("Trophies", $x, $y, -1, -1)
					$txtTip = "Search for a base that meets the value set for Min. Trophies."
					GUICtrlSetOnEvent(-1, "chkABMeetTrophyHero")
					GUICtrlSetTip(-1, $txtTip)
				$txtABMinTrophyHero = GUICtrlCreateInput("0", $x + 80, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
					$txtTip = "Set the Min. amount of Trophies to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					_GUICtrlEdit_SetReadOnly(-1, True)
					GUICtrlSetLimit(-1, 2)
				$picABMinTrophiesHero = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 131, $y, 16, 16)
					GUICtrlSetTip(-1, $txtTip)
				$y += 21
				$chkABMeetTHHero = GUICtrlCreateCheckbox("Townhall", $x, $y, -1, -1)
					$txtTip = "Search for a base that meets the value set for Max. Townhall Level."
					GUICtrlSetOnEvent(-1, "chkABMeetTHHero")
					GUICtrlSetTip(-1, $txtTip)
				$cmbABTHHero = GUICtrlCreateCombo("", $x + 80, $y - 1, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$txtTip = "Set the Max. level of the Townhall to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetState(-1, $GUI_DISABLE)
					GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
				$picABMaxTH1Hero = GUICtrlCreateIcon($pIconLib, $eIcnTH1, $x + 131, $y - 3, 24, 24)
					GUICtrlSetTip(-1, $txtTip)
				$lblABMaxTHHero = GUICtrlCreateLabel("-", $x + 156, $y + 1, -1, -1)
					GUICtrlSetTip(-1, $txtTip)
				$picABMaxTH10Hero = GUICtrlCreateIcon($pIconLib, $eIcnTH10, $x + 160, $y - 3, 24, 24)
					GUICtrlSetTip(-1, $txtTip)
				$y += 21
				$chkABMeetTHOHero = GUICtrlCreateCheckbox("Townhall Outside", $x, $y, -1, -1)
					$txtTip = "Search for a base that has an exposed Townhall. (Outside of Walls)"
					GUICtrlSetTip(-1, $txtTip)
				$y += 21
				$chkABWeakBaseHero = GUICtrlCreateCheckbox("WeakBase", $x, $y, -1, -1)
					$txtTip = "Search for a base that has low defences."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetOnEvent(-1, "chkABWeakBaseHero")
				$cmbABWeakMortarHero = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$txtTip = "Set the Max. level of the Mortar to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 5")
					GUICtrlSetState(-1, $GUI_DISABLE)
				$picABWeakMortarHero = GUICtrlCreateIcon($pIconLib, $eIcnMortar, $x + 131, $y - 3, 24, 24)
					GUICtrlSetTip(-1, $txtTip)
				$y +=23
				$cmbABWeakWizTowerHero = GUICtrlCreateCombo("", $x + 80, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$txtTip = "Set the Max. level of the Wizard Tower to search for on a village to attack."
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetData(-1, "-|Lvl 1|Lvl 2|Lvl 3|Lvl 4|Lvl 5|Lvl 6|Lvl 7|Lvl 8", "Lvl 4")
					GUICtrlSetState(-1, $GUI_DISABLE)
				$picABWeakWizTowerHero = GUICtrlCreateIcon($pIconLib, $eIcnWizTower, $x + 131, $y - 2, 24, 24)
					GUICtrlSetTip(-1, $txtTip)
				$y += 30
				$chkABMeetOneHero = GUICtrlCreateCheckbox("Meet One Then Attack", $x, $y, -1, -1)
					$txtTip = "Just meet only ONE of the above conditions, then Attack."
					GUICtrlSetTip(-1, $txtTip)
				For $i = $grpLiveBaseConditionsKing To $chkABMeetOne
					GUICtrlSetState($i, $GUI_HIDE)
				Next
			GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
hidenormal()