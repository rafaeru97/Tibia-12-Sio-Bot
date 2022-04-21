#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=healing.ico
#AutoIt3Wrapper_Res_Description=Auto Sio Bot for Tibia 12+
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductName=Tibia 12 Sio
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=rafaeru
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Include <Misc.au3>
#include <Timers.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <Array.au3>
#include <WinAPIFiles.au3>


#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Opt("GUIResizeMode", $GUI_DOCKSIZE)
$Form1 = GUICreate("Tibia 12 Sio", 244, 227, 190, 126, BitOR($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_THICKFRAME), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$Button1 = GUICtrlCreateButton("Pick Sio 1 Color", 8, 8, 91, 25)
$Label1 = GUICtrlCreateLabel("Color:", 112, 4, 124, 26)
$Label5 = GUICtrlCreateLabel("Act:", 112, 28, 124, 26)
$Button2 = GUICtrlCreateButton("START", 8, 168, 179, 33)
$Label3 = GUICtrlCreateLabel("by rafaeru", 184, 208, 55, 18)
$Label4 = GUICtrlCreateLabel("Status: OFF", 8, 206, 80, 20)
GUICtrlSetColor($Label4, 0xFF0000)
GUICtrlSetFont ($Label4,9, 800)
$Button3 = GUICtrlCreateButton("Pick Self Color", 8, 112, 91, 25)
$Label6 = GUICtrlCreateLabel("Color:", 112, 108, 124, 26)
$Label7 = GUICtrlCreateLabel("Act:", 112, 132, 124, 26)
$Button4 = GUICtrlCreateButton("?", 200, 168, 35, 33)
$Button5 = GUICtrlCreateButton("Pick Sio 2 Color", 8, 56, 91, 25)
$Label2 = GUICtrlCreateLabel("Color:", 112, 52, 124, 26)
$Label8 = GUICtrlCreateLabel("Act:", 112, 76, 124, 26)
$Checkbox1 = GUICtrlCreateCheckbox("Paladin Sio", 8, 82, 97, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $handle_OBS = WinGetHandle("[CLASS:Qt5152QWindowIcon]")
Global $handle_Client = WinGetHandle("[CLASS:Qt5QWindowOwnDCIcon]")

If Not($handle_OBS) Then
	MsgBox(1, "Info", "Run OBS with Tibia Client in window preview (source) first.")
	Exit
EndIf

If Not($handle_Client) Then
	MsgBox(1, "Info", "Run Tibia Client first.")
	Exit
EndIf

Global $colorPositionSio[2]
Global $colorPositionSio2[2]
Global $colorPositionSelf[2]
Global $actualColorSio
Global $actualColorSio2
Global $actualColorSelf
Global $pixelColorSio
Global $pixelColorSio2
Global $pixelColorSelf

$iniFile = "settings.ini"
If FileExists ($iniFile) Then
	$colorPositionSio[0] = IniRead($iniFile, "colorPositionSio", "x", 0)
	$colorPositionSio[1] = IniRead($iniFile, "colorPositionSio", "y", 0)
	$colorPositionSio2[0] = IniRead($iniFile, "colorPositionSio2", "x", 0)
	$colorPositionSio2[1] = IniRead($iniFile, "colorPositionSio2", "y", 0)
	$colorPositionSelf[0] = IniRead($iniFile, "colorPositionSelf", "x", 0)
	$colorPositionSelf[1] = IniRead($iniFile, "colorPositionSelf", "y", 0)
	$pixelColorSio = MemoryReadPixel($colorPositionSio[0], $colorPositionSio[1], $handle_OBS)
	$pixelColorSio2 = MemoryReadPixel($colorPositionSio2[0], $colorPositionSio2[1], $handle_OBS)
	$pixelColorSelf = MemoryReadPixel($colorPositionSelf[0], $colorPositionSelf[1], $handle_OBS)
	GUICtrlSetData($Label1, "Color: " & $pixelColorSio & " (" & $colorPositionSio[0] & " " & $colorPositionSio[1] & ")")
	GUICtrlSetColor($Label1, Dec($pixelColorSio))
	GUICtrlSetData($Label2, "Color: " & $pixelColorSio2 & " (" & $colorPositionSio2[0] & " " & $colorPositionSio2[1] & ")")
	GUICtrlSetColor($Label2, Dec($pixelColorSio2))
	GUICtrlSetData($Label6, "Color: " & $pixelColorSelf & " (" & $colorPositionSelf[0] & " " & $colorPositionSelf[1] & ")")
	GUICtrlSetColor($Label6, Dec($pixelColorSelf))
EndIf

Local $pickColorSio = False
Local $pickColorSio2 = False
Local $pickColorSelf = False

_Timer_SetTimer($Form1, 250, "mainTimer")
Global $status = False

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1
			If $pickColorSio == False Then
				$pickColorSio = True
				$colorPositionSio = GetPos()
				$pixelColorSio = MemoryReadPixel($colorPositionSio[0], $colorPositionSio[1], $handle_OBS)
				GUICtrlSetData($Label1, "Color: " & $pixelColorSio & " (" & $colorPositionSio[0] & " " & $colorPositionSio[1] & ")")
				GUICtrlSetColor($Label1, Dec($pixelColorSio))
				$pickColorSio = False
				IniWrite($iniFile, "colorPositionSio", "x", $colorPositionSio[0])
				IniWrite($iniFile, "colorPositionSio", "y", $colorPositionSio[1])
			EndIf
		Case $Button5
			If $pickColorSio2 == False Then
				$pickColorSio2 = True
				$colorPositionSio2 = GetPos()
				$pixelColorSio2 = MemoryReadPixel($colorPositionSio2[0], $colorPositionSio2[1], $handle_OBS)
				GUICtrlSetData($Label2, "Color: " & $pixelColorSio2 & " (" & $colorPositionSio2[0] & " " & $colorPositionSio2[1] & ")")
				GUICtrlSetColor($Label2, Dec($pixelColorSio2))
				$pickColorSio2 = False
				IniWrite($iniFile, "colorPositionSio2", "x", $colorPositionSio2[0])
				IniWrite($iniFile, "colorPositionSio2", "y", $colorPositionSio2[1])
			EndIf
		Case $Button3
			If $pickColorSelf == False Then
				$pickColorSelf = True
				$colorPositionSelf = GetPos()
				$pixelColorSelf = MemoryReadPixel($colorPositionSelf[0], $colorPositionSelf[1], $handle_OBS)
				GUICtrlSetData($Label6, "Color: " & $pixelColorSelf & " (" & $colorPositionSelf[0] & " " & $colorPositionSelf[1] & ")")
				GUICtrlSetColor($Label6, Dec($pixelColorSelf))
				$pickColorSelf = False
				IniWrite($iniFile, "colorPositionSelf", "x", $colorPositionSelf[0])
				IniWrite($iniFile, "colorPositionSelf", "y", $colorPositionSelf[1])
			EndIf
		Case $Button2
			If $status Then
				$status = False
				GUICtrlSetData($Button2, "START")
				GUICtrlSetData($Label4, "Status: OFF")
				GUICtrlSetColor($Label4, 0xFF0000)
				GuiCtrlSetState ($Button1, $GUI_ENABLE)
				GuiCtrlSetState ($Button3, $GUI_ENABLE)
				GuiCtrlSetState ($Button5, $GUI_ENABLE)
			Else
				If $pixelColorSio Then
					$Status = True
					GUICtrlSetData($Button2, "STOP")
					GUICtrlSetData($Label4, "Status: ON")
					GUICtrlSetColor($Label4, 0x00FF00)
					GuiCtrlSetState ($Button1, $GUI_DISABLE)
					GuiCtrlSetState ($Button3, $GUI_DISABLE)
					GuiCtrlSetState ($Button5, $GUI_DISABLE)
				Else
					MsgBox(1, "Info", "First pick pixel color.")
				EndIf
			EndIf
		Case $Button4
			MsgBox(1, "Info", "Pick Sio Color - Use Hotkey F12 and F10 with Sio spell when player health bar in party list is less than clicked."& @LF & "Pick Self Color - Use Hotkey F11 with Exura Gran Mas Res when player health bar is lower than clicked."& @LF & "Need use minimalized OBS in source preview.")
		Case $GUI_EVENT_CLOSE
			_Timer_KillAllTimers($Form1)
			Exit
		EndSwitch
WEnd

Func GetPos()
    While 1
        ToolTip("Click somewhere else now (" & MouseGetPos()[0] & ", " & MouseGetPos()[1] & ")")
        Sleep(100)
        If _IsPressed("01") Then ExitLoop
    WEnd
    ToolTip("")
    $pos = MouseGetPos()
	$pos[0] = $pos[0] + 8
	$pos[1] = $pos[1] + 8
	Return $pos
EndFunc

Func mainTimer($hWnd, $iMsg, $iIDtimer, $iTime)
	If $status Then
		$actualColorSio = MemoryReadPixel($colorPositionSio[0], $colorPositionSio[1], $handle_OBS)
		GUICtrlSetData($Label5, "Act: " & $actualColorSio & " (" & $colorPositionSio[0] & " " & $colorPositionSio[1] & ")")
		GUICtrlSetColor($Label5, Dec($actualColorSio))

		$actualColorSelf = MemoryReadPixel($colorPositionSelf[0], $colorPositionSelf[1], $handle_OBS)
		GUICtrlSetData($Label7, "Act: " & $actualColorSelf & " (" & $colorPositionSelf[0] & " " & $colorPositionSelf[1] & ")")
		GUICtrlSetColor($Label7, Dec($actualColorSelf))

		$actualColorSio2 = MemoryReadPixel($colorPositionSio2[0], $colorPositionSio2[1], $handle_OBS)
		GUICtrlSetData($Label8, "Act: " & $actualColorSio2 & " (" & $colorPositionSio2[0] & " " & $colorPositionSio2[1] & ")")
		GUICtrlSetColor($Label8, Dec($actualColorSio2))

		If (Hex($actualColorSelf) == Hex($pickColorSelf)) Then
			If ($actualColorSio > 400000) And ($actualColorSio < 600000) Then
				Sleep(Random(30, 60))
				DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYDOWN, "int", 0x7B, "int", 0)
				Sleep(Random(30, 60))
				DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYUP, "int", 0x7B, "int", 0)
			Else
				If IsChecked($Checkbox1) And ($actualColorSio2 > 400000) And ($actualColorSio2 < 600000) Then
					Sleep(Random(30, 60))
					DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYDOWN, "int", 0x79, "int", 0)
					Sleep(Random(30, 60))
					DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYUP, "int", 0x79, "int", 0)
				EndIf
			EndIf
		Else
			Sleep(Random(30, 60))
			DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYDOWN, "int", 0x7A, "int", 0)
			Sleep(Random(30, 60))
			DllCall('User32.dll', "int", "PostMessage", "hwnd", $handle_Client, "int", $WM_KEYUP, "int", 0x7A, "int", 0)
		EndIf
	EndIf
EndFunc

Func MemoryReadPixel($x, $y, $handle)
   Local $hDC
   Local $iColor
   Local $sColor

   $hDC = _WinAPI_GetWindowDC($handle)
   $iColor = DllCall("gdi32.dll", "int", "GetPixel", "int", $hDC, "int", $x, "int", $y)
   $sColor = Hex($iColor[0], 6)
   _WinAPI_ReleaseDC($handle, $hDC)
   Return Hex("0x" & StringRight($sColor, 2) & StringMid($sColor, 3, 2) & StringLeft($sColor, 2), 6)
EndFunc   ;==>MemoryReadPixel

Func IsChecked($control)
	Return BitAnd(GUICtrlRead($control),$GUI_CHECKED) = $GUI_CHECKED
EndFunc