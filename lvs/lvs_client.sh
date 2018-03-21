#!/bin/bash

VIP=10.0.0.10
case "$1" in
	start )
		echo "start LVS to REALServer IP"

		for (( i = 0; i < `echo ${#VIP[*]}`; i++ )); do
			interface="lo:`echo ${VIP[$i]}|awk -F . '{print $4}'`"
			/sbin/ifconfig $interface ${VIP[$i]} broadcast ${VIP[$i]} netmask 255.255.255.255 up
			route add -host ${VIP[$i]} dev $interface
		done
		echo "1" > /proc/sys/net/ipv4/conf/lo/arp_ignore 
		echo "2" > /proc/sys/net/ipv4/conf/lo/arp_announce 
		echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore 
		echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
		;;
	stop )
		for (( i = 0; i < `echo ${#VIP[*]}`; i++ )); do
			interface="lo:`echo ${VIP[$i]}|awk -F . '{print $4}'`"
			/sbin/ifconfig $interface ${VIP[$i]} broadcast ${VIP[$i]} netmask 255.255.255.255 down
			echo "STOP LVS of REALServer IP"
		done
		;;
	* )
		echo "Usage: $0 {start|stop}"
		exit 1
		;;

esac
