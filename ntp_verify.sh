#!/bin/bash

#checking the status of ntp, restart if dead

CHECK_SERVICE=`service ntp status | grep Active | awk -F '(' '{print $2 }' | awk -F ')' '{print $1}'`
if [[ $CHECK_SERVICE == 'dead' ]]
then
	echo "NOTICE: ntp is not running"

	sudo systemctl restart ntp.service
	exit
fi

	#Checking diff in ntp.conf

	Dif="$(diff -u "/usr/bin/ntp.original" "/etc/ntp.conf")" #| grep '^[-+]'
	lines="$(echo -n $Dif | wc -l)"
	[ $lines -gt 0 ] && echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:";
	echo "$Dif"
	cat "/usr/bin/ntp.original" > "/etc/ntp.conf"
	sudo systemctl restart ntp.service
	exit