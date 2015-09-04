
Func AttackTHSmartBarch()

   		 Setlog("Sniping TH with SmartBarch")

		 ; 1st wave 30 secs, total 4 barbs 8 archers, works for totally unprotected TH
		 SetLog("Attacking TH with 1st wave of BARCH", $COLOR_BLUE)
		 AttackTHGrid($eBarb,4,1,2000,1,4,0) ; deploys 4 barbarians to take out traps waits 2 seconds for bombs to go off
		 AttackTHGrid($eArch,2,4,28000,1,4,0) ; deploys 8 archers and wait additional 28sec

		;check for one star
         local $count = 0
         While $count < 10
         If _Sleep(1000) Then Return

         If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
     	SetLog("Townhall has been destroyed!")
     	If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
    	Return ;exit if you get a star
        EndIf
        $count+=1
        WEnd
        ;end check for one star

		 ; 2nd wave 25 secs total 16 barbs, 22 archers, works for TH partially covered by defenses
 		 SetLog("Attacking TH with 2nd wave of BARCH", $COLOR_BLUE)
		 AttackTHGrid($eBarb,4,2,200,2,4,0) ; deploys 8 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eArch,2,5,2000,2,4,0) ; deploys 10 archers and waits 2 seconds
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eBarb,4,2,200,2,4,0) ; deploys 8 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eArch,4,3,22000,2,4,0) ; deploys 12 archers and wait additional 22sec

		;check for one star
         $count = 0
         While $count < 10
         If _Sleep(1000) Then Return
		If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
     	SetLog("Townhall has been destroyed!")
     	If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
    	Return ;exit if you get a star
        EndIf
        $count+=1
        WEnd
        ;end check for one star

		 ;---3nd wave 17 secs (rather short interval until ALL IN) total 2 giants, 30 barbs, 57 archers
		 SetLog("Oh Shit! Seems like a trapped TH!", $COLOR_BLUE)
		 AttackTHGrid($eBarb,3,3,200,3,4,0) ; deploys 9 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eGiant,2,1,200,3,4,0) ; deploys 2 giants as meat shield
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eArch,3,5,200,3,4,0) ; deploys 15 archers
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eBarb,3,3,200,3,4,0) ; deploys 9 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eArch,3,6,200,3,4,0) ; deploys 18 archers
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eBarb,4,3,200,3,4,0) ; deploys 12 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eArch,4,6,16000,3,4,0) ; deploys 24 archers and wait additional 16sec

		;check for one star
         $count = 0
         While $count < 10
         If _Sleep(1000) Then Return

         If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
     	SetLog("Townhall has been destroyed!")
     	If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
    	Return ;exit if you get a star
        EndIf
        $count+=1
        WEnd
        ;end check for one star

		 ;---4th wave 20 secs throw in everything
		 Setlog("Dammit! ALL IN!", $COLOR_BLUE)
		 AttackTHGrid($eArch,2,10,100,4,4,0) ; deploys 20 archers
		 ;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eGiant,3,10,100,4,4,0) ; deploys 30 giants
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star

		 AttackTHGrid($eGobl,2,10,100,4,4,0) ; deploys 20 goblins
;Check for one star
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then ;exit if 1 star
SetLog("Townhall has been destroyed!")
If _Sleep(1500) Then Return ;wait 1.5 seconds... antiban purpose...
Return ;exit if you get a star
EndIf
;end check for one star


		 AttackTHGrid($eWiza,2,10,100,4,4,0) ; deploys 20 wizards
		 AttackTHGrid($eMini,2,10,100,4,4,1) ; deploys 20 minions and Heroes
		 AttackTHGrid($eArch,2,10,100,4,4,1) ; deploys 20 archers and Heroes
		 AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
		 AttackTHGrid($eArch,2,10,100,4,4,0) ; deploys 20 archers
		 AttackTHGrid($eBarb,2,10,100,4,4,0) ; deploys 20 barbarians
		 AttackTHGrid($eArch,4,10,100,4,4,0) ; deploys 40 archers
		 AttackTHGrid($eBarb,4,10,100,4,4,0) ; deploys 40 barbarians
		 AttackTHGrid($eArch,4,10,60000,4,4,1) ; deploys 40 archers and Heroes (again just in case) and waits for a minute

	SetLog("All troops deployed and waiting for a star...", $COLOR_GREEN)

EndFunc   ;==>AttackTHSmartBarch