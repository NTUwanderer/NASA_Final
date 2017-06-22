#!/bin/bash
# input: group_user_change/changes list_of_nfs

IFS=$'\n'

changes=$(cat "$1")

count=0
for entry in $(echo "$changes"); do
	if [ "$entry" == "Modified" ]; then
		lines=$(echo "$changes" | cut -f$((count+2)) -d$'\n')

		for (( i=0; $i<$lines; i=$i+1 )); do
			startLine=$((count+i*4+3))
			groupName=$(echo "$changes" | cut -f$((startLine)) -d$'\n')
			remove=$(echo "$changes" | cut -f$((startLine+1)) -d$'\n')
			add=$(echo "$changes" | cut -f$((startLine+2)) -d$'\n')

			IFS=' '
			for id in $(echo "$remove" | cut -d' ' -f2-); do
				./remove_user.sh "$2 $groupName $id" 
			done
			for id in $(echo "$add" | cut -d' ' -f2-); do
				./add_user.sh "$2 $groupName $id" 
			done
			IFS=$'\n'
		done
	fi

	if [ "$entry" == "Remove" ]; then
		lines=$(echo "$changes" | cut -f$((count+2)) -d$'\n')

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | cut -f$((count+i+3)) -d$'\n')
			groupName=$(echo "$info" | cut -d' ' -f2)

			IFS=' '
			for id in $(echo "$info" | cut -d' ' -f3-); do
				./remove_user.sh "none $groupName $id" 
			done

			./remove_group.sh "$2 $groupName"
			IFS=$'\n'
		done
	fi

	if [ "$entry" == "Add" ]; then
		lines=$(echo "$changes" | cut -f$((count+2)) -d$'\n')

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | cut -f$((count+i+3)) -d$'\n')
			groupName=$(echo "$info" | cut -d' ' -f2)

			IFS=' '
			for id in $(echo "$info" | cut -d' ' -f3-); do
				./add_user.sh "$2 $groupName $id" 
			done
			IFS=$'\n'
		done
	fi

	count=$((count+1))
done

# echo "$changes"

