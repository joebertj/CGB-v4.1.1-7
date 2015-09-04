$tabProfiles = GUICtrlCreateTabItem("Profiles")

Local $x = 30, $y = 150
	$grpControls = GUICtrlCreateGroup("Profiles", $x - 20, $y - 20, 450, 45)
		$lblProfile = GUICtrlCreateLabel("Current Profile:", $x, $y, -1, -1)
		$cmbProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$txtTip = "Use this to switch to a different profile. Default: 01" & @CRLF & "Your profiles/configs can be found in:" & @CRLF &  $sProfilePath
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "02|03|04|05|06", "01")
		GUICtrlSetOnEvent(-1, "cmbProfile")
		$txtVillageName = GUICtrlCreateInput("MyVillage", $x + 120, $y - 4, 90, 18, BitOR($SS_CENTER, $ES_AUTOHSCROLL))
		GUICtrlSetLimit (-1, 20, 0)
		GUICtrlSetFont(-1, 9, 800, 1)
		GUICtrlSetTip(-1, "Your village's name")
		GUICtrlSetOnEvent(-1, "txtVillageName")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 30, $y = 200
	$grpGoldSwitch = GUICtrlCreateGroup("Gold Switch Profile Conditions", $x - 20, $y - 20, 450, 75) ;Gold Switch
		$chkGoldSwitchMax = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when gold is above amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMaxProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblGoldMax = GUICtrlCreateLabel("When Gold is Above", $x + 130, $y, -1, -1)
		$txtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Gold to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
$y += 30
		$chkGoldSwitchMin = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when gold is below amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbGoldMinProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblGoldMin = GUICtrlCreateLabel("When Gold is Below", $x + 130, $y, -1, -1)
		$txtMinGoldAmount = GUICtrlCreateInput("500000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Gold to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 360, $y - 40, 64, 64)
		$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 350, $y - 30, 16, 16)
		$picProfileGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 330, $y - 15, 32, 32)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 50
	$grpElixirSwitch = GUICtrlCreateGroup("Elixir Switch Profile Conditions", $x - 20, $y - 20, 450, 75) ; Elixir Switch
		$chkElixirSwitchMax = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Elixir is above amount."
			GUICtrlSetTip(-1, $txtTip)

		$cmbElixirMaxProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblElixirMax = GUICtrlCreateLabel("When Elixir is Above", $x + 130, $y, -1, -1)
		$txtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Elixir to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
$y += 30
		$chkElixirSwitchMin = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Elixir is below amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbElixirMinProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblElixirMin = GUICtrlCreateLabel("When Elixir is Below", $x + 130, $y, -1, -1)
		$txtMinElixirAmount = GUICtrlCreateInput("500000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Elixir to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
		$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 360, $y - 40, 64, 64)
		$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 350, $y - 30, 16, 16)
		$picProfileElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 330, $y - 15, 32, 32)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 50
	$grpDESwitch = GUICtrlCreateGroup("Dark Elixir Switch Profile Conditions", $x - 20, $y - 20, 450, 75) ;DE Switch
		$chkDESwitchMax = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Dark Elixir is above amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbDEMaxProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblDEMax = GUICtrlCreateLabel("When Dark Elixir is Above", $x + 130, $y, -1, -1)
		$txtMaxDEAmount = GUICtrlCreateInput("200000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Dark Elixir to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
$y += 30
		$chkDESwitchMin = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Dark Elixir is below amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbDEMinProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblDEMin = GUICtrlCreateLabel("When  Dark Elixir is Below", $x + 130, $y, -1, -1)
		$txtMinDEAmount = GUICtrlCreateInput("10000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Dark Elixir to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 360, $y - 40, 64, 64)
		$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 350, $y - 30, 16, 16)
		$picProfileDE = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 330, $y - 15, 32, 32)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 50
	$grpTrophySwitch = GUICtrlCreateGroup("Trophy Switch Profile Conditions", $x - 20, $y - 20, 450, 85) ; Trophy Switch
		$chkTrophySwitchMax = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Trophies are above amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMaxProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblTrophyMax = GUICtrlCreateLabel("When Trophies are Above", $x + 130, $y, -1, -1)
		$txtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Trophies to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
$y += 30
		$chkTrophySwitchMin = GUICtrlCreateCheckbox("Switch To", $x, $y - 5, -1, -1)
			$txtTip = "Enable this to switch profiles when Trophies are below amount."
			GUICtrlSetTip(-1, $txtTip)
		$cmbTrophyMinProfile = GUICtrlCreateCombo("01", $x + 75, $y - 5, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "Select which profile to be switched to when conditions met"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "02|03|04|05|06", "01")
		$lblTrophyMin = GUICtrlCreateLabel("When Trophies are Below", $x + 130, $y, -1, -1)
		$txtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 265, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the amount of Trophies to trigger switching Profile."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
		$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 360, $y - 40, 64, 64)
		$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 345, $y - 35, 16, 16)
		$picProfileTrophy = GUICtrlCreateIcon($pIconLib, $eIcnTrophy, $x + 330, $y - 15, 32, 32)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateTabItem("")