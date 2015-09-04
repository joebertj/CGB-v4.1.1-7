;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Window Toolbox Control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;;; Controls Global
;;;;;;;;;;;;;;;;;;;;;;
Global $ToolboxModeBot        = False
Global $ToolboxModeSearch    = False
Global $ToolboxModeWar         = False
Global $ToolboxActive         = False
Global $ToolBoxHotkeys        = False
Global $ToolboxDetached        = False
Global $ToolboxSavePos        = False
Global $Toolbox_x             = $iToolbox_x
Global $Toolbox_y             = $iToolbox_y

If GUICtrlRead($chkToolboxSavePos) = $GUI_UNCHECKED Then
    Local $winPos = WinGetPos ($sBotTitle)
    $Toolbox_x = $winPos[0]
    $Toolbox_y = $winPos[1]
EndIf

;;;;;;;;;;;;;;;;;;
;;; GUI helpers
;;;;;;;;;;;;;;;;;;

AdlibRegister("ToolBoxModeSearchTimer", 5000)

Func ToolBoxModeSearchTimer()
    If $ToolboxHotkeys And Not $ToolboxModeWar And _
            ((_CheckPixel($aEndFightSceneBtn, True) Or _CheckPixel($aEndFightSceneAvl, True)) Or _CheckPixel($aIsMain, True)) Then
        _GUI_Toolbox_Deactivate()
        _GUI_Toolbox_Hide()
    EndIf
EndFunc

Func WipeToolboxLog()
    _GUICtrlRichEdit_SetText($txtToolbox_Win_Log, "")
    _GUICtrlRichEdit_SetText($txtToolbox_GUI_Log, "")
EndFunc

Func SetToolboxLog($String, $Color = $COLOR_BLACK, $Time = True, $Font = "Consolas", $FontSize = 8)
    _GUICtrlRichEdit_SetFont($txtToolbox_Win_Log, $FontSize, $Font)
    _GUICtrlRichEdit_SetFont($txtToolbox_GUI_Log, $FontSize, $Font)
    _GUICtrlRichEdit_AppendText($txtToolbox_Win_Log, @CRLF)
    _GUICtrlRichEdit_AppendText($txtToolbox_GUI_Log, @CRLF)
    If $Time Then
        _GUICtrlRichEdit_AppendTextColor($txtToolbox_Win_Log, "[" & _NowTime(5) & "] ", 0x000000)
        _GUICtrlRichEdit_AppendTextColor($txtToolbox_GUI_Log, "[" & _NowTime(5) & "] ", 0x000000)
    EndIf
    _GUICtrlRichEdit_AppendTextColor($txtToolbox_Win_Log, $String, _ColorConvert($Color))
    _GUICtrlRichEdit_AppendTextColor($txtToolbox_GUI_Log, $String, _ColorConvert($Color))
EndFunc

Func _GUI_Toolbox_Show()
    $ToolboxActive = True
    _GUI_Toolbox_Set()
    If $ToolboxDetached Then
        _GUI_Toolbox_Win_Show()
    Else
        _GUI_Toolbox_GUI_Show()
    EndIf

EndFunc

Func _GUI_Toolbox_Hide()
    $ToolboxActive = False
    _GUI_Toolbox_Unset()
    If $ToolboxDetached Then
        _GUI_Toolbox_Win_Hide()
    Else
        _GUI_Toolbox_GUI_Hide()
    EndIf
EndFunc

Func _GUI_Toolbox_Win_Show()
    If $ToolboxSavePos = $GUI_CHECKED Then
        WinMove($sToolboxTitle, "", $Toolbox_x, $Toolbox_y)
    Else
        Local $winPos = WinGetPos ($sBotTitle)
        WinMove($sToolboxTitle, "", $winPos[0], $winPos[1])
    EndIf
    GUISetState(@SW_SHOW, $winToolbox)
EndFunc

