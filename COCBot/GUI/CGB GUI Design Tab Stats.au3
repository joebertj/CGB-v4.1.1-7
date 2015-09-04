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
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $LastControlToHide = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHide + 1]
;~ -------------------------------------------------------------

;~ -------------------------------------------------------------
;~ Stats Tab
;~ -------------------------------------------------------------
$tabStats = GUICtrlCreateTabItem("Stats")
Local $x = 30, $y = 150
	$grpResourceOnStart = GUICtrlCreateGroup("Started with", $x - 20, $y - 20, 95, 105)
		$lblResultStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will appear" & @CRLF & "here on" & @CRLF & "first run.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 55, $y, 16, 16)
		$lblResultGoldStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 55, $y, 16, 16)
		$lblResultElixirStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picResultDEStart = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 55, $y, 16, 16)
		$lblResultDEStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 55, $y, 16, 16)
		$lblResultTrophyStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 130
	$y = 150
	$grpLastAttack = GUICtrlCreateGroup("Last Attack", $x - 20, $y - 20, 95, 105)
		$lblLastAttackTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 55, $y, 16, 16)
		$lblGoldLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 55, $y, 16, 16)
		$lblElixirLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLastAttack = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 55, $y, 16, 16)
		$lblDarkLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 55, $y, 16, 16)
		$lblTrophyLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost on the last attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 230
   	$y = 150
	  $grpHourlyStats = GUICtrlCreateGroup("Hourly Stats", $x - 20, $y - 20, 95, 105)
	  $lblHourlyStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
	  GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 55, $y, 16, 16)
	  $lblHourlyStatsGold = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
	  $txtTip = "Net Gold gain per hour"
	  GUICtrlSetTip(-1, $txtTip)
   $y +=20
	  GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 55, $y, 16, 16)
	  $lblHourlyStatsElixir = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
	  $txtTip = "Net Elixir gain per hour"
	  GUICtrlSetTip(-1, $txtTip)
   $y +=20
	  $picHourlyStatsDark = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 55, $y, 16, 16)
	  $lblHourlyStatsDark = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
	  $txtTip = "Net Dark Elixir gain per hour"
	  GUICtrlSetTip(-1, $txtTip)
   $y +=20
	  GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 55, $y, 16, 16)
	  $lblHourlyStatsTrophy = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
	  $txtTip = "Net Trophy gain per hour"
	  GUICtrlSetTip(-1, $txtTip)
   GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 330
	$y = 150
    $grpTotalLoot = GUICtrlCreateGroup("Total Loot", $x - 20, $y - 20, 95, 105)
		$lblTotalLootTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 55, $y, 16, 16)
		$lblGoldLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Gold you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 55, $y, 16, 16)
		$lblElixirLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLoot = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 55, $y, 16, 16)
        $lblDarkLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Dark Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 55, $y, 16, 16)
		$lblTrophyLoot = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost while the Bot is running."
			GUICtrlSetTip(-1, $txtTip)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 410
	$y = 135
	$btnMoreStats = GUICtrlCreateButton ("More", $x, $y, 50,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=25
	$btnExportCSV = GUICtrlCreateButton ("Export", $x, $y, 50,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
#cs    $y +=25
    $btnLoots = GUICtrlCreateButton ("Loots", $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLoots")
    $y +=25
    $btnLogs = GUICtrlCreateButton ("Logs", $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLogs")
#ce

    $x = 30
    $y = 265
	   $grpStatsMisc = GUICtrlCreateGroup("Stats: Misc", $x - 20, $y - 20, 450, 75)
	   $y -=2
	   GUICtrlCreateIcon ($pIconLib, $eIcnTH1, $x - 15, $y + 7, 20, 20)
	   GUICtrlCreateIcon ($pIconLib, $eIcnTH10, $x + 6, $y + 7, 20, 20)
	   $lblvillagesattacked = GUICtrlCreateLabel("Attacked:", $x + 28, $y + 2, -1, 17)
 	   $lblresultvillagesattacked = GUICtrlCreateLabel("0", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
 	   $txtTip = "The No. of Villages that were attacked by the Bot."
	   GUICtrlSetTip(-1, $txtTip)
	   $y += 17
		  $lblvillagesskipped = GUICtrlCreateLabel("Skipped:", $x + 28, $y + 2, -1, 17)
		  $lblresultvillagesskipped = GUICtrlCreateLabel("0", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
		  $txtTip = "The No. of Villages that were skipped during search by the Bot."
		  GUICtrlSetTip(-1, $txtTip)
    $x = 180
    $y = 263
	   GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x, $y, 15, 15)
       $lbltrophiesdropped = GUICtrlCreateLabel("Dropped:", $x + 20, $y + 2, -1, 17)
       $lblresulttrophiesdropped = GUICtrlCreateLabel("0", $x + 80, $y + 2, 30, 17, $SS_RIGHT)
	   $txtTip = "The amount of Trophies dropped by the Bot due to Trophy Settings (on Misc Tab)."
	   GUICtrlSetTip(-1, $txtTip)
	   $y += 17
		  GUICtrlCreateIcon ($pIconLib, $eIcnHourGlass, $x, $y, 15, 15)
		  $lblruntime = GUICtrlCreateLabel("Runtime:", $x + 20, $y + 2, -1, 17)
		  $lblresultruntime = GUICtrlCreateLabel("00:00:00", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
		  $txtTip = "The total Running Time of the Bot."
		  GUICtrlSetTip(-1, $txtTip)
	   $x = 330
	   $y = 263
		  GUICtrlCreateIcon ($pIconLib, $eIcnWall, $x - 3, $y + 7, 20, 20)
		  $lblwallbygold = GUICtrlCreateLabel("Upg. by Gold:", $x + 20, $y + 2, -1, 17)
		  $lblWallgoldmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
		  $txtTip = "The No. of Walls upgraded by Gold."
		  GUICtrlSetTip(-1, $txtTip)
		  $y += 17
		 	 $lblwallbyelixir = GUICtrlCreateLabel("Upg. by Elixir:", $x + 20, $y + 2, -1, 17)
			 $lblWallelixirmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			 $txtTip = "The No. of Walls upgraded by Elixir."
			 GUICtrlSetTip(-1, $txtTip)
		  $y += 17
			 $lbloutofsync = GUICtrlCreateLabel("Out Of Sync :", $x + 20, $y + 2, -1, 17)
			 $lblresultoutofsync = GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			 $txtTip = "Restarted after Out of Sync Error:"
			 GUICtrlSetTip(-1, $txtTip)
   GUICtrlCreateGroup("", -99, -99, 1, 1)