#!/bin/bash
# input: groupAndName 
# change baseDIR to execute in production

IFS=$'\n'

name=$(echo $1 | cut -d'/' -f2)
userdel $name

if [ -d "/home/$1" ]; then
	rm -rf "/home/$1"
fi