Func _GUI_Toolbox_GUI_Show()
    GUICtrlSetState($picBotLogo, $GUI_HIDE)
    ControlShow($frmBot, "", $txtToolbox_GUI_Log)
    GUICtrlSetState($grpToolbox_GUI_Controls, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_HKStatus, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_Red, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_Yellow, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_Green, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_Dismiss, $GUI_SHOW)
    GUICtrlSetState($btnToolbox_GUI_Detach, $GUI_SHOW)
EndFunc

Func _GUI_Toolbox_Win_Hide()
    Local $winPos = []
    If $ToolboxSavePos Then
        $winPos = WinGetPos ($sToolboxTitle)
    Else
        $winPos = WinGetPos ($sBotTitle)
    EndIf
    $Toolbox_x = $winPos[0]
    $Toolbox_y = $winPos[1]

    GUISetState(@SW_HIDE, $winToolbox)
EndFunc

Func _GUI_Toolbox_GUI_Hide()
    GUICtrlSetState($picBotLogo, $GUI_SHOW)
    ControlHide($frmBot, "", $txtToolbox_GUI_Log)
    GUICtrlSetState($grpToolbox_GUI_Controls, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_HKStatus, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_Red, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_Yellow, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_Green, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_Dismiss, $GUI_HIDE)
    GUICtrlSetState($btnToolbox_GUI_Detach, $GUI_HIDE)
EndFunc

Func _GUI_Toolbox_Set()
    WipeToolboxLog()
    _GUICtrlRichEdit_AppendText($txtToolbox_Win_Log," Toolbox Log")
    _GUICtrlRichEdit_AppendText($txtToolbox_GUI_Log," Toolbox Log")
    If $ToolboxModeWar Then
        SetLog(" [Toolbox]: Active.", $COLOR_RED)
        SetLog("    [ War Mode ]: Hotkeys Inactive.", $COLOR_RED)
        GUICtrlSetState($chkToolboxModeBot, $GUI_DISABLE)
        GUICtrlSetState($chkToolboxModeSearch, $GUI_DISABLE)
        SetToolboxLog("    [ War Mode ]", $COLOR_RED, False)
        SetToolboxLog(" == Hotkeys Inactive", $COLOR_RED)
        GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_LIT)
        GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_Win_HKStatus, "Hotkeys" & @CRLF & "Inactive")
        GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_LIT)
        GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_GUI_HKStatus, "Hotkeys" & @CRLF & "Inactive")
    Else
        SetLog(" [Toolbox]: Active. Hotkeys On Hold.", $COLOR_RED)
        SetToolboxLog(" == Hotkeys On Hold", $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_LIT)
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_Win_HKStatus, "Hotkeys" & @CRLF & "On Hold")
        GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_LIT)
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_GUI_HKStatus, "Hotkeys" & @CRLF & "On Hold")
    EndIf
    _Toolbox_Hotkeys_Off()
EndFunc

Func _GUI_Toolbox_Unset()
    If $ToolboxModeWar Then
        SetLog("[Toolbox]: Dismissed. Hotkeys Inactive", $COLOR_RED)
        GUICtrlSetState($chkToolboxModeBot, $GUI_ENABLE)
        GUICtrlSetState($chkToolboxModeSearch, $GUI_ENABLE)
    Else
        SetLog("[Toolbox]: Dismissed. Hotkeys On Hold", $COLOR_RED)
    EndIf
    _Toolbox_Hotkeys_Off()
EndFunc

Func _GUI_Toolbox_Activate()
    If Not $ToolboxModeWar Then
        SetLog("[Toolbox]: Hotkeys Activated", $COLOR_GREEN)
        GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_LIT)
        _GUICtrlButton_SetText($btnToolbox_Win_Status, "Hotkeys" & @CRLF & "Active")
        GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_LIT)
        _GUICtrlButton_SetText($btnToolbox_GUI_Status, "Hotkeys" & @CRLF & "Active")
        SetToolboxLog(" == Hotkeys Active", $COLOR_GREEN)
        _Toolbox_Hotkeys_On()
    EndIf
EndFunc

