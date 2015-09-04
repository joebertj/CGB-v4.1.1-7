Func ProfileSwitch()
	If $ichkGoldSwitchMax = 1 Or $ichkGoldSwitchMin = 1 Or $ichkElixirSwitchMax = 1 Or $ichkElixirSwitchMin = 1 Or _
	$ichkDESwitchMax = 1 Or $ichkDESwitchMin = 1 Or $ichkTrophySwitchMax = 1 Or $ichkTrophySwitchMin = 1 Then
		Local $SwitchtoProfile = ""
		While True
			If $ichkGoldSwitchMax = 1 Then
				If Number($GoldCount) >= Number($itxtMaxGoldAmount) Then
					$SwitchtoProfile = $icmbGoldMaxProfile
					Setlog("Village Gold detected Above Gold Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkGoldSwitchMin = 1 Then
				If Number($GoldCount) <= Number($itxtMinGoldAmount) Then
					$SwitchtoProfile = $icmbGoldMinProfile
					Setlog("Village Gold detected Below Gold Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMax = 1 Then
				If Number($ElixirCount) >= Number($itxtMaxElixirAmount) Then
					$SwitchtoProfile = $icmbElixirMaxProfile
					Setlog("Village Gold detected Above Elixir Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkElixirSwitchMin = 1 Then
				If Number($ElixirCount) <= Number($itxtMinElixirAmount) Then
					$SwitchtoProfile = $icmbElixirMinProfile
					Setlog("Village Gold detected Below Elixir Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMax = 1 Then
				If Number($DarkCount) >=	Number($itxtMaxDEAmount) Then
					$SwitchtoProfile = $icmbDEMaxProfile
					Setlog("Village Dark Elixir detected Above Dark Elixir Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkDESwitchMin = 1 Then
				If Number($DarkCount) <=	Number($itxtMinDEAmount) Then
					$SwitchtoProfile = $icmbDEMinProfile
					Setlog("Village Dark Elixir detected Below Dark Elixir Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMax = 1 Then
				If Number($TrophyCount) >=	Number($itxtMaxTrophyAmount) Then
					$SwitchtoProfile = $icmbTrophyMaxProfile
					Setlog("Village Trophies detected Above Throphy Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			If $ichkTrophySwitchMin = 1 Then
				If Number($TrophyCount) <= Number($itxtMinTrophyAmount) Then
					$SwitchtoProfile = $icmbTrophyMinProfile
					Setlog("Village Trophies detected Below Trophy Profile Switch Conditions")
					ExitLoop
				EndIf
			EndIf
			ExitLoop
		WEnd

		If $SwitchtoProfile <> "" Then
			_GUICtrlComboBox_SetCurSel($cmbProfile, $SwitchtoProfile)
			cmbProfile()
		EndIf
	EndIf

EndFunc