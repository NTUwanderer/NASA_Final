#!/bin/bash
# input: groupName

IFS=$'\n'

rm -rf "/home/$1"
groupdel $1

