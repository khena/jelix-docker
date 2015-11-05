#!/bin/bash
# UTC is the default
if [ ! -f /etc/timezone -o "$TZ" != `cat /etc/timezone`   ]
then
	echo "Updating TimeZone..."        
        echo "$TZ" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
fi
