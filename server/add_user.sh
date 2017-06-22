#!/bin/bash
# input: groupAndName nfs
# change baseDIR to execute in production

IFS=$'\n'

prefix="/autofs/"
group=$(echo $1 | cut -d'/' -f1)
name=$(echo $1 | cut -d'/' -f2)

ln -s ${prefix}$2/$1 /home/$1

useradd $name -b /home/$group
echo -e "${name}\n${name}\n" | passwd "$name"

