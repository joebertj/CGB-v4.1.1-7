
; #FUNCTION# ====================================================================================================================
 ; Name ..........: checkTownhall
 ; Description ...: This file Includes the Variables and functions to detection the level of a TH
 ; Syntax ........: checkTownhall()
 ; Parameters ....: None
 ; Return values .: $THx, $THy
 ; Author ........: Barracoda
 ; Modified ......: ezeck0001 Then By The Master
 ; Remarks .......: This file is part of ClashGameBot. Copyright 2015
 ;                  ClashGameBot is distributed under the terms of the GNU GPL
 ; Related .......:
 ; Link ..........:
 ; Example .......: No
 ; ===============================================================================================================================

; Global $atkTHADV[5][30][4] = (sample image file location, tolerance , offset x, offset y ); Offet used to move THx and THy to
;   																						; fixed location to add accuracy to tile gap
;																							; in TH sniping
Global $debugTH = 0 ; use this to add info to the log, 0 is off, 1 is on
Global $ci,$ct ;carry values of for next loop into the find second image to confirm
Global $thinfo ; used to post info to setlog of found image numbers
Global $atkTHADV[5][30][4] = _
[ _
[ _
[@ScriptDir & "\images\TH\6.bmp", 75, 0, 0], _							;0    TH 4-6's
[@ScriptDir & "\images\TH\th6_vlt1.png",4, 0, 0], _						;01
[@ScriptDir & "\images\TH\th6_lt1.png", 4, 0, 0], _						;02
[@ScriptDir & "\images\TH\th6btm_vlt1.png", 4, 0, 0], _					;03
[@ScriptDir & "\images\TH\th6btm_vlt2.png", 4, 0, 0], _					;04
[@ScriptDir & "\images\TH\th6btm_vlt3.png", 4, 0, 0], _					;05
[@ScriptDir & "\images\TH\th6top_vlt1.png", 4, 0, 0], _					;06
[@ScriptDir & "\images\TH\th6top_vlt2.png", 4, 0, 0], _					;07
[@ScriptDir & "\images\TH\th6top_mt1.png", 4, 0, 0], _					;08
[@ScriptDir & "\images\TH\th6top_mt2.png", 4, 0, 0], _					;09
[@ScriptDir & "\images\TH\th6top_lt1.png", 4, 0, 0], _					;010
[@ScriptDir & "\images\TH\th6top_lt2.png", 4, 0, 0], _					;011
[@ScriptDir & "\images\TH\th6top_lt3.png", 4, 0, 0], _					;012
[@ScriptDir & "\images\TH\th6top_lt4.png", 4, 0, 0], _					;013
[@ScriptDir & "\images\TH\th6top_mt3.png", 4, 0, 0], _					;014
[@ScriptDir & "\images\TH\th6top_lt5.png", 4, 0, 0], _					;015
[@ScriptDir & "\images\TH\th6btm_lt1.png", 4, 0, 0], _					;016
[@ScriptDir & "\images\TH\th6top_ht1.png", 40, 0, 0], _					;017
[@ScriptDir & "\images\TH\th6top_ht2.png", 40, 0, 0], _					;018
[@ScriptDir & "\images\TH\th6mid_ht1.png", 40, 0, 0], _					;019
[0, 0, 0, 0], _															;020
[0, 0, 0, 0], _															;021
[0, 0, 0, 0], _															;022
[0, 0, 0, 0], _															;023
[0, 0, 0, 0], _															;024
[0, 0, 0, 0], _															;025
[0, 0, 0, 0], _															;026
[0, 0, 0, 0], _															;027
[0, 0, 0, 0], _															;028
[0, 0, 0, 0] _															;029
], _
[ _
[@ScriptDir & "\images\TH\7.bmp", 75, -1, 19], _							;0    TH 7's
[@ScriptDir & "\images\TH\th7b.bmp", 75, -1, 17], _							;1
[@ScriptDir & "\images\TH\Th7_1.png", 75, 8, 17], _		;Good 75			;2
[@ScriptDir & "\images\TH\Th7_2.png", 75, -9, 22], _ 	;Good 75			;3
[@ScriptDir & "\images\TH\Th7_3.png", 75, 5, 28], _ 	;Good 75			;4
[@ScriptDir & "\images\TH\Th7_4.bmp", 75, 6, 18], _		;Good 75			;5
[@ScriptDir & "\images\TH\Th7_5.bmp", 75, 1, 0], _ 		;Good 75			;6
[@ScriptDir & "\images\TH\th7c.bmp", 73, 8, 23], _							;7
[@ScriptDir & "\images\TH\th7d.bmp", 75, 0, 20], _							;8
[@ScriptDir & "\images\TH\th7e.bmp", 75, -1, 18], _							;9
[@ScriptDir & "\images\TH\th7f.bmp", 75, 9, 22], _							;10
[@ScriptDir & "\images\TH\th7i.bmp", 75, -3, 18], _							;11
[@ScriptDir & "\images\TH\th7new.bmp", 91, -1, 28], _						;12
[@ScriptDir & "\images\TH\TH7new1.bmp", 91, 8, 20], _						;13
[@ScriptDir & "\images\TH\th7l.bmp", 75, 6, 26], _							;14
[@ScriptDir & "\images\TH\th7mid_lt1.png", 45, 15, 19], _					;15
[@ScriptDir & "\images\TH\th8btm.png", 8, -1, -3], _						;16 (8-9); ids as TH 7
[@ScriptDir & "\images\TH\th8btm3.png", 4, 1, -2], _						;17 (8-10) ; ids as TH7
[@ScriptDir & "\images\TH\7.bmp", 75, -1, 19], _							;18
[@ScriptDir & "\images\TH\th7g.bmp", 75, -1, 17], _							;19
[@ScriptDir & "\images\TH\th7btm.png", 40, -3, 3], _						;20
[@ScriptDir & "\images\TH\th7b.bmp", 75, 0, 17], _							;21
[@ScriptDir & "\images\TH\th7h.bmp", 75, 1, 17], _							;22
[@ScriptDir & "\images\TH\th7top.png", 15, 6, 35], _						;23
[@ScriptDir & "\images\TH\th7top_mt1.png", 50, -1, 34], _					;24
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th7k.bmp", 120, 0, 0], _	;25
[0, 0, 0, 0], _															;26
[0, 0, 0, 0], _															;27
[0, 0, 0, 0], _															;28
[0, 0, 0, 0] _															;29
], _
[ _
[@ScriptDir & "\images\TH\8.bmp", 75, -1, 20], _							;0    TH 8's
[@ScriptDir & "\images\TH\th8b.bmp", 70, 1, 16], _							;1
[@ScriptDir & "\images\TH\Th8_1.png", 75, -1, 31], _	;Good 75			;2
[@ScriptDir & "\images\TH\th8_2.png", 75, 12, 20], _	;Good 75			;3
[@ScriptDir & "\images\TH\Th8_3.png", 75, 9, 1], _		;Good 75			;4
[@ScriptDir & "\images\TH\Th8_4.bmp", 75, 1, -2], _ 	;Good 75			;5
[@ScriptDir & "\images\TH\Th8_6.bmp", 70, -1, 36], _	;Good 70			;6
[@ScriptDir & "\images\TH\Th8_5.bmp", 75, 7, 17], _		;Good 75			;7
[@ScriptDir & "\images\TH\th8c.bmp", 70, -1, 26], _							;8
[@ScriptDir & "\images\TH\th8d.bmp", 70, 0, 14], _							;9
[@ScriptDir & "\images\TH\th8top_mt.png", 10, 6, 34], _						;10
[@ScriptDir & "\images\TH\th8top.png", 4, 12, 30], _						;11
[@ScriptDir & "\images\TH\th8new.bmp", 35, -1, 30], _						;12
[@ScriptDir & "\images\TH\th8btm2.png", 10, 6, 12], _						;13
[@ScriptDir & "\images\TH\th8mid_ht1.png", 50, 0, 0], _					;14
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8e.bmp", 120, 0, 0], _	;15
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8f.bmp", 120, 0, 0], _	;16
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8g.bmp", 120, 0, 0], _	;17
[0, 0, 0, 0], _															;18
[0, 0, 0, 0], _															;19
[0, 0, 0, 0], _															;020
[0, 0, 0, 0], _															;021
[0, 0, 0, 0], _															;022
[0, 0, 0, 0], _															;023
[0, 0, 0, 0], _															;024
[0, 0, 0, 0], _															;025
[0, 0, 0, 0], _															;026
[0, 0, 0, 0], _															;027
[0, 0, 0, 0], _															;028
[0, 0, 0, 0] _															;029
], _
[ _
[@ScriptDir & "\images\TH\9.bmp", 75, 0, 14], _								;0    TH 9's
[@ScriptDir & "\images\TH\th9b.bmp", 70, 0, 14], _							;01
[@ScriptDir & "\images\TH\Th9_1.png", 70, -1, 36], _	;Good 70			;2
[@ScriptDir & "\images\TH\Th9_2.png", 75, -2, 11], _	;Good 75			;3
[@ScriptDir & "\images\TH\Th9_3.png", 75, 16, 24], _	;Good 75			;4
[@ScriptDir & "\images\TH\Th9_4.png", 75, -1, 35], _	;Good 75			;5
[@ScriptDir & "\images\TH\Th9_5.png", 75, 1, 38], _		;Good 75			;6
[@ScriptDir & "\images\TH\Th9_6.png", 75, 14, 7], _ 	;Good 75			;7
[@ScriptDir & "\images\TH\Th9_7.bmp", 75, -1, 13], _	;Good 75			;8
[@ScriptDir & "\images\TH\Th9_8.bmp", 75, 2, -5], _		;Good 75			;9
[@ScriptDir & "\images\TH\Th9_9.bmp", 75, -22, 11], _	;Good 75			;10
[@ScriptDir & "\images\TH\Th9_10.bmp", 75, -15, 23], _	;Good 75			;11
[@ScriptDir & "\images\TH\Th9_11.png", 70, -13, 14], _	;Good 70			;12
[@ScriptDir & "\images\TH\Th9_12.png", 70, 2, 28], _	;Good 70			;13
[@ScriptDir & "\images\TH\th9c.bmp", 70, 2, 32], _							;14
[@ScriptDir & "\images\TH\th9d.bmp", 70, 0, 17], _							;15
[@ScriptDir & "\images\TH\th9e.bmp", 70, -1, 16], _							;16
[@ScriptDir & "\images\TH\th9f.bmp", 70, 1, 29], _							;17
[@ScriptDir & "\images\TH\th9h.bmp", 70, 2, 31], _							;18
[@ScriptDir & "\images\TH\th9btm_lt.png", 8, -1, -6], _						;19
[@ScriptDir & "\images\TH\th9btm_lt2.png", 8, 0, 1], _						;20
[@ScriptDir & "\images\TH\th9btm_mt.png", 10, 7, 0], _						;21
[@ScriptDir & "\images\TH\th9top_mt.png", 10, 0, 37], _						;22
[@ScriptDir & "\images\TH\th9top_0t.png", 5, -1, 37], _						;23
[@ScriptDir & "\images\TH\Th9_13.png", 70, 0, 0], _		;Good 70			;24  ;;no hits
[@ScriptDir & "\images\TH\th9g.bmp", 70, -1, 15], _							;25
["*Trans0xED1C24 "& @ScriptDir & "\images\TH\th9i.bmp", 120, 0, 0], _		;26
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9j.bmp", 120, 0, 0], _		;27
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9k.bmp", 120, 0, 0], _		;28
[0, 0, 0, 0] _																;29
], _
[ _
[@ScriptDir & "\images\TH\10.bmp", 70, -6, 19], _							;0    TH 10's
[@ScriptDir & "\images\TH\th10b.bmp", 70, -1, 12], _						;1
[@ScriptDir & "\images\TH\Th10_2.png", 75, -21, 12], _		;Good 75		;2
[@ScriptDir & "\images\TH\Th10_4.bmp", 70, 6, 18], _		;Good 70		;3
[@ScriptDir & "\images\TH\Th10_5.png", 75, 6, 19], _		;Good 75		;4
[@ScriptDir & "\images\TH\th10c.bmp", 70, -1, 26], _						;5
[@ScriptDir & "\images\TH\th10d.bmp", 70, 3, 34], _							;6
[@ScriptDir & "\images\TH\th10top_lt.png", 10, 5, 42], _					;7
[@ScriptDir & "\images\TH\th10g.bmp", 70, 4, 29], _							;8
[@ScriptDir & "\images\TH\th10h.bmp", 70, 3, 24], _							;9
[@ScriptDir & "\images\TH\th10btm_ht.png", 15, -1, -1], _					;10
[@ScriptDir & "\images\TH\th10btm.png", 10, 0, 2], _						;11
[@ScriptDir & "\images\TH\th10top_mt.png", 12, -2, 41], _					;12
[@ScriptDir & "\images\TH\th10top_mt2.png", 12, -1, 41], _					;13
[@ScriptDir & "\images\TH\Th10_1.png", 75, -2, 6], _		;Good 75		;14
[@ScriptDir & "\images\TH\Th10_3.png", 75, -21, 11], _		;Good 75		;15
[@ScriptDir & "\images\TH\th10e.bmpx",  70, 0, 0], _;false positives	;16  ;;no hits
[@ScriptDir & "\images\TH\th10f.bmp", 70, 19, 21], _						;17
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10i.bmp", 120, 0, 0], _		;18
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10j.bmp", 120, 0, 0], _		;19
["*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10k.bmp", 120, 0, 0], _		;20
[0, 0, 0, 0], _															;021
[0, 0, 0, 0], _															;022
[0, 0, 0, 0], _															;023
[0, 0, 0, 0], _															;024
[0, 0, 0, 0], _															;025
[0, 0, 0, 0], _															;026
[0, 0, 0, 0], _															;027
[0, 0, 0, 0], _															;028
[0, 0, 0, 0] _															;029
] _
]

 Func   checkTownhall()

	Local $bTHx = -1
	Local $bTHy = -1
	_CaptureRegion()

	For $t=4 to 0 step -1
		 For $i = 0 To 29
			   If FileExists($atkTHADV[$t][$i][0]) Then
					 $THLocation = _ImageSearch($atkTHADV[$t][$i][0], 1, $THx, $THy, $atkTHADV[$t][$i][1]) ; Getting TH Location
					 If FilterTH()=True Then
					  If $THLocation = 1 and $t >= 1 Then ; add this 'And $OptTrophyMode = 1 ' to used two factor only throphie mode
					     $bTHx = $t
					     $bTHy = $i
					     $ct=$t
					     $ci=$i
					     if $debugTH = 1 then
					     Setlog("found image First "&$t&" ,"&$i&"   "&$THx&", "&$THy)
					     Endif

					     ConfirmTHadv()
					  EndIf
					   If $THLocation = 1 Then

						;apply offsets
						$THx += $atkTHADV[$t][$i][2]
						$THy += $atkTHADV[$t][$i][3]

						$thinfo =" Image adv " &$t& " , " &$i& " Tol: " &$atkTHADV[$t][$i][0]& " - Coords:" &$THx& " , " &$THy
						If FilterTH()=True Then Return $THText[$t]
						EndIf
					  Endif
			   EndIf
		 Next
	      Next
