#! /bin/bash
# shabang to specify interpreter
echo -e "\n ~~ Bacis scripting syntax ~~ \n"

# VARIABLES
Uppercase by convention
 Letters, numbers, underscores
NAME="John"
echo "My name is $NAME"
echo "My name is ${NAME}"

# USER INPUT
read -p "Enter your name: " NAME
echo "Hello $NAME, nice to meet you!"

# ELSE IF STATEMENT
if [ "$NAME" == "John" ]
then
    echo "Welcome John"
elif [ "$NAME" == "Jack" ]
then
    echo "Welcome Jack"
else
    echo "You are unknown"
fi

# COMPARISON
###############
# val1 -eq val2 Returns true if the values are equal
# val1 -ne val2 Returns true if the values are not equal
# val1 -gt val2 Returns true if val1 is greater than val2
# val1 -ge val2 Returns true if val1 is greater than or equal to val2
# val1 -lt val2 Returns true if val1 is less than val2
# val1 -le val2 Returns true if val1 is less than or equal to val2
###############
NUM1=31
NUM2=5
if [ "$NUM1" -gt "$NUM2"]
then
    echo "$NUM1 is greater than $NUM2"
else
    echo "$NUM1 is less than $NUM2"
fi

# FILE CONDITIONS
##################
# -d file   True if the file is a directory
# -e file   True if the file exists (note that this is not particularly portable, thus -f is generally used)
# -f file   True if the provided string is a file
# -g file   True if the group id is set on a file
# -r file   True if the file is readable
# -s file   True if the file has a non-zero size
# -u    True if the user id is set on a file
# -w    True if the file is writable
# -x    True if the file is an executable
##################
FILE="test.txt"
if [ -e "$FILE" ]
then
    echo "$FILE exists"
else
    echo "$FILE does not exist"
fi

# CASE STATEMENT
read -p "Are you 21 or over? Y/N " ANSWER
case "$ANSWER" in
  [yY] | [yY][eE][sS])
    echo "You can have a drink :)"
    ;;
  [nN] | [nN][oO])
    echo "Sorry, no drinking for you :("
    ;;
  *)
    echo "Please enter y/yes or n/no"
    ;;
esac

# SIMPLE FOOR LOOP
NAMES="Brad Kevin Alice Mark"
for NAME in $NAMES
  do
    echo "Hello $NAME"
done

# FOR LOOP TO RENAME FILES
FILES=$(ls *.txt)
NEW="new"
for FILE in $FILES
    do
        echo "Renaming $FILE to new-$FILE"
        mv $FILE $NEW-$FILE
done

# RENAME FILE IF EXIST
FILE="1.txt"
if [ -e "$FILE" ]
then
    echo "$FILE exists"
    mv $FILE "new"-$FILE
else
    echo "$FILE does not exist"
fi

# WHILE LOOP - READ THROUGH A FILE LINE BY LINE
LINE=1
while read -r CURRENT_LINE
    do
        echo "$LINE: $CURRENT_LINE"
        ((LINE++))
done < "./test.txt"

# FUNCTION WITH PARAMS
function sayHello(){
    echo "hello there, $1"
    echo "Hope you're $2"
}

sayHello "Neil" "fine"