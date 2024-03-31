# Dota 2 Queue-And-Go

<img src="/resources/qng_hero2.png" width="850" alt="qng_hero">

# (!) IMPORTANT AND REQUIRED:

(!) Requires AutoHotkey v1.1 (not v2.0). 
Download here: https://www.autohotkey.com/

**(!) MAKE SURE your 'ShareToChat.png' image IS THE SAME IMAGE as in your in-game lobby!**

- If you use a different resolution - just retake the image.

- Screenshot with the 'PrintScreen' keyboard button, then crop it in 'Paint'.

- ShareX and alike apps work as well

[**Download Dota 2 Queue-And-Go Button Click Here**](https://github.com/etofok/Dota-2-Queue-and-Go/releases/tag/v1.1)

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
| :---------------- 		| :------ 			| :---- |
| Dota 2 Queue-n-Go        	|   .ahk   			| The Script itself |
| ShareToChat 				|  .png   			| Target Image for 1920x1080  |
| hotkeys    				|  .ini   			| Hotkeys file |
| icon           			|   .ico   			| Tray icon |



## How to Use

<p float="middle">
  <img src="/resources/qng_foreground.png" width="491" alt="qng_foreground">
</p>

1. Enable "Bring Dota to foreground on match found" in Options -> Advanced.
  
2. Enable "Bring Dota to foreground for ready checks" in Options -> Advanced.
  
3. Enable "Bring Dota to foreground for pick phase and game start" in Options -> Advanced.
  
4. **(!) MAKE SURE your 'ShareToChat.png' image IS THE SAME IMAGE as in your in-game lobby!**
  
- If you use a different resolution - just retake the image.

- (Screenshot with the 'PrintScreen' keyboard button, then crop it in 'Paint'.)

- (ShareX and alike apps work as well)

5. Press [ALT + N] to activate the script.

6. Press [ALT + M] to Reload / Stop the script.
  
- You can change the hotkeys using any text editor.

- Hotkeys are stored in the hotkeys.ini 

<p float="middle">
  <img src="/resources/qng_hotkeys.png" width="350" alt="qng_hotkeys">
</p>




## You can also add (remove) 'Launch Dota 2' option

<p float="middle">
  <img src="/resources/option A.png" width="321" />
  <img src="/resources/option B.png" width="321" /> 
</p>

See hotkeys.ini for details

<p float="middle">
  <img src="/resources/LaunchDota2Setup.png" width="491" alt="qng_foreground">
</p>



## How it actually works (in detail)

<img src="/resources/qng_logic1.png" width="850" alt="qng_logic">

The script locates the Play Dota button, which is consistently positioned approximately 5% from the right edge of the window and at a similar height to the ShareToChat.png image.

The script queues for the game and minimizes the Dota 2 window.


When the game is ready Dota 2 will be brought to the front as specified in the options.


The script will then press Enter once, assuming there's a button to be pressed.


After pressing Enter, the script minimizes Dota 2 again.


After a short delay, Dota 2 will be brought forward again because...:

- a) A new 'Game is Ready' pop-up appeared because someone failed to accept the 'Game is Ready' the previous time.

- b) Everyone has successfully accepted the game and we're loading into the pick phase.


Last but not least, the script will then scan for the 'ShareToChat.png' image every second for the next 27 seconds. Why?

- a) If the 'ShareToChat.png' image IS detected AGAIN, that means we are thrown back to the main lobby! This can only happen when someone has failed to connect!
  All players are placed back in the queue. Therefore the script minimizes the Dota 2 window to wait for yet another game pop-up. It's a loop.

- b) If the 'ShareToChat.png' image IS NOT detected again, that means everyone has successfully connected. User are free to deactivate the script manually, but it will deactivate itself in 27 seconds.


It was fun to make it.

etofok

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K1DI5PY)
