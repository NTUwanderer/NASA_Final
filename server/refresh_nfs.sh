#!/bin/bash
# input: sshname changes user_list
# Make sure the added NFS servers are running and accessible with their ips

IFS=$'\n'

changes="changes"
user_list="user_list"
rootpass="root"

sshpass -p $rootpass scp $2 $1:~/$changes
sshpass -p $rootpass scp $3 $1:~/$user_list

sshpass -p $rootpass ssh $1 << EOF
	./refresh_mountpoints.sh $changes $user_list
EOF

