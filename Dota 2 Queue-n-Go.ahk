;-----------------------------------------
;	ETOFOK UX DESIGN
;-----------------------------------------

;-----------------------------------------
; ----- H O T K E Y S -----
;-----------------------------------------

; ^ - CTRL
; + - SHIFT
; ! - ALT
; # - WIN

Hotkey_QueueAndGo			= !n 		; <--------------

Hotkey_ScriptReload 		= !m		; <--------------
Hotkey_ScriptFolder			= 
Hotkey_ScriptEdit 			= 
Hotkey_ScriptExit 			= 

;-----------------------------------------

#SingleInstance force
#NoEnv
#Persistent
#MaxHotkeysPerInterval, 500

SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 3

if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"

currentVersion 						:= 	"Dota 2 Queue-and-Go v290323"
Global i_ShareToChat 				:= 	"ShareToChat.png"
icon_Main 							= 	icon.ico

;-----------------------------------------
; ----- H O T K E Y S -----
;-----------------------------------------

; ^ - CTRL
; + - SHIFT
; ! - ALT
; # - WIN

Hotkey_QueueAndGo										= !n 		; <--------------

Hotkey_ScriptReload 									= !m		; <--------------
Hotkey_ScriptFolder										= 
Hotkey_ScriptEdit 										= 
Hotkey_ScriptExit 										= 

Hotkey, %Hotkey_QueueAndGo%, 	QueueAndGo,				UseErrorLevel	
Hotkey, %Hotkey_ScriptReload%, 	ScriptReload,			UseErrorLevel	
Hotkey, %Hotkey_ScriptFolder%, 	ScriptFolder,			UseErrorLevel	
Hotkey, %Hotkey_ScriptEdit%, 	ScriptEdit,				UseErrorLevel	
Hotkey, %Hotkey_ScriptExit%, 	ScriptExit,				UseErrorLevel	

Tooltip_Hotkey_QueueAndGo 		:= ReplaceModifiers(Hotkey_QueueAndGo)
Tooltip_Hotkey_ScriptReload 	:= ReplaceModifiers(Hotkey_ScriptReload)
Tooltip_Hotkey_ScriptFolder 	:= ReplaceModifiers(Hotkey_ScriptFolder)
Tooltip_Hotkey_ScriptEdit 		:= ReplaceModifiers(Hotkey_ScriptEdit)
Tooltip_Hotkey_ScriptExit 		:= ReplaceModifiers(Hotkey_ScriptExit)


Menu, Tray, NoStandard

Menu, Tray, Insert, 1&, 	%currentVersion%,										menublank
Menu, Tray, Default, 	 	%currentVersion%
Menu, Tray, Disable, 	 	%currentVersion%

Menu, Tray, Insert, 2&,		etofok Link Tree >>,									LinkTree
Menu, Tray, Insert,	3&,
Menu, Tray, Insert,	4&,		'Queue-And-Go' <%Tooltip_Hotkey_QueueAndGo%>,			QueueAndGo
Menu, Tray, Insert,	5&,
Menu, Tray, Insert, 6&, 	 Reload Script <%Tooltip_Hotkey_ScriptReload%>,			ScriptReload
Menu, Tray, Insert, 7&, 	 Open Folder <%Tooltip_Hotkey_ScriptFolder%>, 			ScriptFolder
Menu, Tray, Insert, 8&, 	 Edit Script <%Tooltip_Hotkey_ScriptEdit%>, 			ScriptEdit
Menu, Tray, Insert, 9&, 	 Exit Script <%Tooltip_Hotkey_ScriptExit%>, 			ScriptExit

Menu, Tray, Icon, %icon_Main%,, 1
Menu, Tray, Tip, Dota 2 Queue-and-Go by etofok


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


Return 

; 	END OF AUTOLAUNCH
;-----------------------------------------


QueueAndGo:

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
; LinkTree
;--------------------------------

LinkTree:
	Run, https://linktr.ee/etofok
return

;--------------------------------
; Locate This Script
;--------------------------------

ScriptFolder:
	Run, %a_scriptdir%
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