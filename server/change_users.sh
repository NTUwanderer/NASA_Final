#!/usr/bin/bash

# Input: modified_user_list old_user_list old_distribution list_of_nfs 

if [ $# -lt 4 ]; then
	echo "Usage: modified_user_list old_user_list old_distribution list_of_nfs "
	exit 1
fi

IFS=$'\n'
nuser=$1
ouser=$2
odist=$3
nfsList=$4
ndist="dist/dist$(date "+%Y%m%d%H%M%S")"


# Figure out changes
distribute/main.out $nuser $odist distribute/dist distribute/modified
group_user_change/main.out $ouser $nuser > group_user_change/changes

# Update on NFS side
for line in $(cat ${nfsList}); do
	nfsIP=$(echo $line | cut -d' ' -f2)
	sshpass -p root scp group_user_change/changes root@${nfsIP}:~/changes
	sshpass -p root scp $nuser root@${nfsIP}:~/user_list
	sshpass -p root ssh root@${nfsIP} 'cd ~/NASA_Final/nfs; ./refresh_mountpoints.sh ~/changes ~/user_list'
done

# Update on workstation side
./update_autofs.sh extract_groups.sh $nuser $nfsList
./update_users.sh group_user_change/changes $nfsList distribute/modified
cp distribute/dist $ndist
