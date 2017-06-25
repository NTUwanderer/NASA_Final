#!/bin/bash
# input: list_of_nfs, change_nfs/main.out, prev_dist, dist, modified, new list, [index of removed nfs] 
# call update_autofs.sh, update_users.sh after this script
# output list_of_nfs to newList

IFS=$'\n'

newList=$6

str="$*"
str=$(echo $str | cut -d' ' -f7-)

count=$#
count=$((count-6))

echo "$count $str" | ./$2 remove $3 $4 $5