Func _GUI_Toolbox_Deactivate()
    If Not $ToolboxModeWar Then
        SetLog("[Toolbox]: Hotkeys Deactivated", $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_LIT)
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_Win_Status, "Hotkeys" & @CRLF & "On Hold")
        GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_LIT)
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_GUI_Status, "Hotkeys" & @CRLF & "On Hold")
        SetToolboxLog(" == Hotkeys On Hold", $COLOR_YELLOW_OFF)
        _Toolbox_Hotkeys_Off()
    EndIf
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;
;;; Toolbox controls
;;;;;;;;;;;;;;;;;;;;;;;
Func btnToolboxStatus()
    If $ToolboxHotkeys Then
        If $ToolboxModeWar Then
            GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_LIT)
            GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_OFF)
            GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_LIT)
            GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_OFF)
        Else
            GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_OFF)
            GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_LIT)
            GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_OFF)
            GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_LIT)
        EndIf
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_Win_HKStatus, "Hotkeys" & @CRLF & "Inactive")
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_OFF)
        _GUICtrlButton_SetText($btnToolbox_GUI_HKStatus, "Hotkeys" & @CRLF & "Inactive")
        SetToolboxLog(" == Hotkeys Inactive", $COLOR_RED)
        _Toolbox_Hotkeys_Off()
    Else
        GUICtrlSetBkColor($btnToolbox_Win_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_Win_Green, $COLOR_GREEN_LIT)
        _GUICtrlButton_SetText($btnToolbox_Win_HKStatus, "Hotkeys" & @CRLF & "Active")
        GUICtrlSetBkColor($btnToolbox_GUI_Red, $COLOR_RED_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Yellow, $COLOR_YELLOW_OFF)
        GUICtrlSetBkColor($btnToolbox_GUI_Green, $COLOR_GREEN_LIT)
        _GUICtrlButton_SetText($btnToolbox_GUI_HKStatus, "Hotkeys" & @CRLF & "Active")
        SetToolboxLog(" == Hotkeys Active", $COLOR_GREEN)
        _Toolbox_Hotkeys_On()
    EndIf
EndFunc

Func btnToolboxDismiss()
    _GUI_Toolbox_Hide()
    If $ToolboxModeWar Then
        GUICtrlSetState($chkToolboxModeWar, $GUI_UNCHECKED)
        GUICtrlSetState($chkToolboxModeBot, $GUI_ENABLE)
        GUICtrlSetState($chkToolboxModeSearch, $GUI_ENABLE)
        $ToolboxModeBot    = (GUICtrlRead($chkToolboxModeBot) = $GUI_CHECKED)
        $ToolboxModeSearch = (GUICtrlRead($chkToolboxModeSearch) = $GUI_CHECKED)
    EndIf
EndFunc

Func btnToolbox_GUI_Detach()
    GUICtrlSetState($chkToolboxDetach, $GUI_CHECKED)
    chkToolboxDetach()
EndFunc

Func btnToolbox_Win_Attach()
    GUICtrlSetState($chkToolboxDetach, $GUI_UNCHECKED)
    chkToolboxDetach()
EndFunc

;;;;;;;;;;;;;;;;;;;;
;;; Toolbox Utils
;;;;;;;;;;;;;;;;;;;;
Func _Toolbox_Hotkeys_On()
    $ToolboxHotkeys = True
    HotKeySet("{1}", "Slot_1")
    HotKeySet("{2}", "Slot_2")
    HotKeySet("{3}", "Slot_3")
    HotKeySet("{4}", "Slot_4")
    HotKeySet("{5}", "Slot_5")
    HotKeySet("{6}", "Slot_6")
    HotKeySet("{7}", "Slot_7")
    HotKeySet("{8}", "Slot_8")
    HotKeySet("{9}", "Slot_9")
    HotKeySet("{0}", "Slot_0")
    HotKeySet("{-}", "Slot_11")
    HotKeySet("{q}", "Slot_q")
    HotKeySet("{w}", "Slot_w")
EndFunc

