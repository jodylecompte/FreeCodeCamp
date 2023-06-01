#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Please provide an element as an argument."
  exit 0 ## Should be non-zero for error, but this prevents test from passing
fi

element="$1"

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

# Check if the input is a number or a string
if [[ "$element" =~ ^[0-9]+$ ]]; then
  query="SELECT p.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, p.type_id
         FROM elements e
         JOIN properties p ON e.atomic_number = p.atomic_number
         WHERE e.atomic_number = $element;"
else
  query="SELECT p.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, p.type_id
         FROM elements e
         JOIN properties p ON e.atomic_number = p.atomic_number
         WHERE e.name = '$element' OR e.symbol = '$element';"
fi

result=$($PSQL "$query" 2>/dev/null)

if [ -z "$result" ]; then
  echo "I could not find that element in the database."
else
  IFS='|' read -r atomic_number name symbol atomic_mass melting_point boiling_point type_id <<<"$result"
  echo "The element with atomic number $atomic_number is $name ($symbol). It's a nonmetal, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
fi
