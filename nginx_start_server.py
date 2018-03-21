#!/bin/bash
#Nginx Server start up script
  if [ "$1" = "start" ];then
	/application/nginx1.6.2/sbin/nginx > /dev/null 2>&1
	echo "Start Nginx: ok"
  elif [ "$1" = "stop" ];then
	/application/nginx1.6.2/sbin/nginx -s stop > /dev/null 2>&1
	echo "Stop Nginx: ok"
  elif [ "$1" = "reload" ];then
	/application/nginx1.6.2/sbin/nginx -s reload > /dev/null 2>&1
	echo "Reload Nginx: ok"
  elif [ "$1" = "quit" ];then
	/application/nginx1.6.2/sbin/nginx -s quit > /dev/null 2>&1
	echo "Quit Nginx: ok"
  elif [ "$1" = "version" ];then
	/application/nginx1.6.2/sbin/nginx -V 
	echo ""
  elif [ "$1" = "check" ];then
	/application/nginx1.6.2/sbin/nginx -t
  else
	echo "Usage: $0 {start | stop | reload | quit | version | check}"
  fi
