# Dota 2 Queue-And-Go

<img src="/resources/qng_hero2.png" width="850" alt="qng_hero">

# (!) IMPORTANT AND REQUIRED:

(!) Requires AutoHotkey v1.1 (not v2.0). 
Download here: https://www.autohotkey.com/

**(!) MAKE SURE your 'ShareToChat.png' image IS THE SAME IMAGE as in your in-game lobby!**

If you use a different resolution - just retake the image.
(Screenshot with the 'PrintScreen' keyboard button, then crop it in 'Paint'.)
(ShareX and alike apps work as well)

[**Download Button Click Here**](https://github.com/etofok/Dota-2-Queue-and-Go/releases/tag/v1.1)

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K1DI5PY)


## The Story

Once upon a time there was a Dota 2 player who enjoyed the game. He really wanted to play multiple games in row, but he had a problem.

He ALSO wanted a fresh cup of coffee and a bathroom break.

But waiting several minutes for the queue to pop, only for someone not to accept the 'Your Game is Ready'... is annoying.

Doing this all over again only to get back into the queue because one of the players "has failed to connect"...

He really wanted his coffee!


## Quick Summary

<img src="/icon.ico" width="100" alt="qng_icon">

**Dota 2 Queue-And-Go** helps players to ALWAYS end up at the pick phase successfully, without macro spamming the client.

**Dota 2 Queue-And-Go** automatically accepts '*Ready check*' pop-ups, '*Game is Ready*' pop-ups, stays in the queue if someone didn't accept or hasn't connected and *deactivates itself* after everyone has connected.

While is does require a 1 minute setup, it works in any language, game mode and window resolution.


## What's in the Package

| File Name              	| Extension 		| Purpose |
| :---------------- 		| :------: 			| :---- |
| Dota 2 Queue-n-Go        	|   .ahk   			| The Script itself |
| ShareToChat 				|  .png   			| Target Image for 1920x1080  |
| hotkeys    				|  .ini   			| Hotkeys file |
| icon           			|   .ico   			| Tray icon |


## How to Use

<img src="/resources/qng_foreground.png" width="491" alt="qng_foreground">

- Enable "Bring Dota to foreground on match found" in Options -> Advanced.
- Enable "Bring Dota to foreground for ready checks" in Options -> Advanced.
- Enable "Bring Dota to foreground for pick phase and game start" in Options -> Advanced.
- **(!) MAKE SURE your 'ShareToChat.png' image IS THE SAME IMAGE as in your in-game lobby!**
If you use a different resolution - just retake the image.
(Screenshot with the 'PrintScreen' keyboard button, then crop it in 'Paint'.)
(ShareX and alike apps work as well)
- Press [ALT + N] to activate the script.
You can change the hotkey using any text editor.

<img src="/resources/qng_hotkeys.png" width="350" alt="qng_hotkeys">


## How it actually works

<img src="/resources/qng_logic1.png" width="850" alt="qng_logic">

The script locates the Play Dota button, which is consistently positioned approximately 5% from the right edge of the window and at a similar height to the ShareToChat.png image.

The script queues for the game and minimizes the Dota 2 window.


When the game is ready Dota 2 will be brought to the front as specified in the options


The script then presses Enter once, assuming there's a button to be pressed since the Dota 2 window becomes active.


After pressing Enter, the script minimizes Dota 2 again.


After a short delay, Dota 2 will be brought forward again under the following conditions:

- a) A new 'Game is Ready' pop-up appears due to someone failing to accept the game previously.

- b) Everyone has successfully accepted the game and is loading into the pick phase.


Last but not least, the script scans for the ShareToChat.png image every second for the next 27 seconds.

- a) If the ShareToChat.png image IS NOT detected again, everyone has successfully connected.

- b) If the ShareToChat.png image IS detected again, someone failed to connect, indicating a return to the main lobby screen and queuing for another game, prompting the script to minimize the Dota 2 window and wait for another game pop-up.


It was fun to make it.

etofok

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K1DI5PY)
