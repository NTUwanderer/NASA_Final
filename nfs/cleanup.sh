#!/bin/bash
# Warning: it will cleanup /etc/exports and /var/nfsshare

IFS=$'\n'

exportFilePath="/etc/exports"

nfsServerPath="/var/nfsshare/"

rm -rf $exportFilePath

rm -rf ${nfsServerPath}*

