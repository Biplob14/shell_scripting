#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu"* ]]
then
    echo "linux"
elif [[ "$OSTYPE" == "win32" ]]; then
    echo "windows"
elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "OSX"
elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "POSIX compatibility layer and Linux environment emulation for Windows"
elif [[ "$OSTYPE" == "msys" ]]; then
        echo "Lightweight shell and GNU utilities compiled for Windows (part of MinGW)"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "free BSD"
else
        echo "OS not detected"
fi


############################### ANOTHER WAY ###############################

echo -e "\n~~ OS type ~~\n"
# OSTYPE is a predefined variable
case "$OSTYPE" in
    solaris*) echo "SOLARIS" ;;
    darwin*)  echo "OSX" ;; 
    linux*)   echo "LINUX" ;;
    bsd*)     echo "BSD" ;;
    msys*)    echo "WINDOWS" ;;
    cygwin*)  echo "ALSO WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac
