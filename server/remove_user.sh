#!/bin/bash
# input: list_of_nfs groupName student_id
# change baseDIR to execute in production

IFS=$'\n'

baseDIR="./"
prefix="${baseDIR}autofs/"

userdel "$3"
rm -rf "/home/$2/$3"

if [ "$1" != "none" ]; then
	for entry in $(cat $1); do
		name=$(echo "$entry" | cut -f1 -d' ')
		ip=$(echo "$entry" | cut -f2 -d' ')
		sshname=$(echo "$entry" | cut -f3 -d' ')
	
		rm -rf "${prefix}${name}/$2/$3"
	done
fi

