#!/bin/bash
# input: extract_groups.sh, user_list, list_of_nfs
# change baseDIR to execute in production

IFS=$'\n'

baseDIR="/"

groups=$(./$1 $2)
pathToAutofs="${baseDIR}etc/"

prefix="${baseDIR}autofs/"
nfsConfigPath="${baseDIR}etc/auto."

nfsServerPath="/var/nfsshare/"

master=$(cat ${baseDIR}etc/auto.master_backup)
masterOutput=""
for entry in $(cat $3); do
	name=$(echo "$entry" | cut -f1 -d' ')
	ip=$(echo "$entry" | cut -f2 -d' ')
	sshname=$(echo "$entry" | cut -f3 -d' ')

	masterOutput="${masterOutput}${prefix}${name}\t${nfsConfigPath}${name}\t--timeout=60\n"

	tempOutput=""
	for group in $(echo "$groups"); do
		tempOutput="${tempOutput}${group}\t-fstype=nfs4,rw,soft,intr\t${ip}:${nfsServerPath}${group}\n"
	done

	echo -e "$tempOutput" > "${nfsConfigPath}${name}"
done

echo -e "${master}\n${masterOutput}" > "${pathToAutofs}auto.master"

systemctl restart autofs

