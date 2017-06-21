#!/bin/bash
# input: list_of_nfs groupName student_id
# change baseDIR to execute in production

IFS=$'\n'

baseDIR="./"
prefix="${baseDIR}autofs/"

useradd "$3" -r
echo -e "$3\n$3\n" | passwd "$3"

for entry in $(cat $1); do
	name=$(echo "$entry" | cut -f1 -d' ')
	ip=$(echo "$entry" | cut -f2 -d' ')
	sshname=$(echo "$entry" | cut -f3 -d' ')

	mkdir "${prefix}${name}/$2/$3"
done

