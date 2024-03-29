# Dota 2 Queue-And-Go

<img src="/icon.ico" width="850" alt="qng_icon">

## Quick Summary

Once upon a time there was a Dota 2 player who enjoyed the game. He really wanted to play multiple games in row, but he had a problem.

He ALSO wanted a fresh cup of coffee (and a bio break).

But waiting for the queue to pop, only for someone not to accept the 'Match Found'... is annoying.

Doing this all over again only to get back into the queue because a 'Player has not connected"...

Yeah. 

He really wanted his coffee.

**Dota 2 Queue-And-Go** helps players to get to the draft screen successfully and automatically, without macro spamming the client with {Enter}.

**Queue-And-Go** automatically accepts '*Ready check*' pop-ups, '*Game is Ready*' pop-ups and *deactivates itself* after making sure everyone has connected.


The best thing: 

it only needs to 'see' this little tiny image on your screen - the Share to Chat button, 

<img src="/resources/ShareToChat_placement.png" width="850" alt="qng_stc">

...which means the app works in **ANY** interface language, 
for every game mode
AND in every screen resolution. 


# What's in the Package

- [x] an AutoHotkey file (.ahk), 
- [x] a tray icon (.ico),
- [x] ShareToChat.jpg (.jpg) image for the 1920x1080 resolution

# (!) IMPORTANT: 

If you use a different resolution just retake the image easily with 'PrintScreen', then crop it in 'Paint' and it will work for your configuration.


# How to Use

- Enable "Bring Dota to foreground on match found" in Options -> Advanced.
- Enable "Bring Dota to foreground for ready checks" in Options -> Advanced.
- Enable "Bring Dota to foreground for pick phase and game start" in Options -> Advanced.

<img src="/resources/qng_foreground.png" width="850" alt="qng_foreground">

- (!) MAKE SURE your 'ShareToChat.jpg' image IS THE SAME IMAGE as in your in-game lobby!

- Press [ALT + N] to activate the script.
You can change the hotkey using any text editor like Notepad.

<img src="/resources/qng_notepad.png" width="850" alt="qng_notepad">


# How it works

<img src="/resources/qng_logic.png" width="850" alt="qng_logic">

* The script locates the Play Dota button, which is consistently positioned approximately 5% from the right edge of the window and at a similar height to the ShareToChat.jpg image.
* The script queues for the game and minimizes the Dota 2 window.
* When the game is ready Dota 2 will be brought to the front as specified in the options
* The script then presses Enter once, assuming there's a button to be pressed since the Dota 2 window becomes active.
* After pressing Enter, the script minimizes Dota 2 again.
* After a short delay, Dota 2 will be brought forward again under the following conditions:
a) A new 'Game is Ready' pop-up appears due to someone failing to accept the game previously.
b) Everyone has successfully accepted the game and is loading into the pick phase.
* Last but not least, the script scans for the ShareToChat.jpg image every second for the next 30 seconds.
a) If the ShareToChat.jpg image IS NOT detected again, everyone has successfully connected.
b) If the ShareToChat.jpg image IS detected again, someone failed to connect, indicating a return to the main lobby screen and queuing for another game, prompting the script to minimize the Dota 2 window and wait for another game pop-up.


It's a hilarious solution, so it was fun to make it.

etofok


