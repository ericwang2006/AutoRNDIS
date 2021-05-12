#!/bin/sh
id=$(adb devices | grep device$)

if [ -z "$id" ]; then
	d=$(date '+%F %T')
	echo "[$d]device not found"
	echo "[$d]device not found" >>/tmp/net_check.log
else
	reg='((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))'
	ip=$(ifconfig usb0 | grep -Eo "inet addr:$reg" | grep -Eo "$reg")
	if [ -z "$ip" ]; then
		d=$(date '+%F %T')
		echo "[$d]fix network connection"
		echo "[$d]fix network connection" >>/tmp/net_check.log
		# 设置USB的状态是网络共享
		adb shell svc usb setFunctions rndis
	else
		d=$(date '+%F %T')
		echo "[$d]device status ok"
	fi
fi
