#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"

# Prompt the user for a username
echo "Enter your username:"
read USERNAME

# Check if the username exists in the database
result=$($PSQL "SELECT count(*) FROM users WHERE username = '$USERNAME'")

if [[ $result -eq 0 ]]; then
  # User doesn't exist, insert a new record
  USER_ID=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME') RETURNING user_id")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # User exists, retrieve their game statistics
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  GAMES_PLAYED=$($PSQL "SELECT count(*) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id = $USER_ID")

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Generate a random number between 1 and 1000
SECRET_NUMBER=$((1 + RANDOM % 1000))

# Initialize variables
NUMBER_OF_GUESSES=0
GUESSED=false

# Start the game loop
echo "Guess the secret number between 1 and 1000:"
while [[ $GUESSED == false ]]; do
  # Prompt for a guess
  read -r GUESS

  # Check if the guess is an integer
  if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))

  if [[ $GUESS -eq $SECRET_NUMBER ]]; then
    # Correct guess
    GUESSED=true
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    # Store the game information in the database
    $PSQL "INSERT INTO games (user_id, guesses) VALUES ($USER_ID, $NUMBER_OF_GUESSES)"
  elif [[ $GUESS -lt $SECRET_NUMBER ]]; then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
done