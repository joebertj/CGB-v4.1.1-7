Func AttackTHDragon()
SetLog($thinfo)
Setlog("Sending some troops.")
AttackTHGrid($eDrag,1,1,500,1,1,0) ;releases 1 dragons

$count = 0
While $count < 25
 If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd

Setlog("No star yet? More troops needed.")
AttackTHGrid($eDrag,1,1,500,1,1,0) ;releases 1 dragons
$count = 0
While $count < 25
If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd

Setlog("No star yet? Even more trops.")
AttackTHGrid($eDrag,3,1,500,1,1,0) ;releases 2 dragons
$count = 0
While $count < 25
If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd

Setlog("I smell a trap! Let's send more troops...")
;AttackTHGrid($eDrag,3,1,500,1,1,0) ;releases 2 dragons
AttackTHGrid($eDrag,1,1,500,1,1,0) ;releases 1 dragons
AttackTHGrid($eDrag,1,1,500,1,1,1) ;releases 1 dragons and releases hero
$count = 0
While $count < 25
If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd

Setlog("Definetly a trap!")
AttackTHGrid($eDrag,3,1,500,1,1,0) ;releases 2 dragons

$count = 0
While $count < 25
If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd

Setlog("Ok, this is getting serious, saved the best for last!")
AttackTHGrid($eDrag,3,1,500,1,1,0) ;releases 3 dragons

$count = 0
While $count < 25
If _Sleep($iDelayAttackTHDragon1) Then Return
;_CaptureRegion()
If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
SetLog("Townhall has been destroyed!")
Return ;exit if you get a star
EndIf
$count+=1
WEnd
SetLog("~Finished Attacking, waiting to finish", $COLOR_GREEN)
EndFunc ;===>AttackTHDragons