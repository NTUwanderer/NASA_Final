#!/bin/bash
# input: list_of_nfs, change_nfs/main.out, prev_dist, dist, modified, [index of removed nfs] 
# call update_autofs.sh, update_users.sh after this script
# output list_of_nfs to newList

IFS=$'\n'

newList="new_list_of_nfs"

str="'$*"
str=$(echo $str | cut -d' ' -f6-)

count=$#
count=$((count-5))

echo "$count $str" | ./$2 remove $3 $4 $5

if [ -f $newList ]; then
	rm $newList
fi

index=0
for entry in $(cat $1); do
	flag=true

	IFS=' '

	for num in $(echo $str); do
		if [ "$index" == "$num" ]; then
			flag=false
			break
		fi
	done

	if [ $flag == true ]; then
		echo $entry >> $newList
	fi

	IFS=$'\n'

	index=$((index+1))
done

