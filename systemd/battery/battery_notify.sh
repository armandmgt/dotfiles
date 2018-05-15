#!/bin/bash

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:15:00 ]] ; then
    TIME=($(echo $BATTINFO | awk '{print $5}' | tr ':' '\n'))
    /usr/bin/notify-send -i /tmp/fillmurray.png \
			 -u critical \
			 "Low battery !" \
			 "remaining time: ${TIME[1]} min"
fi
