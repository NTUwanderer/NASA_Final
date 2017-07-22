#!/bin/bash
# input: sshname changes user_list
# Make sure the added NFS servers are running and accessible with their ips

IFS=$'\n'

sh_path="/root/NASA_Final/nfs/"
changes="changes"
user_list="user_list"
passphrase=$1

scp $2 $1:${sh_path}$changes
scp $3 $1:${sh_path}$user_list

ssh $1 << EOF
	cd $sh_path
	./refresh_mountpoints.sh $changes $user_list
EOF

