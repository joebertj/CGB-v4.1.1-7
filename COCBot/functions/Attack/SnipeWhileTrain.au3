; #FUNCTION# ====================================================================================================================
; Name ..........: SnipeWhileTrain
; Description ...: During the idle loop, if $chkSnipeWhileTrain is checked, the bot will to for pure TH snipe
;                  and return after 20 searches to profit from idle time.
;                  VillageSearch() was modified to break search after 20 loops.
;                  2 variables are used for this function.
;                  Global $chkSnipeWhileTrain, $isSnipeWhileTrain
;                  Local $tempSnipeWHileTrain[12]
; Syntax ........:
; Parameters ....: None
; Return values .: False if not enough troops (30%) True if 20 searches was successfully done.
; Author ........: ChiefM3
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func SnipeWhileTrain()

If GUICtrlRead($chkSnipeWhileTrain) = $GUI_CHECKED Then

  ; Attempt only when 30% army full to prevent failure of TH snipe
  If ($CurCamp <= ($TotalCamp * 30/100)) Then
  Return False
  EndIf

 If Not($fullArmy) And Not($CurCamp >= ($TotalCamp * $fulltroop * 90/100)) Then

  ; Swap variables to pure TH snipe mode
  $tempSnipeWhileTrain[0] = $iChkMeetTrophy[$DB]
  $tempSnipeWhileTrain[1] = $iChkMeetTrophy[$LB]
  $tempSnipeWhileTrain[2] = $iMinTrophy[$DB]
  $tempSnipeWhileTrain[3] = $iMinTrophy[$LB]
  $tempSnipeWhileTrain[4] = $iChkMeetOne[$LB]
  $tempSnipeWhileTrain[5] = $iChkMeetOne[$DB]
  $tempSnipeWhileTrain[6] = $OptTrophyMode
  $tempSnipeWhileTrain[7] = $THaddtiles
  ;change valuse to snipe while train
  $iChkMeetTrophy[$DB]=1
  $iChkMeetTrophy[$LB]=1
  $iMinTrophy[$DB]=1000
  $iMinTrophy[$LB]=1000
  $iChkMeetOne[$LB]=0
  $iChkMeetOne[$DB]=0
  $OptTrophyMode=1
  $THaddtiles=0

  ;used to revert values
$DidntRevert=1

  ; go to search for 20 times
  SetLog("Trying TH snipe while training army", $COLOR_RED)
  $isSnipeWhileTrain = True
  $Is_ClientSyncError = False
  AttackMain()
  $Restart = False ; Sets $Restart as True to end search after 10 attempts
  $Is_ClientSyncError = False
  $isSnipeWhileTrain = False
  SetLog("End trying TH snipe while training army", $COLOR_RED)

  SWHTrainRevertNormal()

  Return True
EndIf
EndIf
EndFunc

Func SWHTrainRevertNormal()
If 	$DidntRevert=1 Then
; revert settings back to normal
$iChkMeetTrophy[$DB] = $tempSnipeWhileTrain[0]
$iChkMeetTrophy[$LB] = $tempSnipeWhileTrain[1]
$iMinTrophy[$DB]     = $tempSnipeWhileTrain[2]
$iMinTrophy[$LB]     = $tempSnipeWhileTrain[3]
$iChkMeetOne[$LB]    = $tempSnipeWhileTrain[4]
$iChkMeetOne[$DB]    = $tempSnipeWhileTrain[5]
$OptTrophyMode       = $tempSnipeWhileTrain[6]
$THaddtiles          = $tempSnipeWhileTrain[7]
EndIf
$DidntRevert=0
EndFunc