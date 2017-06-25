# input number ip

rootpass="root"
ssh-keygen -b 4096 -t rsa -C "nfs$1" -N nasa-nfs"$1" -f ~/.ssh/id_rsa"$1"
sshpass -p $rootpass scp ~/.ssh/id_rsa"$1".pub root@"$2":~/.ssh/
sshpass -p $rootpass ssh root@"$2" << EOF
	cat ~/.ssh/id_rsa"$1".pub >> ~/.ssh/authorized_keys
	echo -e "\n" >> ~/.ssh/authorized_keys
	rm ~/.ssh/id_rsa"$1".pub
	restorecon -Rv ~/.ssh
	systemctl restart sshd
EOF

echo -e "Host nasa-nfs$1\n\tHostName $2\n\tUser root\n\tIdentityFile ~/.ssh/id_rsa$1\n\n" >> ~/.ssh/config
