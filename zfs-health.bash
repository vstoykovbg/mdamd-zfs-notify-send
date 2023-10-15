#!/bin/bash

eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";

condition=$(/sbin/zpool status | egrep '(DEGRADED|FAULTED|OFFLINE|UNAVAIL|REMOVED|FAIL|DESTROYED|corrupt|cannot|unrecover)')
if [ "${condition}" ]; then
notify-send "ZFS problem detected"
fi

if grep "_" /proc/mdstat ; then
notify-send "problem detected in /proc/mdstat"
fi