;  Second try
If $THLocation = 0 And $bTHy <> -1 And $bTHx <> -1 Then
   if $debugTH = 1 then
   Setlog(" \/ Second Try \/ ",$COLOR_GREEN)
   Endif
_CaptureRegion()
	    For $t=4 to 0 Step -1
		 For $i = 0 To 29
			   If FileExists($atkTHADV[$t][$i][0]) Then
				       $THLocation = _ImageSearch($atkTHADV[$t][$i][0], 1, $THx, $THy, $atkTHADV[$t][$i][1]) ; Getting TH Location
				    If FilterTH()=True Then
						If $THLocation = 1  And  $bTHx = $t  and $bTHy = $i Then
							$THLocation = 0
						Endif
				       If $THLocation =1 then
							if $debugTH = 1 then
								Setlog("found image 2nd attemp "&$t&" ,"&$i&"   "&$THx&", "&$THy)
							Endif
					     $ct=$t
					     $ci=$i
					     ConfirmTHadv()
				       Endif
					  If $THLocation = 1 Then

						;apply offsets
						$THx += $atkTHADV[$t][$i][2]
						$THy += $atkTHADV[$t][$i][3]

						$thinfo =" Image adv " &$ct& " , " &$ci& " Tol: " &$atkTHADV[$ct][$ci][0]& " - Coords:" &$THx& " , " &$THy
						If FilterTH()=True Then Return $THText[$t]
						EndIf
					EndIf
			   EndIf
		 Next
	      Next
     ; Endif
   Endif
   If $THLocation = 0 Then Return "-"
