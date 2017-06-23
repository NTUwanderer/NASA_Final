#!/bin/bash
# input: list_of_nfs, change_nfs/main.out, prev_dist, dist, modified, [index of removed nfs] 
# call update_autofs.sh, update_users.sh after this script
# output list_of_nfs to newList

IFS=$'\n'

newList="new_list_of_nfs"

nfs_servers=""
numOfNfs=0
for entry in $(cat $1); do
	name=$(echo "$entry" | cut -f1 -d' ')
	nfs_servers="${nfs_servers}${name} "
	numOfNfs=$((numOfNfs+1))
done

str="'$*"
str=$(echo $str | cut -d' ' -f6-)

count=$#
count=$((count-5))

echo "$count $str" | ./$2 remove $3 $4 $5

if [ -f $newList ]; then
	rm $newList
fi

index=0
zero=0
for entry in $(cat $1); do
	flag=0

	IFS=' '

	for num in $(echo $str); do
		if [ "$index" == "$num" ]; then
			flag=$((flag+1))
		fi
	done

	if [ "$flag" == "$zero" ]; then
		echo $entry >> $newList
	fi

	IFS=$'\n'

	index=$((index+1))
done


