#!/bin/bash

. /etc/init.d/functions

VIP=10.0.0.10
PORT=80
RIP=(
10.0.0.9
10.0.0.8
)
start(){

	ifconfig eth0:0 $VIP/24 up
	route add -host $VIP dev eth0
	ipvsadm -C
	ipvsadm --set 30 5 60
	ipvsadm -A -t $VIP:$PORT -s rr -p 20
	for ((i=0;i<${#RIP[*]};i++))
	do
		ipvsadm -a -t $VIP:$PORT -r ${RIP[$i]} -g -w 1
	done
}
stop(){

	ipvsadm -C
	ifconfig eth0:0 down
	route del -host $VIP dev eth0
}
case  "$1" in
	start )
		start
		echo "ipvs is start"
		;;
	stop )
		stop
		echo "ipvs is stop"
		;;
	restart )
		stop
		echo "ipvs is stop"
		start
		echo "ipvs is start"
	* )
		echo "Usage: $0 [start|stop|restart]"	
esac
