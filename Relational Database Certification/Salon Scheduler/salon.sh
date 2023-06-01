#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

while true; do
    query_result=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id ASC")

    count=1
    while IFS='|' read -r id name; do
        echo "$count) $name"
        ((count++))
    done <<< "$query_result"

    echo "Enter a service ID:"
    read -r SERVICE_ID_SELECTED

    valid_id=false
    while IFS='|' read -r id _; do
        if [[ "$id" == "$SERVICE_ID_SELECTED" ]]; then
            valid_id=true
            break
        fi
    done <<< "$query_result"

    if [[ "$valid_id" == "true" ]]; then
        break
    fi
done

echo "Enter your phone number:"
read -r CUSTOMER_PHONE

# Check if customer exists
customer_id=""
customer_exists=false
customer_exists=$($PSQL "SELECT EXISTS(SELECT 1 FROM customers WHERE phone = '$CUSTOMER_PHONE')")

if [[ "$customer_exists" == "f" ]]; then
    echo "Enter your name:"
    read -r CUSTOMER_NAME


    $PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')" > /dev/null
    customer_id=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    customer_id=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
fi

echo "Enter the appointment time:"
read -r SERVICE_TIME

$PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($customer_id, $SERVICE_ID_SELECTED, '$SERVICE_TIME')" > /dev/null

service_name=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

echo "I have put you down for a $service_name at $SERVICE_TIME, $CUSTOMER_NAME."