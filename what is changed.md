Color Variables:
These variables define ANSI escape codes for different colors, allowing the script to print colored text in the terminal. Each variable corresponds to a specific color.
-
display_animation Function:
This function introduces the game by displaying a simple animation. It clears the screen and prints frames of the animation with short delays using the sleep command.
-
spawn_enemy Function:
When called, this function randomly places additional enemies (ghosts) on the game board. It calculates random row and column coordinates within the board boundaries and updates the board array accordingly.
-
start_game Function:
This function initializes the game environment and contains the main game loop. It sets up variables such as player and enemy characters, defines the game board layout, and manages player input and game state.
-
Printing Functions:
print_board: Clears the screen and prints the current state of the game board along with the player's score. The score is displayed in different colors based on its value (red for low scores, green for high scores, and yellow for scores in between).
-
Movement Functions:
move_player: Handles the movement of the player character based on user input. It checks if the new position is valid (not a wall) and updates the board accordingly.
move_ghosts: Manages the movement of enemy characters (ghosts) on the game board. It calculates the optimal direction for each ghost to move closer to the player.
-
Game Over Functions:
game_over_with_timer: Handles the game over scenario when the player loses (e.g., collides with a ghost). It prompts the player to play again, return to the main menu, or quit the game.
game_over_with_victory: Displays a victory message when the player successfully collects all the food items on the board.
-
Utility Functions:
spawn_ghosts: Places ghosts at random positions on the game board.
spawn_food: Randomly generates food items on the game board.
is_valid_position: Checks if a given position is within the bounds of the game board and not occupied by a wall.
-
Menu Functions:
display_help: Displays instructions and controls for playing the game.
save_score: Allows the player to save their score by entering their name.
view_scores: Displays the highest scores achieved by players.
exit_game: Exits the script gracefully.
main_menu: Displays the main menu options and handles user input.
Main Menu:
