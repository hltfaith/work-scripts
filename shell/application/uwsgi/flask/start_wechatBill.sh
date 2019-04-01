#!/bin/bash

/usr/local/python3/bin/uwsgi --ini uwsgiBill.ini

/usr/sbin/nginx -c /etc/nginx/nginx.conf
