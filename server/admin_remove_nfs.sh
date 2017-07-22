#!/bin/bash
# input: [index of removed nfs] 

timestamp() {
	tempTimeStamp=$(date "+%Y%m%d%H%M%S")
}

timestamp

remove_nfs="./remove_nfs.sh"
prev_list_of_nfs_path="nfs_list/$tempTimeStamp"
list_of_nfs_path="nfs_list/current_list_of_nfs"
# added_list_of_nfs_path=$1
prev_dist="dist/$tempTimeStamp"
dist="dist/current_dist"
modified="temp/m_$tempTimeStamp"
empty="temp/empty_file"
user_list="user_list/current_user_list"

change_nfs="exec/change_nfs.out"
group_user_change="exec/group_user_change.out"

update_autofs="./update_autofs.sh"
update_users="./update_users.sh"

str="$*"
# str=$(echo $str | cut -d' ' -f2-)

mv $dist $prev_dist
mv $list_of_nfs_path $prev_list_of_nfs_path

$remove_nfs $prev_list_of_nfs_path $change_nfs $prev_dist $dist $modified $list_of_nfs_path $str


$update_autofs extract_groups.sh $user_list $list_of_nfs_path

$update_users $empty $list_of_nfs_path $modified

./r_update_nfs.sh $prev_list_of_nfs_path $list_of_nfs_path $str

