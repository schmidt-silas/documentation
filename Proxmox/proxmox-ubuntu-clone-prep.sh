 #!/bin/bash

#
# Adapted from
# https://www.reddit.com/r/Proxmox/comments/plct2v/are_there_any_current_guides_on_templatingcloning/
#

set -e

id
if [ "$(id -u)" -ne 0 ]; then
	echo "Script must be run as root"
	exit 1
fi

cd /tmp

#remove previous cloudinit
rm -Rf /var/lib/cloud
rm -Rf /etc/cloud/cloud.cfg.d/*installer.cfg
echo "datasource_list: [ NoCloud, ConfigDrive ]" > /etc/cloud/cloud.cfg.d/99_pve.cfg

#update apt-cache
apt-get update

#install packages
apt-get install -y qemu-guest-agent stty

#flush the logs
logrotate -f /etc/logrotate.conf

#stop services for cleanup
service rsyslog stop

#clear audit logs
if [ -f /var/log/audit/audit.log ]; then
    cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
    cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    cat /dev/null > /var/log/lastlog
fi

#cleanup persistent udev rules
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
    rm /etc/udev/rules.d/70-persistent-net.rules
fi

#cleanup /tmp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

#cleanup current ssh keys
rm -f /etc/ssh/ssh_host_*

#cleanup apt
apt clean
apt autoremove
