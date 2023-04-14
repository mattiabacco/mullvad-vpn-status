#!/bin/sh

vpn_status=$(mullvad status | cut -d ' ' -f3)
ip_address=$(mullvad status | awk 'match($0,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/){print substr($0,RSTART,RLENGTH)}')
protocol=$(mullvad status | awk '{for(i=1;i<=NF;i++)if($i=="to")print $(i+1)}')
account_expiry_date=$(mullvad account get | sed -n 3p | awk '{print $4}')
current_date=$(date +%Y-%m-%d $now)
days_left=$(($account_expiry_date - $current_date));

echo $account_expiry_date
echo $current_date
echo $days_left

vpn_report() {
    if [ "$vpn_status" = "Connected" ]; then
        if [ $days_left -lt 7 ]; then
            echo "%{F#e87e96} ($protocol | $days_left days left!)%{F-}"
        else
            echo "%{F#eceff4} ($protocol | $days_left days left)%{F-}"
        fi
	else
		echo "%{F#ebcb8b} %{F-}"
	fi
}

vpn_toggle_connection() {
    if [ "$vpn_status" = "Connected" ]; then
        mullvad disconnect
    else
        mullvad connect
    fi
}

case "$1" in
    --toggle-connection) vpn_toggle_connection ;;
	*) vpn_report ;;
esac
