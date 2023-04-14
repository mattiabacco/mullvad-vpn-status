#!/bin/sh

vpn_status=$(mullvad status | cut -d ' ' -f1)

# datediff based on:
# https://stackoverflow.com/a/59548761

datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo $(( (d1 - d2) / 86400 ))
}

account_expiry_date=$(mullvad account get | sed -n 3p | awk '{print $4}')
current_date=$(date +%Y-%m-%d $now)
days_left=$(datediff "${account_expiry_date}" "${current_date}")

vpn_report() {
    if [ "$vpn_status" = "Connected" ]; then
        if [ $days_left -lt 7 ]; then
            echo "%{F#e87e96} ($days_left days left!)%{F-}"
        else
            echo "%{F#eceff4}%{F-}"
        fi
	else
		echo "%{F#ebcb8b}%{F-}"
	fi
}

vpn_report
