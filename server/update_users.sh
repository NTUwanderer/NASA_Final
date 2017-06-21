#!/bin/bash
# input: group_user_change/changes list_of_nfs distribute/modified

IFS=$'\n'

changes=$(cat "$1")

nol=$(echo "$changes" | wc -l)
# for entry in $(echo "$changes"); do
for (( count=0; $count<$nol; count=$count+1 )); do
	entry=$(echo "$changes" | sed -n "$((count+1))p")

	if [ "$entry" == "Remove" ]; then
		lines=$(echo "$changes" | sed -n "$((count+2))p")

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | sed -n "$((count+i+3))p")
			groupName=$(echo "$info" | cut -d' ' -f2)

			./remove_group.sh $groupName
		done
	fi

	if [ "$entry" == "Add" ]; then
		lines=$(echo "$changes" | sed -n "$((count+2))p")

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | sed -n "$((count+i+3))p")
			groupName=$(echo "$info" | cut -d' ' -f2)

			./add_group.sh $groupName
		done
	fi
done

nfs_servers=""
for entry in $(cat $2); do
	name=$(echo "$entry" | cut -f1 -d' ')
	nfs_servers="${nfs_servers}${name} "
done

modified=$(cat "$3")
nol=$(echo "$modified" | wc -l)
numOfNfs=$(echo "$modified" | head -n 1)

for (( count=0; $count<$nol; count=$count+1 )); do
	entry=$(echo "$modified" | sed -n "$((count+1))p")

	[ -z $entry ] && continue

	if [ $(echo $entry | cut -d' ' -f1) == "Move" ]; then
		lines=$(echo "$modified" | sed -n "$((count+1))p" | cut -d' ' -f2)

		for (( i=0; $i<$lines; i=$i+1 )); do
			temp=$(echo "$modified" | sed -n "$((count+i+2))p")
			groupAndName=$(echo "$temp" | cut -d' ' -f1)
			from=$(echo "$temp" | cut -d' ' -f2)
			to=$(echo "$temp" | cut -d' ' -f3)

			./move_user.sh $groupAndName $from $to
		done
	fi

	if [ "$entry" == "Remove" ]; then
		for (( i=0; $i<$numOfNfs; i=$i+1 )); do
			temp=$(echo "$modified" | sed -n "$((count+i+2))p")
			number=$(echo "$temp" | cut -d' ' -f1)

			IFS=' '
			if [ "$number" != "0" ]; then
				for groupAndName in $(echo "$temp" | cut -d' ' -f2-); do
					./remove_user.sh $groupAndName
				done
			fi
			IFS=$'\n'
		done
	fi

	if [ "$entry" == "Add" ]; then
		for (( i=0; $i<$numOfNfs; i=$i+1 )); do
			temp=$(echo "$modified" | sed -n "$((count+i+2))p")
			number=$(echo "$temp" | cut -d' ' -f1)
			nfs=$(echo "$nfs_servers" | cut -d' ' -f$((i+1)))

			IFS=' '
			if [ "$number" != "0" ]; then
				for groupAndName in $(echo "$temp" | cut -d' ' -f2-); do
					./add_user.sh $groupAndName $nfs
				done
			fi
			IFS=$'\n'
		done
	fi
done


