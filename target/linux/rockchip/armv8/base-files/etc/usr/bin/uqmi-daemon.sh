#!/bin/bash

QMI_DEV=/dev/cdc-wdm0
QMI_LOG=/var/log/uqmi_daemon.log
MAX_FAILED_COUNT=10

function set_device_operating_mode() {
	var=$(uqmi -d $1 --set-device-operating-mode=$2)
}

function ping_domain() {
	local domain=223.5.5.5
	local retries=6
	local packets_responded=0

	for i in $(seq 1 $retries); do
		if ping -c 1 $domain >/dev/null; then
			((packets_responded++))
			sleep 1
		fi
	done

	if [ $packets_responded -ge 2 ]; then
		echo "true"
	else
		echo "false"
	fi
}

echo /dev/null > ${QMI_LOG}
echo "$(date '+%Y-%m-%d %H:%M:%S'): QMI daemon is started..." > ${QMI_LOG}

FAILED_COUNT=0
NETWORK_STATUS=false

while true; do
	if [ $(ping_domain) = "false" ]; then
		((FAILED_COUNT+=1))
		if [ ${FAILED_COUNT} -ge ${MAX_FAILED_COUNT} ]; then
			# reboot
			echo "$(date '+%Y-%m-%d %H:%M:%S'): Network cannot be restored! restart the router..." >> ${QMI_LOG}
			/sbin/reboot
		fi
		echo "$(date '+%Y-%m-%d %H:%M:%S'): Network is unreachable, try to reset" >> ${QMI_LOG}
		set_device_operating_mode $QMI_DEV reset
		sleep 30
	else
		if [ ${NETWORK_STATUS} = "false" ]; then
			NETWORK_STATUS=true
			FAILED_COUNT=0
			echo "$(date '+%Y-%m-%d %H:%M:%S'): Network is reachable" >> ${QMI_LOG}
		fi
	fi
	sleep 1800
done
