#!/bin/bash
# input: list_of_nfs, new list, [index of removed nfs] 
# output list_of_nfs to newList

IFS=$'\n'

newList=$2

str="$*"
str=$(echo $str | cut -d' ' -f3-)

count=$#
count=$((count-2))

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

