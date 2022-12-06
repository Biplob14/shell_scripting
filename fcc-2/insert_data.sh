#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# remove all data
echo $($PSQL "TRUNCATE games, teams")
# reset id seq to 1
echo $($PSQL "ALTER SEQUENCE teams_team_id_seq restart with 1")
echo $($PSQL "ALTER SEQUENCE games_game_id_seq restart with 1")

# insert country list
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL
do
  if [[ $YEAR != "year" ]]
  then
    WINNER_EXIST=$($PSQL "SELECT * FROM teams WHERE name='$WINNER'")
    # echo "team: $"
    if [[ -z $WINNER_EXIST ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # echo "win: $WINNER"
    fi
    
    OPPONENT_EXIST=$($PSQL "SELECT * FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_EXIST ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      # echo "country: $OPPONENT"
    fi

  fi
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL
do
  if [[ $YEAR != "year" ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    GAME_DATA=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOAL, $OPPONENT_GOAL)")
    echo "Inserted data: $GAME_DATA"
  fi
done