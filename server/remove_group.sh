#!/bin/bash
# input: list_of_nfs groupName
# change baseDIR to execute in production

IFS=$'\n'

nfsServerPath="/var/nfsshare/"
rm -rf "/home/$2"

for entry in $(cat $1); do
	sshname=$(echo "$entry" | cut -f3 -d' ')

	ssh "$sshname"
	rm -rf "${nfsServerPath}$2"
done