Func _Toolbox_Hotkeys_Off()
    $ToolboxHotkeys = False
    HotKeySet("{1}")
    HotKeySet("{2}")
    HotKeySet("{3}")
    HotKeySet("{4}")
    HotKeySet("{5}")
    HotKeySet("{6}")
    HotKeySet("{7}")
    HotKeySet("{8}")
    HotKeySet("{9}")
    HotKeySet("{0}")
    HotKeySet("{-}")
    HotKeySet("{q}")
    HotKeySet("{w}")
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Hotkeys functions
;;;;;;;;;;;;;;;;;;;;;;;;
; Troop Slot 1         70, 623
; Troop Slot 2        142, 623
; Troop Slot 3        214, 623
; Troop Slot 4        286, 623
; Troop Slot 5        359, 623
; Troop Slot 6        431, 623
; Troop Slot 7        503, 623
; Troop Slot 8        576, 623
; Troop Slot 9        648, 623
; Troop Slot 10     721, 623
; Troop Slot 11        793, 623

; DragRight            214, 623, 648, 623
; DragLeft            648, 623, 214, 623

; EndBattle          30, 524    (233, 85, 83)
; EndBattle         100, 524    (233, 85, 83)
; EndBattle          30, 546    (189,  0,  0)
; EndBattle         100, 546    (233,  0,  0)


Func Slot_1()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 1 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(70, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{1}")
        Send("{1}")
        HotKeySet("{1}", "Slot_1")
    EndIf
EndFunc   ;==>Slot_1

Func Slot_2()
    If WinActive($Title) or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 2 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(142, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{2}")
        Send("{2}")
        HotKeySet("{2}", "Slot_2")
    EndIf
EndFunc   ;==>Slot_2

Func Slot_3()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 3 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(214, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{3}")
        Send("{3}")
        HotKeySet("{3}", "Slot_3")
    EndIf
EndFunc   ;==>Slot_3

Func Slot_4()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 4 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(286, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{4}")
        Send("{4}")
        HotKeySet("{4}", "Slot_4")
    EndIf
EndFunc   ;==>Slot_4

Func Slot_5()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 5 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(359, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{5}")
        Send("{5}")
        HotKeySet("{5}", "Slot_5")
    EndIf
EndFunc   ;==>Slot_5

Func Slot_6()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 6 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(431, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{6}")
        Send("{6}")
        HotKeySet("{6}", "Slot_6")
    EndIf
EndFunc   ;==>Slot_6

Func Slot_7()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 7 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(503, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{7}")
        Send("{7}")
        HotKeySet("{7}", "Slot_7")
    EndIf
EndFunc   ;==>Slot_7

Func Slot_8()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 8 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(576, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{8}")
        Send("{8}")
        HotKeySet("{8}", "Slot_8")
    EndIf
EndFunc   ;==>Slot_8

Func Slot_9()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 9 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(648, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{9}")
        Send("{9}")
        HotKeySet("{9}", "Slot_9")
    EndIf
EndFunc   ;==>Slot_9

Func Slot_0()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 0 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(721, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{0}")
        Send("{0}")
        HotKeySet("{0}", "Slot_0")
    EndIf
EndFunc   ;==>Slot_0

Func Slot_11()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey 11 Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            Click(793, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{-}")
        Send("{-}")
        HotKeySet("{-}", "Slot_11")
    EndIf
EndFunc   ;==>Slot_11

Func Slot_q()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey q Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            _PostMessage_ClickDrag(214, 623, 648, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{q}")
        Send("{q}")
        HotKeySet("{q}", "Slot_q")
    EndIf
EndFunc   ;==>Slot_q

Func Slot_w()
    If WinActive($Title) Or WinActive($sBotTitle) Or WinActive($sToolboxTitle) Then
        SetToolboxLog("  -- HotKey w Pressed", $COLOR_ORANGE)
        If _CheckPixel($aSurrenderButton, True) Then
            _PostMessage_ClickDrag(648, 623, 214, 623)
        Else
            SetToolboxLog("Not in the Attack Screen!", $COLOR_RED)
        EndIf
    Else
        HotKeySet("{w}")
        Send("{w}")
        HotKeySet("{w}", "Slot_w")
    EndIf
EndFunc   ;==>Slot_w

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;