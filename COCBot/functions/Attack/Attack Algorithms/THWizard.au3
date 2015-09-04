Func AttackTHWizard()
     SetLog($thinfo)
	 SetLog("Sending 2-6 Wizards.")
     AttackTHGrid($eWiza,2,1,1000,1,1,1) ; deploy 2 Wizards - for Taking Down All Traps
	 AttackTHGrid($eWiza,2,Random(2,4,1),1000,2,3,0) ; deploy 4-6 Wizards
	 $count = 0
	 While $count < 20
	 If _Sleep($iDelayAttackTHWizard1) Then Return
;	  _CaptureRegion()
	  If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
	    SetLog("Townhall has been destroyed!")
	  Return ;exit if you get a star
    EndIf
 $count+=1
WEnd

	 Setlog("Get 1 Star ? Sending Some 10 More Wizards.")
	 AttackTHGrid($eWiza,4,Random(1,3,1),1000,2,3,0) ; deploy 4 Wizards
	  AttackTHGrid($eWiza,4,Random(1,4,1),1000,2,3,0) ; deploy 4 Wizards
	  $count = 0
   While $count < 20
    If _Sleep($iDelayAttackTHWizard1) Then Return
;   _CaptureRegion()
   If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
	SetLog("Townhall has been destroyed!")
	Return ;exit if you get a star
 EndIf
 $count+=1
WEnd

	 Setlog("Still Cant Get 1 Star ? Sending Again 16 More Wizards.")
	 AttackTHGrid($eWiza,4,Random(2,3,1),1000,2,3,0) ; deploy 8-12 Wizards
	  AttackTHGrid($eWiza,4,Random(3,4,1),1000,2,3,0) ; deploy 12-16 Wizards
	  $count = 0
   While $count < 20
    If _Sleep($iDelayAttackTHWizard1) Then Return
;   _CaptureRegion()
   If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
	SetLog("Townhall has been destroyed!")
	Return ;exit if you get a star
 EndIf
 $count+=1
WEnd

    Setlog("Now i know i Need to Send All My Wizards.")
	AttackTHGrid($eWiza,4,4,1500,2,3,0) ; release Heroes/CC + 16 Wizards
	AttackTHGrid($eWiza,3,4,1000,2,3,0) ; release 12 Wizards
	AttackTHGrid($eWiza,5,4,1000,2,3,0) ; release 20 Wizards
	$count = 0
  While $count < 20
	  If _Sleep($iDelayAttackTHWizard1) Then Return
;     _CaptureRegion()
	  If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
	   SetLog("Townhall has been destroyed!")
	   Return ;exit if you get a star
    EndIf
    $count+=1
  WEnd
     SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)
EndFunc ;----AttackTHWizards