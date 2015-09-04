;~ -------------------------------------------------------------
;~ Toolbox Win
;~ -------------------------------------------------------------
#include <GuiButton.au3>

;;;;;;;;;;;;;
;;; Colors
;;;;;;;;;;;;;
Global $COLOR_RED_OFF         = 0xFF0000 - 0x900000
Global $COLOR_YELLOW_OFF     = 0xFFFF00 - 0x909000
Global $COLOR_GREEN_OFF     = $COLOR_GREEN

Global $COLOR_RED_LIT         = 0xFF0000 + 0x002020 ; 0xFF0000 + 0x003030
Global $COLOR_YELLOW_LIT     = 0xFFFF00 - 0x002000; 0xFF7700 + 0x003030
Global $COLOR_GREEN_LIT     = $COLOR_LIME ; $COLOR_GREEN + 0x303030

;;;;;;;;;;;;;;;;;;
;;; GUI Globals
;;;;;;;;;;;;;;;;;;
Global $sToolboxTitle = "CGB Toolbox"

Global $txtToolbox_GUI_Log
Global $grpToolbox_GUI_Controls
Global $btnToolbox_GUI_HKStatus
Global $btnToolbox_GUI_Red
Global $btnToolbox_GUI_Yellow
Global $btnToolbox_GUI_Green
Global $btnToolbox_GUI_Dismiss
Global $btnToolbox_GUI_Detach

Global $winToolbox
Global $txtToolbox_Win_Log
Global $btnToolbox_Win_HKStatus
Global $btnToolbox_Win_Red
Global $btnToolbox_Win_Yellow
Global $btnToolbox_Win_Green
Global $btnToolbox_Win_Dismiss
Global $btnToolbox_Win_Attach

;;;;;;;;;;;;;;;;;;;;;
;;; Toolbox Design
;;;;;;;;;;;;;;;;;;;;;
Func _CGB_GUI_Toolbox_Win() ; x=0, y=120
    Local $width = 470
    Local $height = 84
    Local $winPos = WinGetPos($sBotTitle)

    $winToolbox = GUICreate($sToolboxTitle, $width, $height, _
        $winPos[0], $winPos[1], _
        -1, $WS_EX_TOOLWINDOW, _
        $frmBot)

    ; Hide Close Button
    Local $h = WinGetHandle($winToolbox)
    Local $iOldStyle = _WinAPI_GetWindowLong($h, $GWL_STYLE)
    Local $iNewStyle = BitXOr($iOldStyle, $WS_SYSMENU)
    _WinAPI_SetWindowLong($h, $GWL_STYLE, $iNewStyle)

    ; Disable Close Button
    ;Local $hSysMenu = _GUICtrlMenu_GetSystemMenu($winToolbox, 0)
    ;_GUICtrlMenu_RemoveMenu($hSysMenu, $SC_CLOSE, False)
    ;_GUICtrlMenu_DrawMenuBar($winToolbox)

    Local $x = 0, $y = 0
    $x += 25
    $y += 25
    $txtToolbox_Win_Log = _GUICtrlRichEdit_Create($winToolbox, "", $x - 20 + 160, $y - 20, 220, 73, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912), $WS_EX_STATICEDGE)

    $grpToolbox_Win_Controls = GUICtrlCreateGroup("Hotkeys Controls", $x - 20, $y - 20, 155, 75)
        $btnToolbox_Win_HKStatus = GUICtrlCreateButton("", $x - 10, $y, 100, 46, $BS_MULTILINE)
        $txtTip = "Activate/Deactivate the Hotkeys."
        GUICtrlSetTip(-1, $txtTip)
        GUICtrlSetFont(-1, 10, -1, -1, "Bad Blockhead")
        _GUICtrlButton_SetTextMargin(-1, 3, 3, 3, 3)
        _GUICtrlButton_SetText(-1, "Hotkeys" & @CRLF & "Inactive")
        GUICtrlSetOnEvent(-1, "btnToolboxStatus")
        ;=== Semaphore!!!
        $y = 25
        $y += -5
        $btnToolbox_Win_Red = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_RED_LIT)
        GUICtrlSetState(-1, $GUI_DISABLE)
        $y += 18
        $btnToolbox_Win_Yellow = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_YELLOW_OFF)
        GUICtrlSetState(-1, $GUI_DISABLE)
        $y += 18
        $btnToolbox_Win_Green = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_GREEN_OFF)
        GUICtrlSetState(-1, $GUI_DISABLE)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $x = 390
    $y = 7
    $btnToolbox_Win_Dismiss = GUICtrlCreateButton("Dismiss", $x, $y, 70, 32)
    $txtTip = "Dismiss the Attack Toolbox disabling hotkeys in the process."
    GUICtrlSetTip(-1, $txtTip)
    GUICtrlSetOnEvent(-1, "btnToolboxDismiss")
    $y += 36
    $btnToolbox_Win_Attach = GUICtrlCreateButton("Attach", $x, $y, 70, 32)
    $txtTip = "Dismiss the Attack Toolbox disabling hotkeys in the process."
    GUICtrlSetTip(-1, $txtTip)
    GUISetState(@SW_HIDE, $winToolbox)
    GUICtrlSetOnEvent(-1, "btnToolbox_Win_Attach")
