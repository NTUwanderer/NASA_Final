#!/bin/bash
# input: groupName

IFS=$'\n'

mkdir "/home/$1"
groupadd $1

