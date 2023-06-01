#! /bin/bash

if [[ $1 == "test" ]]; then
  PSQL="psql --username=postgres --dbname=worldcuptest"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

csv_file="./games.csv"

# Splitting teams and games insertion into two separate loops due to unknown input bugs
# This shouldn't be necessary but I am stuck in a loop where it outputs "insert 0 1" or similar
# for completed queries and these somehow end up in the query body of subsequent inserts breaking everything.

while IFS=',' read -r year round winner opponent winner_goals opponent_goals; do
  # Skip the header line
  if [[ $year == "year" ]]; then
    continue
  fi

  # Check if winner exists in the teams table
  winner_id=$($PSQL -t -c "SELECT team_id FROM teams WHERE name = '$winner';")
  if [[ -z $winner_id ]]; then
    winner_id=$($PSQL -t -c "INSERT INTO teams (name) VALUES ('$winner') RETURNING team_id;")
  fi

  # Check if opponent exists in the teams table
  opponent_id=$($PSQL -t -c "SELECT team_id FROM teams WHERE name = '$opponent';")
  if [[ -z $opponent_id ]]; then
    opponent_id=$($PSQL -t -c "INSERT INTO teams (name) VALUES ('$opponent') RETURNING team_id;")
  fi
done < "$csv_file"

# insert_games_query="INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$year', '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals);"
insert_games_query="INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES"

while IFS=',' read -r year round winner opponent winner_goals opponent_goals; do
  # Skip the header line
  if [[ $year == "year" ]]; then
    continue
  fi

  winner_id=$($PSQL -t -c "SELECT team_id FROM teams WHERE name = '$winner';")
  opponent_id=$($PSQL -t -c "SELECT team_id FROM teams WHERE name = '$opponent';")

  insert_games_query+="($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals),"

done < "$csv_file"

insert_games_query=$(echo "$insert_games_query" | sed 's/,$//')
insert_games_query+=';'

# $($PSQL "$insert_games_query")
result=$($PSQL -t -c "$insert_games_query")