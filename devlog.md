2024-10-22 - 4 hr: resumed work after life factors strike again, will work again another day this week to make up for lost time
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
-
-
-
-
-
-
-
-

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
