#!/bin/bash

#prerequisites
#install centos software updates and verify open-vm tools version

#install updates and use skip-broken feature to skip packages that have dependency problems
#yum update --skip-broken -y

#return local version of the rpm files
#rpm -q open-vm-tools

#return repo version of the rpm files
#yum list open-vm-tools

#stop logging services 
/sbin/service rsyslog stop 
/sbin/service auditd stop 
#remove old kernels 
/bin/package-cleanup -–oldkernels -–count=1 
#clean yum cache 
/usr/bin/yum clean all 
#force logrotate to shrink logspace and remove old logs as well as truncate logs 
/usr/sbin/logrotate -f /etc/logrotate.conf 
/bin/rm -f /var/log/*-???????? /var/log/*.gz 
/bin/rm -f /var/log/dmesg.old 
/bin/rm -rf /var/log/anaconda 
/bin/cat /dev/null > /var/log/audit/audit.log 
/bin/cat /dev/null > /var/log/wtmp 
/bin/cat /dev/null > /var/log/lastlog 
/bin/cat /dev/null > /var/log/grubby 
#remove udev hardware rules 
/bin/rm -f /etc/udev/rules.d/70* 
#remove uuid from ifcfg scripts 
/bin/sed –i”.bak” ‘/UUID/d’ /etc/sysconfig/network-scripts/ifcfg-eno16777984 
#remove SSH host keys 
/bin/rm -f /etc/ssh/*key* 
#remove root users shell history 
/bin/rm -f ~root/.bash_history 
unset HISTFILE 
#remove root users SSH history 
/bin/rm -rf ~root/.ssh/


# Now the problem with the script route is that there is no way to run history –c 
# from a script (nothing happens), so once you have run the script you will need 
# to run the following.

# history –c
# sys-unconfig