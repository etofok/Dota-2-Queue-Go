;-----------------------------------------

#SingleInstance force
#NoEnv
#Persistent
#MaxThreadsPerHotkey 1

SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 3

if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"

currentVersion 						:= 	"Dota 2 Queue-and-Go!"
Global i_ShareToChat 				:= 	"ShareToChat.png"
icon_Main 							= 	icon.ico

;-----------------------------------------
; ----- H O T K E Y S -----
;-----------------------------------------

IniRead, Hotkey_QueueAndGo, 		hotkeys.ini, Hotkeys, Hotkey_QueueAndGo
IniRead, Hotkey_ScriptReload, 		hotkeys.ini, Hotkeys, Hotkey_ScriptReload
IniRead, Hotkey_ScriptHotkeys, 		hotkeys.ini, Hotkeys, Hotkey_ScriptHotkeys

Hotkey, %Hotkey_QueueAndGo%, 		QueueAndGo, 			UseErrorLevel
Hotkey, %Hotkey_ScriptReload%,		ScriptReload, 			UseErrorLevel
Hotkey, %Hotkey_ScriptHotkeys%,		ScriptHotkeys, 			UseErrorLevel

Tooltip_Hotkey_QueueAndGo 		:= ReplaceModifiers(Hotkey_QueueAndGo)
Tooltip_Hotkey_ScriptReload 	:= ReplaceModifiers(Hotkey_ScriptReload)
Tooltip_Hotkey_ScriptHotkeys 	:= ReplaceModifiers(Hotkey_ScriptHotkeys)

Menu, Tray, NoStandard

Menu, Tray, Add, 			%currentVersion%,										menublank
Menu, Tray, Default,		%currentVersion%
Menu, Tray, Disable,		%currentVersion%

Menu, Tray, Add,			etofok Link Tree >>,									LinkTree
Menu, Tray, Add,
Menu, Tray, Add,			Run 'Queue-And-Go'`t[%Tooltip_Hotkey_QueueAndGo%],		QueueAndGo
Menu, Tray, Add, 			Reload / Stop`t[%Tooltip_Hotkey_ScriptReload%],			ScriptReload
Menu, Tray, Add,
Menu, Tray, Add, 			Change Hotkeys,											ScriptHotkeys
Menu, Tray, Add, 			Open Folder, 											ScriptFolder
Menu, Tray, Add, 			Open Github, 											ScriptGithub
Menu, Tray, Add, 			Exit Script, 											ScriptExit

Menu, Tray, Icon, 			%icon_Main%,, 1
Menu, Tray, Tip, 			%currentVersion%


; ---
; Optional Add/Remove Launch Dota 2 to the app
; Add/Remove a hotkey in hotkeys.ini
; ---

IniRead, Hotkey_LaunchDota2, 		hotkeys.ini, Hotkeys, Hotkey_LaunchDota2

