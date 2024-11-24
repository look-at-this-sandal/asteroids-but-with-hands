2024-11-24 - 2.5 hr: much progress on the visuals
- exported sprite sheet of ship from aseprite with all animations
- switched player's Sprite2D node to an AnimatedSprite2D node for the purpose of adding animation
- player ship's animations are configured and active in-game
- made new graphics for large, medium, and small asteroids and implemented in game
- began work on making graphics for asteroid and player gibs. found [tutorial by Tissue Inu](https://www.youtube.com/watch?v=PMZ7yBwleik) about sprite particles
- asteroid particle system implemented successfully. asteroids now have gibs when they explode or split
- found [youtube tutorial by Heartbeast](https://www.youtube.com/watch?v=pDRx2F_pY2s) concerning high scores
- note: do i make a dedicated instructions screen in place of that invulnerability idea i had earlier? 
- note: continue working on the infinite asteroid spawning system

2024-11-19 - 3.5 hr: getting closer
- began implementing pause menu referencing [youtube tutorial by Gwizz](https://www.youtube.com/watch?v=JEQR4ALlwVU)
- added dedicated "pause" input (enter key / pause button on gamepad) that will be referenced by the pause menu
- commented out reset function for time being, will uncomment if testing is needed
- pause menu is fully functional, showing options to resume game and return to start menu
- began looking into implementation of high score function based on [tutorial by CIOSAI石獅](https://www.youtube.com/watch?v=ImXWh3DSuVc
- started work on background with stars based on [tutorial by 'Kaan Alpar'](https://www.youtube.com/watch?v=GNU5V1JVxHM)
- created starfield background referencing tutorial through the use of a particle system.
- found [tutorial by 16BitDev](https://www.youtube.com/watch?v=SqLVJxl7bNw) concerning particles for further detail. 
- created player explosion particle effect based on tutorial. yet to be properly implemented with the player ship's death
- added variable to determine if player is vulnerable or not. will use later
- re-exported build to itch.io, now with menus and pausing all included.
- note: ask professor about getting asteroids that are in contact with the raycast to glow but ONLY when they're in contact with the raycast
- note: potentially look into figuring out touch screen controls for maximum compatibility
- note: ask on the discord about how to count nodes of a specific group to make asteroid spawning system
- note: look into implementing invulnerability until the player moves, showing controls on the screen

2024-11-12 - 2 hr: recovering from mental health low point post-election.
- began work on non-placeholder graphics using aseprite to create the player ship sprite and animations.
- began work on score counter, adding [Kiwi Soda font by jeti](https://www.dafont.com/kiwisoda.font) to assets folder
- ship's floating, grabbing, and throwing animations are completed
- began working on score features, fleshed out explosion functions in accordance with [tutorial by 'Kaan Alpar'](https://www.youtube.com/watch?v=J3KZ_6aypKs)
- present score function is functional and completed. kiwi soda font is used for the UI. might change font later.
- began working on rudimentary start menu screen, referencing [youtube tutorial by Brett Makes Games](https://www.youtube.com/watch?v=RMdf60IAxY0) for scene transitions
- game now boots into start menu rather than the game scene, pressing the "start" button transitions the player immediately into the game scene
- note: watch [youtube tutorial by Gwizz](https://www.youtube.com/watch?v=JEQR4ALlwVU) and checking comments to look into adding a pause menu
- note: look into figuring out how to add 'gibs' and explosion effects for both the asteroids and the ship
- note: begin looking into how to handle endlessly spawning asteroids in accordance with how many are on screen

2024-11-05 - election day, 1 hr: resumed work, mostly focusing on beginning flourishes
- re-uploaded itch.io build to reflect 2024-10-29 build
- added sounds folder with the intent to add dedicated sound effects later
- 

2024-10-29 - ~ 4 hr: resumed work once more before class with the intent of finishing up mechanic
= pre-class work
- got thrown asteroids to finally explode when contacting other floating asteroids after everything
- discovered a bug with a signal relating to the throwing of asteroids that came about due to broken asteroids
- fixed previously mentioned bug by moving throwing function code to player ship's script file
- began work on the auto-throw mechanic with the creation of a timer node on the player ship
- used timer node to get the auto-throw functioning, thus completing the coding for the core mechanic (without visual polish)
- began working on player death
- discovered bug that i will either bring up to instructor or the discord "Attempt to call function 'throwing' in base 'previously freed' on a null instance.", instituted temporary fix for now using is_instance_valid

= during and post-class work
- referenced [youtube tutorial by 'Kaan Alpar'](https://www.youtube.com/watch?v=J3KZ_6aypKs) to begin implementing score and dying
- dying function successfully implemented, only happens when player hits asteroids that are not currently being grabbed
- added incredibly barebones game over screen, lives do not exist currently
- found bug with asteroid calling value of player's rotation when the player dies, redid initial code for dying to account for it
- dying now works, with grabbed asteroids exploding as the player dies.
- with that, the fundamental coding for main mechanic of the game has been completed, and so has the handling of player death.
- will begin with flourishes during my next work session
- note to self as i likely work on this again this week, look into a few things: 
	* figuring out how to count number of asteroids on screen 
	* how sprite animations work in godot
	* reference further tutorials to figure out how to get sound effects playing
	* determine the art style the finished game will have

2024-10-22 - 4 hr: resumed work after life factors strike again, wanted to work again another day this week to make up for lost time
= pre-class work
- began writing code to check if newly added raycast to player ship is colliding with asteroids (was successful)
- began reworking grab function, got asteroid to follow player position when grabbed and specified that large asteroids cannot be grabbed
- started developing state machine with the meteor to define what each state does
- added a cooldown timer to the player's grab function to ensure that players cannot spam the grab function
- defined the maximum speed for each asteroid size, and got transitions between states working 
- added functioning lerp to asteroid when re-entering floating state
- picking up and throwing is NOW (mostly) COMPLETE, what remains is making the thrown asteroids destroy floating ones
- making note: figure out how to ensure only one asteroid can be grabbed at a time, ask prof for help later in the week
- re-exported for HTML5 on itch.io

= during and post-class work
- engaged in playtesting

2024-10-08 - 4 hr: resumed work after life factors interfered AGAIN. i'll be working more on nailing things down tomorrow
= BLOCK 1 (pre-class work, 2 hours)
- referenced [youtube tutorial by 'Kaan Alpar'](https://www.youtube.com/watch?v=ELrMMv7D1wM) to further develop asteroid gimmick code
- established claw scene, got to work with coding the grabbing function based on [tutorial by Jean Makes Games](https://www.youtube.com/watch?v=D4mVVx4njno)
- fully implemented reset scene function for testing purposes
- added temporary code to ensure big asteroids cannot be grabbed
- added temporary code to have medium and small asteroids have their positions set to the player ship's position when grabbed
- got to work with initial variables and work-in-progress state machine for claw (printing to console to determine when the state is switched)
- re-uploaded build to itch.io to reflect the version of the project at the end of this block
= BLOCK 2 (during and after class work)
- began work on coding in asteroid explosions based on above tutorial. functions and signals defined for the process
- created timer child node of the claw to handle transition between states.
- removed the claw and the nodes associated with it for the time being
- added muzzle node to the player ship for future use with grabbed asteroids
- looking into working with raycasts to use the grabbing function, created a raycast2d node for the player ship node referencing [youtube tutorial](https://www.youtube.com/watch?v=adsQFchiOmw) and godot documentation
- stopped work early to do peer review


2024-10-01 - 3.5 hr: got back to work on project after other personal life factors got in way
- referenced [youtube tutorial by 'Kaan Alpar'](https://www.youtube.com/watch?v=zDpZ52Ulywg) to add movement for the player ship (controlled with arrow keys AND gamepad)
- imported temporary spaceship sprite and claw sprite assets made myself
- added multiple inputs for keyboard AND gamepad (with an additional dedicated "reset" button for testing purposes)
- got working screenwrap for player ship based on previously mentioned tutorial
- began working on the coding for the asteroids:
- asteroids now spawn in with random rotation, and wrap around the screen with a similar process to the player ship
- asteroid sizes defined as "LARGE", "MEDIUM", and "SMALL" with an enum function and variable
- future reference: look into using "Tween" node for handling the movement of the claw 

2024-09-24 - 2.5 hr: set up initial github repo in class
- learned how to use github a little bit using the provided tutorial, made the initial repo
- set up itch.io page for the project, made first html5 export of game
- learned how to make use of "pushing" and commands with gitbash
- set up trello board before class and finished it during last 10 minutes

Fall 2024 - Intro to Game Design @ SUNY New Paltz
- Name: Jon Lindsay
- [Trello Board](https://trello.com/b/dO2p1aNs/new-paltz-game-design-final-project)
- [itch.io link](https://look-at-this-sandal.itch.io/asteroid-but-with-hands)
