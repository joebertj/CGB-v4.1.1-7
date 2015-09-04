#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here



Func KeepAlive()
	;$scriptID = "keepalive"

	;If _Singleton($scriptID, 1) = 0 Then
	;	MsgBox(0, "", "keepalive is already running")
	;	Exit
	;EndIf
	;While 1
		$mcoord = MouseGetPos()
		MouseMove($mcoord[0]+1,$mcoord[1])
		MouseMove($mcoord[0],$mcoord[1])
	;	_Sleep(1000)
	;	Send("{NUMLOCK on}")
	;	_Sleep(1000)
	;	Send("{NUMLOCK off}")
	;	_Sleep(60000)
	;WEnd
EndFunc


