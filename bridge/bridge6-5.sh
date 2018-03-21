#!/bin/bash

rm -rf /etc/sysconfig/network-scripts/ifcfg-eth0 > /dev/null 2>&1
cp ./6-5/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0
cp ./6-5/ifcfg-br0 /etc/sysconfig/network-scripts/ifcfg-br0

if [ -f /etc/sysconfig/network-script/ifcfg-br0 ]
then
	echo "IPADDR=$1" >> /etc/sysconfig/network-scripts/ifcfg-br0

	
else
	echo "/etc/sysconfig/network-scripts/ifcfg-br0 Not found!"
fi

service NetworkManager stop
chkconfig NetworkManager off
chkconfig network on
service network restart
