#!/bin/bash
# input: added_list_of_nfs
# call update_autofs.sh, update_users.sh after this script

timestamp() {
	tempTimeStamp=$(date "+%Y%m%d%H%M%S")
}

timestamp

add_nfs="./add_nfs.sh"
prev_list_of_nfs_path="nfs_list/$tempTimeStamp"
list_of_nfs_path="nfs_list/current_list_of_nfs"
added_list_of_nfs_path=$1
change_nfs="exec/change_nfs.out"
prev_dist="dist/$tempTimeStamp"
dist="dist/current_dist"
modified="temp/m_$tempTimeStamp"
empty="temp/empty_file"
user_list="user_list/current_user_list"

update_autofs="update_autofs.sh"
update_users="update_users.sh"

mv $dist $prev_dist
mv $list_of_nfs_path $prev_list_of_nfs_path

$add_nfs $prev_list_of_nfs_path $added_list_of_nfs_path $change_nfs $prev_dist $dist $modified $list_of_nfs_path


$update_autofs extract_groups.sh $user_list $list_of_nfs_path

$update_users $empty $list_of_nfs_path $modified