if (Hotkey_LaunchDota2) {

	Hotkey, %Hotkey_LaunchDota2%,	LaunchDota2, 			UseErrorLevel

	Tooltip_Hotkey_LaunchDota2 		:= ReplaceModifiers(Hotkey_LaunchDota2)

	Menu, Tray, Insert, 3&
	Menu, Tray, Insert, 4&,	Launch Dota 2`t[%Tooltip_Hotkey_LaunchDota2%],			LaunchDota2
}


gui_Width		:= 240
gui_Height 		:= 20
gui_margin		:= 15
gui_colorBG		:= 0x467C52
gui_typeFont	:= Tahoma
gui_colorFont	:= "cFAFDFD"
gui_sizeFont	:= 10

Gui, GUI_DotaQueueAndGo:+LastFound -Caption -Border +ToolWindow +AlwaysOnTop
Gui, GUI_DotaQueueAndGo:Color, %gui_colorBG%
Gui, GUI_DotaQueueAndGo:margin, %gui_margin%, %gui_margin%
Gui, GUI_DotaQueueAndGo:Font, s%gui_sizeFont% %gui_colorFont%, %gui_typeFont%
Gui, GUI_DotaQueueAndGo:Add, Text, w%gui_Width% h%gui_Height% vAlert1

WinSet, TransColor, %color% 220, % GUI_DotaQueueAndGo 	; PNG transparency. 0 = fully transparent
WinSet, ExStyle, +0x20, % GUI_DotaQueueAndGo			; Click-through


displaySplash := currentVersion
SplashTextOn, 250, 50, , %displaySplash%
Sleep, 1000
SplashTextOff

Return 

; 	END OF AUTOLAUNCH
;-----------------------------------------


QueueAndGo:

	SplashTextOff

	weAreInGame 	:= 0
	allConnected 	:= 0
	endTimeReset	:= 27
	endTime 		:= endTimeReset

	if !WinExist("ahk_exe dota2.exe") {

		Gui, GUI_DotaQueueAndGo:Hide

		SplashTextOn, 200, 45,, Dota 2 not found!
		Sleep 1000
		SplashTextOff

		return
	} 

	WinActivate, Dota 2
	WinGetPos, Dota2WindowStart_X, Dota2WindowStart_Y, Dota2WindowWidth, Dota2WindowHeight, Dota 2
	
	Gui, GUI_DotaQueueAndGo:Show, % "x" (Dota2WindowStart_X + Dota2WindowWidth - (gui_Width + gui_margin*2)) " y" (Dota2WindowStart_Y + (Dota2WindowHeight * (0.1)))

	UpdateGUI("Dota 2 found!")
	Sleep 750

	;MsgBox, %Dota2WindowStart_X%, %Dota2WindowStart_Y%, %Dota2WindowWidth%, %Dota2WindowHeight%

	WinActivate, Dota 2 ; either explicitly activate window or do CoordMode, Pixel, Screen
	ImageSearch, ShareToChat_X, ShareToChat_Y, %Dota2WindowStart_X%, %Dota2WindowStart_Y%, %Dota2WindowWidth%, %Dota2WindowHeight%, *20 %i_ShareToChat%

	if (ShareToChat_X > 0) {
		
		UpdateGUI("Starting...")
		; Find the Play Dota button for every screen resolution
		coords_PlayDotaButton_X := Dota2WindowWidth * 0.94
		coords_PlayDotaButton_Y := ShareToChat_Y
	} else {

		UpdateGUI("'ShareToChat.png' not found on screen!")
		Sleep 2500
		UpdateGUI("Deactivating...")
		Sleep 1000
		Gui, GUI_DotaQueueAndGo:Hide

		return
	}
	
	; click 'PLAY DOTA'
	Click, %coords_PlayDotaButton_X%, %coords_PlayDotaButton_Y%

	Random ranSleep, 621, 1154
	sleep %ranSleep%

	; click 'FIND MATCH'
	Click, %coords_PlayDotaButton_X%, %coords_PlayDotaButton_Y%
	Sleep 100

	; Minimize Dota 2 in case of a ready check or in case someone didn't accept the 'match found' pop-up
	; Until we see the pick phase screen, we will keep minimizing the game
	WinMinimize, Dota 2

	while (allConnected = 0) {

		; Loop to Accept big green button pop-ups
		; until we no longer see the main lobby
		Loop {

			; check whether Dota 2 has been brought to the foreground every second
			while !(WinActive("ahk_exe dota2.exe")) {

					UpdateGUI("Waiting for Dota 2...")
					Sleep 500
			}

			; needs to be at least a few seconds to load the interface
			Sleep 500
			UpdateGUI("Dota 2!")
			Sleep 500

			UpdateGUI("Give it a second to load...")
			Sleep 2500

			; Search for the 'Share to Chat' icon on screen.
			; It is only seen in the main lobby!
			WinActivate, Dota 2
			ImageSearch, ShareToChat_X, ShareToChat_Y, %Dota2WindowStart_X%, %Dota2WindowStart_Y%, %Dota2WindowWidth%, %Dota2WindowHeight%, *20 %i_ShareToChat%

			; if not found, then we are in game
			if !(ShareToChat_X > 0) { 

				weAreInGame := 1

				UpdateGUI("Game On!")
				Sleep 1000

				break

			; if found, then we are in the main lobby
			; this means there's a pop-up that needs to be accepted ('ready check' or 'game ready')
			} else {

				UpdateGUI("Main Lobby!")
				Sleep, 500

				Send {Enter}

				UpdateGUI("Accepting...")
				Sleep, 250

				UpdateGUI("Minimizing...")
				Sleep, 250

				WinMinimize, Dota 2
				Sleep, 500
			}
		}



	    ; Searching for the 'Share to Chat' icon.
		; It can only be see in the main lobby!
	    Loop {
			
			WinActivate, Dota 2
			ImageSearch, ShareToChat_X2, ShareToChat_Y2, %Dota2WindowStart_X%, %Dota2WindowStart_Y%, %Dota2WindowWidth%, %Dota2WindowHeight%, *20 %i_ShareToChat%

			if (ShareToChat_X2 > 0) { 

				weAreInGame 	:= 0
				allConnected 	:= 0
				endTime 		:= endTimeReset

				Send {Enter}	; just in case
				Sleep 100  		; need to act quick here
				WinMinimize, Dota 2		

				UpdateGUI("Back to the main lobby...")
				Sleep 1500

				break

			} else {

		    	tempTxt := "Deactivating in " . endTime . "s..."
				UpdateGUI(tempTxt)
			}

	        Sleep 1000  ; Wait for 1 second
	        endTime--

	        if (endTime <= 0) {
	        	allConnected 	:= 1
	        	endTime 		:= endTimeReset
	            break  ; Exit the loop when the time is up
	    	}
	    }

	}
	
	UpdateGUI("Good Luck!")
	Sleep 2000
	Gui, GUI_DotaQueueAndGo:Hide

return


;--------------------------------
; Update GUI
;--------------------------------

UpdateGUI(message) {

	pAlert1 := message

	GuiControl, GUI_DotaQueueAndGo:, Alert1, % pAlert1
}

;--------------------------------
; LaunchDota2
;--------------------------------

LaunchDota2:
	Run, steam://rungameid/570
return

;--------------------------------
; LinkTree
;--------------------------------

LinkTree:
	Run, https://linktr.ee/etofok
return

;--------------------------------
; Hotkeys.ini
;--------------------------------

ScriptHotkeys:
	Run, %a_scriptdir%/hotkeys.ini
return

;--------------------------------
; Locate This Script
;--------------------------------

ScriptFolder:
	Run, %a_scriptdir%
return

;--------------------------------
; Open on Github
;--------------------------------

ScriptGithub:
	Run, https://github.com/etofok/Dota-2-Queue-and-Go?tab=readme-ov-file#how-to-use
return

;--------------------------------
; Edit This Script
;--------------------------------

ScriptEdit:
	Edit
return

;--------------------------------
; Exit This Script
;--------------------------------

ScriptExit:
	ExitApp
return

;--------------------------------
; Reload This Script
;--------------------------------

ScriptReload:
	Reload
return

;--------------------------------
; Translate Tooltip Hotkeys to Human Language
;--------------------------------

ReplaceModifiers(str) {
    ; Replace symbols with corresponding names
    str := StrReplace(str, "+", "SHIFT + ")		; start with the "+"!
    str := StrReplace(str, "!", "ALT + ")
    str := StrReplace(str, "^", "CTRL + ")
    str := StrReplace(str, "#", "WIN + ")
    return str
}


menublank:
return