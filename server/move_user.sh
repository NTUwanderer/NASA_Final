#!/bin/bash
# input: groupAndName from to

IFS=$'\n'

prefix="/autofs/"
group=$(echo $1 | cut -d'/' -f1)
name=$(echo $1 | cut -d'/' -f2)

cp -a ${prefix}$2/$1/. ${prefix}$3/$1/
rm -rf ${prefix}$2/$1 

ln -sfn ${prefix}$3/$1 /home/$1


