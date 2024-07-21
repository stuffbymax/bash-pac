#!/bin/bash

# Color variables
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
txtrst='\e[0m'    # Text Reset

# Function to display the animation
function display_animation() {
  clear
  echo "G    C"
  sleep 0.3
  clear
  echo "G   C"
  sleep 0.3
  clear
  echo "G  C"
  sleep 0.3
  clear
  echo "G  C"
  sleep 0.3
  clear
  echo "G C"
  sleep 0.3
  clear
  echo "GC"
  sleep 0.3
  clear
  echo "GC."
  sleep 0.3
  clear
  echo -e "${txtgrn}bash-pac v1.2.1 CZ S${txtrst}"
  sleep 0.4
  clear
}

# Start the animation
display_animation

# Function to spawn additional enemies when the player collects food
function spawn_enemy() {
  ghost_row=$((RANDOM % (${#board[@]} - 2) + 1))
  ghost_col=$((RANDOM % (${#board[0]} - 2) + 1))
  board[$ghost_row]=${board[$ghost_row]:0:$ghost_col}$ghost${board[$ghost_row]:$((ghost_col + 1))}
}

# Function to start the game
function start_game() {
  

  # Initialize variables
  player="C"
  ghost="G"
  empty=" "
  wall="#"
  food="."
  score=0
  food_collected=0  # Variable to track the number of food items collected by the player

  # Define the game board
  declare -a board=(
    "#######################################"
    "#C                                    #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#######################################"
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
      if [[ ${board[$new_row]:$new_col:1} == "$ghost" ]]; then
        player_died=true  # Set player_died flag to true if the player collides with the ghost
        return
      fi
      
      if [[ ${board[$new_row]:$new_col:1} == "$food" ]]; then
        ((score++))
        ((food_collected++))
        if ((food_collected == 2)); then
          spawn_enemy  # Spawn enemy when the player collects 2 food items
          food_collected=0  # Reset the food collected counter
        fi
      fi
      board[$player_row]=${board[$player_row]:0:$player_col}$empty${board[$player_row]:$((player_col + 1))}
      player_row=$new_row
      player_col=$new_col
      board[$player_row]=${board[$player_row]:0:$player_col}$player${board[$player_row]:$((player_col + 1))}
    fi
  }

  # Function to move the ghosts
  function move_ghosts() {
    for ((i = 0; i < ${#board[@]}; i++)); do
      for ((j = 0; j < ${#board[0]}; j++)); do
        if [[ ${board[$i]:$j:1} == "$ghost" ]]; then
          local player_distance=1000
          local next_row=$i
          local next_col=$j

          local dirs=(-1 0 1 0 0 -1 0 1)

          # Find the direction that minimizes distance to the player
          for ((dir = 0; dir < 4; dir++)); do
            local dr=$((i + dirs[dir * 2]))
            local dc=$((j + dirs[dir * 2 + 1]))
            local dist=$(( (player_row - dr) ** 2 + (player_col - dc) ** 2 ))
            if [[ $dist -lt $player_distance ]]; then
              player_distance=$dist
              next_row=$dr
              next_col=$dc
            fi
          done

          # Move the ghost if the next position is not a wall or food
          if is_valid_position $next_row $next_col && [[ ${board[$next_row]:$next_col:1} != "$wall" && ${board[$next_row]:$next_col:1} != "$food" ]]; then
            board[$i]=${board[$i]:0:$j}$empty${board[$i]:$((j + 1))}
            board[$next_row]=${board[$next_row]:0:$next_col}$ghost${board[$next_row]:$((next_col + 1))}
          fi
        fi
      done
    done
  }

  # Function to spawn ghosts at random positions
  function spawn_ghosts() {
    ghost_row=$((RANDOM % (${#board[@]} - 2) + 1))
    ghost_col=$((RANDOM % (${#board[0]} - 2) + 1))
    board[$ghost_row]=${board[$ghost_row]:0:$ghost_col}$ghost${board[$ghost_row]:$((ghost_col + 1))}
  }

  # Function to spawn food at random positions
  function spawn_food() {
    local row
    local col
    local num_food=20  # Adjust the number of food items here
    for ((i = 0; i < num_food; i++)); do
      row=$((RANDOM % (${#board[@]} - 2) + 1))
      col=$((RANDOM % (${#board[0]} - 2) + 1))
      if [[ ${board[$row]:$col:1} == "$empty" ]]; then
        board[$row]=${board[$row]:0:$col}$food${board[$row]:$((col + 1))}
      fi
    done
  }

# Function to check if the game is over with a timer
function game_over_with_timer() {
  print_board
  local answer
  while true; do
    # Print the message in red
    echo -e "${txtred}Zemřel jsi! Stiskněte 'ano' pro opětovné přehrávání, 'ne' pro ukončení nebo ${txtgrn}'O' pro návrat do hlavní nabídky: ${txtrst}"
    read -p "" answer
    if [[ "$answer" == "ano" || "$answer" == "ne" ]]; then
      break
    elif [[ "$answer" == "O" || "$answer" == "o" ]]; then
      save_score
	  main_menu
      break
    else
      echo "Zadejte prosím 'ano' 'ne' nebo xO' pro návrat do hlavní nabídky"
    fi
  done

  if [ "$answer" == "ano" ]; then
    reset_game
  elif [ "$answer" == "ne" ]; then
    save_score  # Save the player's score if they choose to quit
    echo "Naschle!"
    exit
  fi
}

  # Function to display the victory message
  function game_over_with_victory() {
    print_board
    echo -e "${txtgrn}gratuluji! You collected all the food. Sesbíral jsi všechno jídlo. Vyhráváte!${txtrst}"
    read -p "Stisknutím klávesy Enter se vrátíte do hlavní nabídky nebo zadejte 'exit' pro ukončení:" answer
    if [ "$answer" == "" ]; then
      main_menu
    elif [ "$answer" == "exit" ]; then
      echo "${txtgrn}Naschle!{txtrst}"
      exit
    else
      echo "Neplatný vstup. Návrat do hlavní nabídky."
      main_menu
    fi
  }

  # Function to reset the game
  function reset_game() {
    player_row=1
    player_col=1
    score=0
    food_collected=0
    board=(
    "#######################################"
    "#C                                    #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#                                     #"
    "#######################################"
    )
    spawn_ghosts
    spawn_food
    player_died=false  # Reset the player_died flag
  }

  # Initialize player position
  player_row=1
  player_col=1

  # Initialize enemy directions
  dirs=(-1 0 1 0 0 -1 0 1)

  # Spawn ghosts
  spawn_ghosts

  # Spawn food
  spawn_food

  # Flag to track if the player has died
  player_died=false

   # Main game loop
while true; do
  print_board

  # Read user input
  read -rsn1 direction

  # Move player based on input
  case $direction in
    "A") move_player -1 0 ;; # Up arrow
    "B") move_player 1 0 ;;  # Down arrow
    "D") move_player 0 -1 ;; # Left arrow
    "C") move_player 0 1 ;;  # Right arrow
    "w") move_player -1 0 ;;
    "s") move_player 1 0 ;;
    "a") move_player 0 -1 ;;
    "d") move_player 0 1 ;;
    "q") echo "Goodbye!"; exit ;;
    "o") main_menu ;;
    *) ;;
  esac

  # Move ghosts
  move_ghosts

  # Check if the player is dead after moving the ghosts
  if [[ ${board[$player_row]:$player_col:1} == "$ghost" ]]; then
    player_died=true
  fi

  # Check if the player is dead
  if $player_died; then
    game_over_with_timer
  fi

  # Check if all food is collected
  if [[ $(grep -o "$food" <<< "${board[*]}") == "" ]]; then
    game_over_with_victory
  fi
done

}

# Function to display help information
function display_help() {
  clear
  
  echo "vyrobil by stuffbymax"
   echo "-------------------"
   echo -e " ${txtgrn}verze${txtrst}"
   echo -e "${txtgrn}bash-pac v1.2.1 S${txtrst}"
   echo "--------------------"
   echo -e "${txtblu}Pokyny ke hře${txtrst}"
   echo "-------------------"
   echo -e "${txtblu}Postava hráče: (C)${txtrst}"
   echo
   echo -e "${txtblu}Vyhýbejte se duchům (G) při sbírání jídla (.), abyste zvýšili své skóre.${txtrst}"
   echo
   echo -e "${txtylw}Ovládací prvky:${txtrst}"
   echo "-------------------"
   echo -e "${txtylw}W: Přesunout nahoru${txtrst}"
   echo -e "${txtylw}A: Pohyb doleva${txtrst}"
   echo -e "${txtylw}S: Přesunout dolů${txtrst}"
   echo -e "${txtylw}D: Přesunout doprava${txtrst}"
   echo
   echo -e "${txtpur}Zkratky ve hře:${txtrst}"
   echo "-------------------"
   echo -e "${txtpur}Q: ukonči bash-pac${txtrst}"
   echo -e "${txtpur}o: Návrat do hlavní nabídky${txtrst}"
   echo "--------------------------"
   echo -e "${txtgrn}Green děkuji za stažení ${txtrst}"
   echo "--------------------------"
   echo "Pokračujte stisknutím klávesy Enter..."
  read -r
}
# After the game_over_with_victory() function

# Function to save the player's score
function save_score() {
  echo "napište jmeno: "
  read player_name
  echo "$player_name $score" >> scores.txt
}

# Function to view scores
function view_scores() {
  clear
  echo -e "${txtblu}vaše Score:${txtrst}"
  echo "------------------"
  # Sort scores and display
  sort -r -k 2 scores.txt | head -n 10
  echo "------------------"
  read -p "Stisknutím klávesy Enter se vrátíte do hlavní nabídky..." enter
}

# Function to exit the script
function exit_game() {
  echo "Naschle!"
  exit
}

# Function to display the main menu
function main_menu() {
  while true; do
    # Main menu
    clear
    echo -e "${txtcyn}Možnosti:${txtrst}"
    echo -e "${txtblu}1. Start${txtrst}"
    echo -e "${txtylw}2. pomoc${txtrst}"
    echo -e "${txtred}3. Zobrazit skóre${txtrst}"
    echo -e "${txtred}4. Konec${txtrst}"

    # Wait for any key press
    read -n 1 key

    # Read user input for option
    read -n 1 option

 case $option in
      "1") start_game ;;
      "2") display_help ;;
      "3") view_scores ;;
      "4") exit_game ;;
      *) ;;
    esac
  done
}

# Start the main menu
main_menu
