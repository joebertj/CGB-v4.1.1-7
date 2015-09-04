; #FUNCTION# ====================================================================================================================
; Name ..........: checkTownhall
; Description ...: This file Includes the Variables and functions to detection the level of a TH
; Syntax ........: checkTownhall()
; Parameters ....: None
; Return values .: $THx, $THy
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Global $atkTHADV[5][27], $thinfo

$atkTHADV[0][0] = @ScriptDir & "\images\TH\6.bmp"
$atkTHADV[0][1] = @ScriptDir & "\images\TH\th6_vlt1.png"
$atkTHADV[0][2] = @ScriptDir & "\images\TH\th6_lt1.png"
$atkTHADV[0][3] = @ScriptDir & "\images\TH\th6btm_vlt1.png"
$atkTHADV[0][4] = @ScriptDir & "\images\TH\th6btm_vlt2.png"
$atkTHADV[0][5] = @ScriptDir & "\images\TH\th6btm_vlt3.png"
$atkTHADV[0][6] = @ScriptDir & "\images\TH\th6top_vlt1.png"
$atkTHADV[0][7] = @ScriptDir & "\images\TH\th6top_vlt2.png"
$atkTHADV[0][8] = @ScriptDir & "\images\TH\th6top_mt1.png"
$atkTHADV[0][9] = @ScriptDir & "\images\TH\th6top_mt2.png"
$atkTHADV[0][10] = @ScriptDir & "\images\TH\th6top_lt1.png"
$atkTHADV[0][11] = @ScriptDir & "\images\TH\th6top_lt2.png"
$atkTHADV[0][12] = @ScriptDir & "\images\TH\th6top_lt3.png"
$atkTHADV[0][13] = @ScriptDir & "\images\TH\th6top_lt4.png"
$atkTHADV[0][14] = @ScriptDir & "\images\TH\th6top_mt3.png"
$atkTHADV[0][15] = @ScriptDir & "\images\TH\th6top_lt5.png"
$atkTHADV[0][16] = @ScriptDir & "\images\TH\th6btm_lt1.png"
$atkTHADV[0][17] = @ScriptDir & "\images\TH\th6top_ht1.png"
$atkTHADV[0][18] = @ScriptDir & "\images\TH\th6top_ht2.png"
$atkTHADV[0][19] = @ScriptDir & "\images\TH\th6mid_ht1.png"
$atkTHADV[0][20] = @ScriptDir & "\images\TH\th6_ht1.png"
$atkTHADV[0][21] = @ScriptDir & "\images\TH\th6_ht2.png"
$atkTHADV[0][22] = @ScriptDir & "\images\TH\th6_ht3.png"
$atkTHADV[0][23] = @ScriptDir & "\images\TH\th6_ht4.png"
$atkTHADV[0][24] = @ScriptDir & "\images\TH\th6_ht5.png"
$atkTHADV[0][25] = @ScriptDir & "\images\TH\th6_ht6.png"
$atkTHADV[0][26] = @ScriptDir & "\images\TH\th6_ht7.png"

