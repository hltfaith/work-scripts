#!/bin/bash
# author: changhao

# configure info
read -p "Please input local IP: "  localip
read -p "Please input remote begin IP: "  beginip
read -p "Please input remote end IP: "  endip
read -p "Please input Gateway IP: "  gatewayip
read -p "Please input DNS IP: "  dnsip
read -p "Please input network: "  network
read -p "Please input nic name: "  nicname
read -p "Please input vpn username: " username
read -p "Please input vpn password: " password

# install server
yum install -y epel*
yum makecache
yum install -y vim lrzsz ppp pptpd net-tools
echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
sysctl -p

# config network
sed -i 's/#ppp \/usr\/sbin\/pppd/ppp \/usr\/sbin\/pppd/' /etc/pptpd.conf
sed -i 's/#connections 100/connections 100/' /etc/pptpd.conf
sed -i "s/#localip 192.168.0.1/localip $localip/" /etc/pptpd.conf
sed -i "s/#remoteip 192.168.0.234-238,192.168.0.245/remoteip $beginip-$endip/" /etc/pptpd.conf
sed -i "s/#ms-dns 10.0.0.1/ms-dns $dnsip/" /etc/ppp/options.pptpd
sed -i "s/nologfd/#nologfd/" /etc/ppp/options.pptpd
echo "logfile /var/log/pptpd.log" >> /etc/ppp/options.pptpd
#sed -i 's/#ms-dns 10.0.0.2/ms-dns 219.141.140.10/' /etc/ppp/options.pptpd

echo "$username pptpd $password *" >> /etc/ppp/chap-secrets

#add nat
iptables -t nat -A POSTROUTING -s $network/24 -o $nicname -j SNAT --to-source $gatewayip
#iptables -t nat -A POSTROUTING -s 10.79.1.0/24 -o ens33 -j SNAT --to-source 10.79.1.254
#iptables -t nat -A PREROUTING -p tcp --dport 31723 -j REDIRECT --to-ports 1723

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld

#start pptpd server
systemctl start pptpd
systemctl enable pptpd

echo "#=======================================================================#"
echo "#                                                                       #"
echo "#                       install pptpd success!!!!                       #"
echo "#                                                                       #"
echo "#=======================================================================#"
