#!/bin/bash
# input: list_of_nfs, added_list_of_nfs, change_nfs/main.out, prev_dist, dist, modified
# call update_autofs.sh, update_users.sh after this script

IFS=$'\n'

newList="new_list_of_nfs"

list_of_nfs=$(cat $1)
added_list_of_nfs=$(cat $2)
conflicted=false

for entry in $(echo "$list_of_nfs"); do
	name=$(echo "$entry" | cut -f1 -d' ')

	for entry2 in $(echo $added_list_of_nfs); do
		name2=$(echo "$entry2" | cut -f1 -d' ')

		
		if [ "$name" == "$name2" ]; then
			conflicted=true
			break
		fi
	done

	if [ $conflicted == true ]; then
		break
	fi
done

if [ $conflicted == true ]; then
	echo "Name of one of added conflicts to an original one"
	exit 1
fi

numAdded=0
for entry in $(echo "$added_list_of_nfs"); do
	numAdded=$((numAdded+1))
done

echo "$numAdded" | ./$3 add $4 $5 $6

if [ -f $newList ]; then
	rm $newList
fi

for entry in $(echo "$list_of_nfs"); do
	echo $entry >> $newList
done

for entry in $(echo "$added_list_of_nfs"); do
	echo $entry >> $newList
done