EndFunc

Func _CGB_GUI_Toolbox_GUI($x, $y)
    ;Local $x = 0, $y = 0
    ;;; Toolbox Log
    $x += 25
    $y += 25
    $txtToolbox_GUI_Log = _GUICtrlRichEdit_Create($frmBot, "", $x - 20 + 160, $y - 20, 220, 73, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912), $WS_EX_STATICEDGE)
    ControlHide($frmBot, "", $txtToolbox_GUI_Log)

    $grpToolbox_GUI_Controls = GUICtrlCreateGroup("Hotkeys Controls", $x - 20, $y - 20, 155, 75)
    GUICtrlSetState(-1, $GUI_HIDE)
        $btnToolbox_GUI_HKStatus = GUICtrlCreateButton("", $x - 10, $y, 100, 46, $BS_MULTILINE)
        $txtTip = "Activate/Deactivate the Hotkeys."
        GUICtrlSetTip(-1, $txtTip)
        GUICtrlSetFont(-1, 10, -1, -1, "Bad Blockhead")
        _GUICtrlButton_SetTextMargin(-1, 3, 3, 3, 3)
        _GUICtrlButton_SetText(-1, "Hotkeys" & @CRLF & "Inactive")
        GUICtrlSetOnEvent(-1, "btnToolboxStatus")
        GUICtrlSetState(-1, $GUI_HIDE)
        ;=== Semaphore!!!
        $y = 25
        $y += -5
        $btnToolbox_GUI_Red = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_RED_LIT)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetState(-1, $GUI_HIDE)
        $y += 18
        $btnToolbox_GUI_Yellow = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_YELLOW_OFF)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetState(-1, $GUI_HIDE)
        $y += 18
        $btnToolbox_GUI_Green = GUICtrlCreateButton("", $x - 10 + 105, $y, 32, 18, $BS_FLAT)
        GUICtrlSetBkColor(-1, $COLOR_GREEN_OFF)
        GUICtrlSetState(-1, $GUI_DISABLE)
        GUICtrlSetState(-1, $GUI_HIDE)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $x = 390
    $y = 7
    $btnToolbox_GUI_Dismiss = GUICtrlCreateButton("Dismiss", $x, $y, 70, 32)
    $txtTip = "Dismiss the Attack Toolbox disabling hotkeys in the process."
    GUICtrlSetTip(-1, $txtTip)
    GUICtrlSetOnEvent(-1, "btnToolboxDismiss")
    GUICtrlSetState(-1, $GUI_HIDE)
    $y += 36
    $btnToolbox_GUI_Detach = GUICtrlCreateButton("Detach", $x, $y, 70, 32)
    $txtTip = "Dismiss the Attack Toolbox disabling hotkeys in the process."
    GUICtrlSetTip(-1, $txtTip)
    GUICtrlSetState(-1, $GUI_HIDE)
    GUICtrlSetOnEvent(-1, "btnToolbox_GUI_Detach")
EndFunc