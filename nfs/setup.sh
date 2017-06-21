dhclient -v
yum install -y vim git gcc-c++ make systemd-networkd autofs
git clone https://github.com/NTUwanderer/NASA_Final

yum install -y nfs-utils
mkdir /var/nfsshare
chmod -R 777 /var/nfsshare/
echo "/var/nfsshare 192.168.100.1(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --reload

yum install -y openssh-server
systemctl start sshd
systemctl enable sshd
mkdir ~/.ssh

