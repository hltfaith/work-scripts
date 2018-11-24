#!/bin/bash
# author: changhao
#   date: 2018.11.24
#  info: install mysql server

yum install -y mariadb-server
systemctl start mariadb

