#!/bin/bash
# input user_list

IFS=$'\n'

num=$(sed '4q;d' "$1")

for entry in $(tail -n $num $1); do
	name=$(echo "$entry" | cut -f2 -d' ')
	echo "$name"
done
