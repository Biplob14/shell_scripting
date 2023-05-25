#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#RECIEVING A USER NAME
echo "Enter your username:"
read -n 22 USER_NAME 
#echo -e "\nUSER NAME:$USER_NAME" 

NAME_IN_DB=$($PSQL "SELECT user_name FROM users WHERE user_name='$USER_NAME'")
#echo $NAME_IN_DB

if [[ -z $NAME_IN_DB ]]
  then
    echo "Welcome, $USER_NAME! It looks like this is your first time here."
    QUERY_RESULT=$($PSQL "INSERT INTO users(user_name) VALUES('$USER_NAME') ")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
  else
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
    GAMES_COUNT=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    BEST_GAME_GUESS_COUNT=$($PSQL "SELECT MIN(guesses_ig) FROM games WHERE user_id=$USER_ID")
    if [[ ! -z $BEST_GAME_GUESS_COUNT ]]
      then
        echo "Welcome back, $USER_NAME! You have played $GAMES_COUNT games, and your best game took $BEST_GAME_GUESS_COUNT guesses."
    fi
fi



#Generate a random number from 1 to 100
GEN_NUMBER=$(( $RANDOM % 1000 + 1 ))
#GEN_NUMBER=$(( $RANDOM % 10 + 1 ))
#echo $GEN_NUMBER
GUESS_COUNT=0

#input a number from user
echo "Guess the secret number between 1 and 1000: "
read GUESSED_NUMBER






while [ $GEN_NUMBER != $GUESSED_NUMBER ]
 do
   if [[ ! $GUESSED_NUMBER =~ ^[0-9]++++$ ]]
    then
     echo "That is not an integer, guess again: "
    else
     (( GUESS_COUNT++ ))
     if [[ $GUESSED_NUMBER -gt $GEN_NUMBER ]]
      then
        echo "It's lower than that, guess again: "
      elif [[ $GUESSED_NUMBER -lt $GEN_NUMBER ]]
       then
         echo "It's higher than that, guess again: "
      fi
    fi
  read GUESSED_NUMBER
done
(( GUESS_COUNT++ ))


USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
INSERT_RESULT=$($PSQL "INSERT INTO games (user_id, guesses_ig) values ('$USER_ID', $GUESS_COUNT)")
#finish the game
echo "You guessed it in $GUESS_COUNT tries. The secret number was $GEN_NUMBER. Nice job! "