#!/bin/sh

MIN=40
MAX=60

while true ; do
    STATUS=$(acpi -b | awk '{print $3}' | sed 's/,//')
    BAT=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    
    if [ $BAT -le $MIN ] && [ "$STATUS" == 'Discharging' ]; then
        notify-send --icon=battery --expire-time=5000 "Battery below $MIN%" "Plug it in to preserve battery lifespan!"
    elif [ $BAT -ge $MAX ] && [ "$STATUS" == 'Charging' ]; then
        notify-send --icon=battery --expire-time=5000 "Battery above $MAX%" "Unplug it to preserve battery lifespan!"
    fi

    sleep 300
done
