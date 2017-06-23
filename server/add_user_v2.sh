#!/bin/bash
useradd $1 -d /home/b03/$1
echo -e "$1\n$1\n" | passwd $1
rm -rf /home/b03/$1
mkdir /autofs/nfs1/b03902/$1
ln -s /autofs/nfs1/b03902/$1 /home/b03/$1
chown $1 /autofs/nfs1/b03902/$1
