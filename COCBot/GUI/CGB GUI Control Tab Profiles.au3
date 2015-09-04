
Func cmbProfile()
	saveConfig()
	FileClose($hLogFileHandle)
	FileClose($hAttackLogFileHandle)
	Switch _GUICtrlComboBox_GetCurSel($cmbProfile)
		Case 0
			$sCurrProfile = "01"
		Case 1
			$sCurrProfile = "02"
		Case 2
			$sCurrProfile = "03"
		Case 3
			$sCurrProfile = "04"
		Case 4
			$sCurrProfile = "05"
		Case 5
			$sCurrProfile = "06"
	EndSwitch
;~ 	MsgBox($MB_SYSTEMMODAL, "", "Profile " & $sCurrProfile & " loaded successfully!")
	DirCreate($sProfilePath & "\" & $sCurrProfile)
	$sProfilePath = @ScriptDir & "\Profiles"
	If FileExists($sProfilePath & "\profile.ini") = 0 Then
		Local $hFile = FileOpen($sProfilePath & "\profile.ini",BitOR($FO_APPEND,$FO_CREATEPATH))
		FileWriteLine($hfile, "[general]")
		FileClose($hFile)
	EndIf
	IniWrite($sProfilePath & "\profile.ini", "general", "defaultprofile", $sCurrProfile)
	$config = $sProfilePath & "\" & $sCurrProfile & "\config.ini"
	$building = $sProfilePath & "\" & $sCurrProfile & "\building.ini"
	$dirLogs = $sProfilePath & "\" & $sCurrProfile & "\Logs\"
	$dirLoots = $sProfilePath & "\" & $sCurrProfile & "\Loots\"
	$dirTemp = $sProfilePath & "\" & $sCurrProfile & "\Temp\"
	DirCreate($dirLogs)
	DirCreate($dirLoots)
	DirCreate($dirTemp)
	readConfig()
	applyConfig()
	saveConfig()
	SetLog(_PadStringCenter("Profile " & $sCurrProfile & " loaded from " & $config, 50, "="), $COLOR_GREEN)
EndFunc   ;==>cmbProfile

Func txtVillageName()
	$iVillageName = GUICtrlRead($txtVillageName)
	If $iVillageName = "" Then $iVillageName = "MyVillage"
	GUICtrlSetData($grpVillage, "Village: " & $iVillageName)
	GUICtrlSetData($OrigPushB, $iVillageName)
	GUICtrlSetData($txtVillageName, $iVillageName)

EndFunc   ;==>txtVillageName
