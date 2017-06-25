#!/bin/bash
# input: added_list_of_nfs
# Make sure the added NFS servers are running and accessible with their ips

IFS=$'\n'

timestamp() {
	tempTimeStamp=$(date "+%Y%m%d%H%M%S")
}

timestamp

add_nfs="./add_nfs.sh"
prev_list_of_nfs_path="nfs_list/$tempTimeStamp"
list_of_nfs_path="nfs_list/current_list_of_nfs"
added_list_of_nfs_path=$1
prev_dist="dist/$tempTimeStamp"
dist="dist/current_dist"
modified="temp/m_$tempTimeStamp"
empty="temp/empty_file"
user_list="user_list/current_user_list"
empty_list="user_list/empty_list"

change_nfs="exec/change_nfs.out"
group_user_change="exec/group_user_change.out"

update_autofs="update_autofs.sh"
update_users="update_users.sh"
setup_ssh="setup_ssh.sh"
refresh_nfs="refresh_nfs.sh"

for entry in $(cat $added_list_of_nfs_path); do
	number=$(echo "$entry" | cut -f1 -d' ' | cut -f2 -d's') # Make sure name is in nfsXXX format
	ip=$(echo "$entry" | cut -f2 -d' ')
	sshname=$(echo "$entry" | cut -f2 -d' ')

	$setup_ssh $number $ip

	temp_change="temp/tc_$tempTimeStamp"
	$group_user_change $empty_list $user_list > $temp_change
	$refresh_nfs $sshname $temp_change $user_list
	
done


mv $dist $prev_dist
mv $list_of_nfs_path $prev_list_of_nfs_path

$add_nfs $prev_list_of_nfs_path $added_list_of_nfs_path $change_nfs $prev_dist $dist $modified $list_of_nfs_path


$update_autofs extract_groups.sh $user_list $list_of_nfs_path

$update_users $empty $list_of_nfs_path $modified

