
# MASQURADE：可从服务器的网卡上，自动获取当前ip地址来做NAT。适合于ADSL拨号上网。
iptables -t nat -A POSTROUTING -s 10.111.111.0/24 -j MASQUERADE
