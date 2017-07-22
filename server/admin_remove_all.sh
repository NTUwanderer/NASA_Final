IFS=$'\n'

timestamp() {
	tempTimeStamp=$(date "+%Y%m%d%H%M%S")
}

timestamp

execute="./execute/"

current_user_list="user_list/current_user_list"
current_dist="dist/current_dist"

new_user_list="user_list/empty"
changes="temp/changes"
modified="temp/modified"
new_dist="dist/new_dist"
extract_groups="extract_groups.sh"

list_of_nfs="nfs_list/current_list_of_nfs"

${execute}/setup_list.out < execute/inputs/empty > $new_user_list
${execute}/group_user_change.out $current_user_list $new_user_list > $changes
${execute}/distribute.out $new_user_list $current_dist $new_dist $modified

#./update_autofs.sh $extract_groups $new_user_list $list_of_nfs
./update_users.sh $changes $list_of_nfs $modified

for entry in $(cat $list_of_nfs); do
	sshname=$(echo "$entry" | cut -f3 -d' ')
	./refresh_nfs.sh $sshname $changes $new_user_list
done

prev_dist="dist/$tempTimeStamp"
prev_user_list="user_list/$tempTimeStamp"

mv $current_dist $prev_dist
mv $new_dist $current_dist

mv $current_user_list $prev_user_list
mv $new_user_list $current_user_list

