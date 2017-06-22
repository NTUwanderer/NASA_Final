#!/bin/bash
# input: groupAndName nfs
# change baseDIR to execute in production

IFS=$'\n'

baseDIR="./"
prefix="${baseDIR}autofs/"
group=$(echo $1 | cut -d'/' -f1)
name=$(echo $1 | cut -d'/' -f2)

ln -s ${prefix}$2$1 /home/$group

useradd $name -b /home/$1
echo -e "${name}\n${name}\n" | passwd "$name"