EndFunc ;==>checkTownhall

Func ConfirmTHadv()
Local $CTHx=0, $CTHy=0
		     For $z = 29 To 0 Step -1
			If $z <> $ci then
			   If FileExists($atkTHADV[$ct][$z][0]) Then
			      $CTHx=0
			      $CTHy=0
					 $THLocation = _ImageSearch($atkTHADV[$ct][$z][0], 1, $CTHx, $CTHy, $atkTHADV[$ct][$z][1]) ; Getting TH Location
					     If $debugTH = 1 then
						Setlog("found image to compare "&$ct&" ,"&$z&"   "&$CTHx&", "&$CTHy&"$THLocation ="&$THLocation)
					     Endif
						   If $THLocation = 1 Then
							 If $CTHx < ($THx -50) or $CTHx > ($THx + 50) or $CTHy < ($THy -50) or $CTHy > ($THy + 50) Then
						      $THLocation = 0
						      Endif
						   Endif

						    If $THLocation = 1 then
						       if $debugTH = 1 then
									Setlog("\/  adv  Town Hall Confirmed with 2nd image \/"&$ct&" ,"&$z, $COLOR_GREEN)
							   Endif
						    $z = -1
						   EndIf
				 Endif
				Endif
			   Next
 If $THLocation = 0 and $debugTH = 1 then
		Setlog("\/  adv  Town Hall image not Confirmed \/", $COLOR_RED)
Endif
return
EndFunc ;<=== ConfirmTHadv()





