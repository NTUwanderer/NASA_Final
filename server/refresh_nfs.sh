#!/bin/bash
# input: sshname changes user_list
# Make sure the added NFS servers are running and accessible with their ips

IFS=$'\n'

changes="changes"
user_list="user_list"

scp $2 $1:~/$changes
scp $3 $1:~/$user_list

ssh $1 << EOF
	./refresh_mountpoints.sh $changes $user_list
EOF

