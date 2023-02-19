#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
SERVICES=$($PSQL "SELECT service_id, name FROM services")


MAIN_MENU(){
  # show error for wrong service choice
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  # show available services
  echo "$SERVICES" | while read SERVICE_ID BAR NAME; 
    do
      echo -e "$SERVICE_ID) $NAME"
    done
  # read service choice from user
  echo "Which service you want today?"
  read SERVICE_ID_SELECTED
  VALID_SERVICE=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  # validate service selected
  if [[ -z $VALID_SERVICE ]]
  then
    MAIN_MENU "Service not found"
  else
    echo -e "Enter your phone number:"
    read CUSTOMER_PHONE
    # read customer exists or not
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    # check if phone number exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "Please enter your name"
      read CUSTOMER_NAME
      ENTER_INTO_DB=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
      echo "What time would you like your $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
      read SERVICE_TIME
      # update appointment schedule
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      APPOINTMENT_INCLUSION=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
    else
      echo "phone number old"
    fi
  fi

}

MAIN_MENU
