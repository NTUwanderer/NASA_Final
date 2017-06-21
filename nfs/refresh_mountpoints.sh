#!/bin/bash
# input: changes user_list
# Warning: it will overwrite /etc/exports

IFS=$'\n'

exportFilePath="/etc/exports"

workstationIp="192.168.100.1"

changes=$(cat "$1")

nfsServerPath="/var/nfsshare/"

nol=$(echo "$changes" | wc -l)
# for entry in $(echo "$changes"); do
for (( count=0; $count<$nol; count=$count+1 )); do
	entry=$(echo "$changes" | sed -n "$((count+1))p")
	if [ "$entry" == "Modified" ]; then
		lines=$(echo "$changes" | sed -n "$((count+2))p")

		for (( i=0; $i<$lines; i=$i+1 )); do
			startLine=$((count+i*4+3))
			groupName=$(echo "$changes" | sed -n "${startLine}p")
			remove=$(echo "$changes" | sed -n "$((startLine+1))p")
			add=$(echo "$changes" | sed -n "$((startLine+2))p")

			IFS=' '
			if [ "$remove" != "0" ]; then
				for id in $(echo "$remove" | cut -d' ' -f2-); do
					rm -rf ${nfsServerPath}${groupName}/${id} 
				done
			fi
			if [ "$add" != "0" ]; then
				for id in $(echo "$add" | cut -d' ' -f2-); do
					mkdir ${nfsServerPath}${groupName}/${id} 
				done
			fi
			IFS=$'\n'
		done
	fi

	if [ "$entry" == "Remove" ]; then
		lines=$(echo "$changes" | sed -n "$((count+2))p")

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | sed -n "$((count+i+3))p")
			groupName=$(echo "$info" | cut -d' ' -f2)

			rm -rf "${nfsServerPath}${groupName}"
		done
	fi

	if [ "$entry" == "Add" ]; then
		lines=$(echo "$changes" | sed -n "$((count+2))p")

		for (( i=0; $i<$lines; i=$i+1 )); do
			info=$(echo "$changes" | sed -n "$((count+i+3))p")
			groupName=$(echo "$info" | cut -d' ' -f2)

			mkdir ${nfsServerPath}${groupName}

			IFS=' '
			for id in $(echo "$info" | cut -d' ' -f3-); do
				mkdir ${nfsServerPath}${groupName}/${id}
			done
			IFS=$'\n'
		done
	fi
done

num=$(sed '4q;d' "$2")

exportsOutput=""
for entry in $(tail -n $num $2); do
	name=$(echo "$entry" | cut -f2 -d' ')
	exportsOutput="${exportsOutput}${nfsServerPath}${name}\t${workstationIp}(rw,sync,no_root_squash,no_all_squash)\n"
done

echo -e "$exportsOutput" > "$exportFilePath"

./restart_nfs_service.sh