$atkTHADV[1][0] = @ScriptDir & "\images\TH\7.bmp"
$atkTHADV[1][1] = @ScriptDir & "\images\TH\th7b.bmp"
$atkTHADV[1][2] = @ScriptDir & "\images\TH\th7c.bmp"
$atkTHADV[1][3] = @ScriptDir & "\images\TH\th7d.bmp"
$atkTHADV[1][4] = @ScriptDir & "\images\TH\th7e.bmp"
$atkTHADV[1][5] = @ScriptDir & "\images\TH\th7f.bmp"
$atkTHADV[1][6] = @ScriptDir & "\images\TH\th7g.bmp"
$atkTHADV[1][7] = @ScriptDir & "\images\TH\th7h.bmp"
$atkTHADV[1][8] = @ScriptDir & "\images\TH\th7i.bmp"
$atkTHADV[1][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th7j.bmp"
$atkTHADV[1][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th7k.bmp"
$atkTHADV[1][11] = @ScriptDir & "\images\TH\th7btm.png"
$atkTHADV[1][12] = @ScriptDir & "\images\TH\th7top.png"
$atkTHADV[1][13] = @ScriptDir & "\images\TH\th7top_mt1.png"
$atkTHADV[1][14] = @ScriptDir & "\images\TH\th7mid_lt1.png"
$atkTHADV[1][15] = @ScriptDir & "\images\TH\th7_ht1.png"
$atkTHADV[1][16] = @ScriptDir & "\images\TH\th7_ht2.png"
$atkTHADV[1][17] = @ScriptDir & "\images\TH\th7_ht3.png"
$atkTHADV[1][18] = @ScriptDir & "\images\TH\th7_ht4.png"
$atkTHADV[1][19] = @ScriptDir & "\images\TH\th7_ht5.png"
$atkTHADV[1][20] = @ScriptDir & "\images\TH\th7_ht6.png"
$atkTHADV[1][21] = @ScriptDir & "\images\TH\th7_ht8.png"

$atkTHADV[2][0] = @ScriptDir & "\images\TH\8.bmp"
$atkTHADV[2][1] = @ScriptDir & "\images\TH\th8b.bmp"
$atkTHADV[2][2] = @ScriptDir & "\images\TH\th8c.bmp"
$atkTHADV[2][3] = @ScriptDir & "\images\TH\th8d.bmp"
$atkTHADV[2][4] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8e.bmp"
$atkTHADV[2][5] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8f.bmp"
$atkTHADV[2][6] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th8g.bmp"
$atkTHADV[2][7] = @ScriptDir & "\images\TH\th8top.png"
$atkTHADV[2][8] = @ScriptDir & "\images\TH\th8btm.png"
$atkTHADV[2][9] = @ScriptDir & "\images\TH\th8btm2.png"
$atkTHADV[2][10] = @ScriptDir & "\images\TH\th8btm3.png"
$atkTHADV[2][11] = @ScriptDir & "\images\TH\th8top_mt.png"
$atkTHADV[2][12] = @ScriptDir & "\images\TH\th8mid_ht1.png"
$atkTHADV[2][13] = @ScriptDir & "\images\TH\th8_ht1.png"

$atkTHADV[3][0] = @ScriptDir & "\images\TH\9.bmp"
$atkTHADV[3][1] = @ScriptDir & "\images\TH\th9b.bmp"
$atkTHADV[3][2] = @ScriptDir & "\images\TH\th9c.bmp"
$atkTHADV[3][3] = @ScriptDir & "\images\TH\th9d.bmp"
$atkTHADV[3][4] = @ScriptDir & "\images\TH\th9e.bmp"
$atkTHADV[3][5] = @ScriptDir & "\images\TH\th9f.bmp"
$atkTHADV[3][6] = @ScriptDir & "\images\TH\th9g.bmp"
$atkTHADV[3][7] = @ScriptDir & "\images\TH\th9h.bmp"
$atkTHADV[3][8] = "*Trans0xED1C24 "& @ScriptDir & "\images\TH\th9i.bmp"
$atkTHADV[3][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9j.bmp"
$atkTHADV[3][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th9k.bmp"
$atkTHADV[3][11] = @ScriptDir & "\images\TH\th9btm_lt.png"
$atkTHADV[3][12] = @ScriptDir & "\images\TH\th9btm_lt2.png"
$atkTHADV[3][13] = @ScriptDir & "\images\TH\th9btm_mt.png"
$atkTHADV[3][14] = @ScriptDir & "\images\TH\th9top_mt.png"
$atkTHADV[3][15] = @ScriptDir & "\images\TH\th9top_0t.png"

$atkTHADV[4][0] = @ScriptDir & "\images\TH\10.bmp"
$atkTHADV[4][1] = @ScriptDir & "\images\TH\th10b.bmp"
$atkTHADV[4][2] = @ScriptDir & "\images\TH\th10c.bmp"
$atkTHADV[4][3] = @ScriptDir & "\images\TH\th10d.bmp"
$atkTHADV[4][4] = @ScriptDir & "\images\TH\th10e.bmpx" ;false positives
$atkTHADV[4][5] = @ScriptDir & "\images\TH\th10f.bmp"
$atkTHADV[4][6] = @ScriptDir & "\images\TH\th10g.bmp"
$atkTHADV[4][7] = @ScriptDir & "\images\TH\th10h.bmp"
$atkTHADV[4][8] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10i.bmp"
$atkTHADV[4][9] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10j.bmp"
$atkTHADV[4][10] = "*Trans0xED1C24 "&@ScriptDir & "\images\TH\th10k.bmp"
$atkTHADV[4][11] = @ScriptDir & "\images\TH\th10btm.png"
$atkTHADV[4][12] = @ScriptDir & "\images\TH\th10btm_ht.png"
$atkTHADV[4][13] = @ScriptDir & "\images\TH\th10top_mt.png"
$atkTHADV[4][14] = @ScriptDir & "\images\TH\th10top_mt2.png"
$atkTHADV[4][15] = @ScriptDir & "\images\TH\th10top_lt.png"

Global $atkTH[5]
For $i = 0 To 4
   $atkTH[$i] = @ScriptDir & "\images\TH\" & $i+6 & ".bmp"
Next

Local $Tolerance1[5] = [80, 80, 80, 80, 80]

Global $ToleranceTH[5][11]=[ [70,0,0,0,0,0,0,0,0,0,0],[70,70,70,70,70,70,70,70,70,120,120],[70,70,70,70,120,120,120,0,0,0,0],[70,70,70,70,70, 70,70,70,120,120, 120],[70,70,70,70,70, 70,70,70,120,120, 120] ]


Func checkTownhall()
	   _CaptureRegion()
	  For $i = 0 To 4
	   $THLocation = _ImageSearch($atkTH[$i], 1, $THx, $THy, $Tolerance1[$i]) ; Getting TH Location
	   If $THLocation = 1 Then
		   If FilterTH()=True Then Return $THText[$i]
	   EndIf
	  Next
   If $THLocation = 0 Then Return "-"
   EndFunc

Func checkTownhallADV()
	_CaptureRegion()
	For $t=0 to 4
		 For $i = 0 To 10
			   If FileExists($atkTHADV[$t][$i]) Then
					 $THLocation = _ImageSearch($atkTHADV[$t][$i], 1, $THx, $THy, $ToleranceTH[$t][$i]) ; Getting TH Location
					 If $THLocation = 1 Then
						   $thinfo = "Tol:"&$ToleranceTH[$t][$i]&" - Coords:"&$THx&","&$THy
						   If FilterTH()=True Then Return $THText[$t]
					 EndIf
			   EndIf
		 Next
	Next
   If $THLocation = 0 Then Return "-"
EndFunc
