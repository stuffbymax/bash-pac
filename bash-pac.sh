#!/bin/bash

# Function to start the game
function start_game() {
  clear
  # Pac-Man clone in Bash

  # Initialize variables
  player="C"
  ghost="G"
  empty=" "
  wall="#"
  food="."
  score=0

  # Define the game board
  declare -a board=(
    "#################"
    "#P..............#"
    "#.....###.......#"
    "#.....# ........#"
    "#.....###.......#"
    "#...............#"
    "#...............#"
    "#################"
  )

  # Function to print the game board
  function print_board() {
    clear
    for row in "${board[@]}"; do
      echo "$row"
    done
    echo "Score: $score"
  }

  # Function to check if a given position is valid on the board
  function is_valid_position() {
    local row=$1
    local col=$2
    [[ $row -ge 0 && $row -lt ${#board[@]} && $col -ge 0 && $col -lt ${#board[0]} ]]
  }

  # Function to move the player
  function move_player() {
    local new_row=$((player_row + $1))
    local new_col=$((player_col + $2))

    if is_valid_position $new_row $new_col && [[ ${board[$new_row]:$new_col:1} != "$wall" ]]; then
      if [[ ${board[$new_row]:$new_col:1} == "$food" ]]; then
        ((score++))
      fi
      board[$player_row]=${board[$player_row]:0:$player_col}$empty${board[$player_row]:$((player_col + 1))}
      player_row=$new_row
      player_col=$new_col
      board[$player_row]=${board[$player_row]:0:$player_col}$player${board[$player_row]:$((player_col + 1))}
    fi
  }

  # Function to move the ghosts
  function move_ghosts() {
    local player_distance=100
    local next_row=$ghost_row
    local next_col=$ghost_col

    local dirs=(-1 0 1 0 0 -1 0 1)

    # Find the direction that minimizes distance to the player
    for ((dir=0;dir<4;dir++)); do
      local dr=$((ghost_row + dirs[dir * 2]))
      local dc=$((ghost_col + dirs[dir * 2 + 1]))
      local dist=$(( (player_row - dr) ** 2 + (player_col - dc) ** 2 ))
      if [[ $dist -lt $player_distance ]]; then
        player_distance=$dist
        next_row=$dr
        next_col=$dc
      fi
    done

    # Move the ghost
    if is_valid_position $next_row $next_col && [[ ${board[$next_row]:$next_col:1} != "$wall" ]]; then
      board[$ghost_row]=${board[$ghost_row]:0:$ghost_col}$empty${board[$ghost_row]:$((ghost_col + 1))}
      ghost_row=$next_row
      ghost_col=$next_col
      board[$ghost_row]=${board[$ghost_row]:0:$ghost_col}$ghost${board[$ghost_row]:$((ghost_col + 1))}
    fi
  }

  # Function to spawn ghosts in the middle
  function spawn_ghosts() {
    ghost_row=3
    ghost_col=10
    board[$ghost_row]=${board[$ghost_row]:0:$ghost_col}$ghost${board[$ghost_row]:$((ghost_col + 1))}
  }

  # Function to check if the game is over with a timer
  function game_over_with_timer() {
    print_board
    local answer
    while true; do
      read -p "You died! Do you want to restart? (yes/no): " answer
      if [[ "$answer" == "yes" || "$answer" == "no" ]]; then
        break
      else
        echo "Please type 'yes' or 'no'"
      fi
    done

    if [ "$answer" == "yes" ]; then
      reset_game
    else
      echo "Goodbye!"
      exit
    fi
  }

  # Function to reset the game
  function reset_game() {
    player_row=1
    player_col=1
    score=0
    board=(
      "#################"
      "#P..............#"
      "#.....###.......#"
      "#.....# ........#"
      "#.....###.......#"
      "#...............#"
      "#...............#"
      "#################"
    )
    spawn_ghosts
  }

  # Initialize player position
  player_row=1
  player_col=1

  # Initialize enemy directions
  dirs=(-1 0 1 0 0 -1 0 1)

  # Spawn ghosts
  spawn_ghosts

  # Flag to track if the player has died
  player_died=false

  # Main game loop
  while true; do
    print_board

    # Read user input
    read -rsn1 direction

    # Move player based on input
    case $direction in
      "w") move_player -1 0 ;;
      "s") move_player 1 0 ;;
      "a") move_player 0 -1 ;;
      "d") move_player 0 1 ;;
      "q") echo "Goodbye!"; exit ;;
      *) ;;
    esac

    # Move ghosts
    move_ghosts

    # Check if the player is dead
    if $player_died; then
      game_over_with_timer
    fi

    # Check if the player is dead after the move
    if [[ ${board[$player_row]:$player_col:1} == "$ghost" ]]; then
      player_died=true
    fi
  done
}

# Function to display help information
function display_help() {
  clear
  echo "Game Instructions"
  echo "------------------"
  echo "Player character: P"
  echo
  echo "Avoid the ghost (G) while collecting food (.) to increase your score."
  echo
  echo "Controls:"
  echo "------------------"
  echo "W: Move Up"
  echo "A: Move Left"
  echo "S: Move Down"
  echo "D: Move Right"
  echo
  echo "In-game shortcuts:"
  echo "------------------"
  echo "Q: Exit full terminal"
  echo "Ctrl: Exit only the program"
  echo "Tap: Return to the main menu"
  echo
  echo "Press Enter to continue..."
  read -r
}

# Function to exit the script
function exit_game() {
  echo "Goodbye!"
  exit
}

# Main menu loop
while true; do
  # Main menu
  clear
  echo "Options:"
  echo "1. Start"
  echo "2. Help"
  echo "3. Exit"

  # Wait for any key press
  read -n 1 key

  # Read user input for option
  read -n 1 option

  case $option in
    "1") start_game ;;
    "2") display_help ;;
    "3") exit_game ;;
    *) ;;
  esac
done

