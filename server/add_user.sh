#!/bin/bash
# input: groupAndName nfs nfs_servers
# change baseDIR to execute in production

IFS=$'\n'

prefix="/autofs/"
group=$(echo $1 | cut -d'/' -f1)
name=$(echo $1 | cut -d'/' -f2)

ln -s ${prefix}$2/$1 /home/$1

useradd $name -d /home/$1
echo -e "${name}\n${name}\n" | passwd "$name"
usermod -a -G $group $name

IFS=' '

for nfs in $3; do
	chown -R ${name}:${group} ${prefix}${nfs}/$1
done

