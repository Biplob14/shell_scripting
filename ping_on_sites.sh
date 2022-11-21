#!/bin/bash
for x in google.com facebook.com yahoo.com w3schools.com;
do
    if ping -q -c 2 -w 1 $x > /dev/null; then
        echo "$X is up"
    else
        echo "$x id down"
    fi
done