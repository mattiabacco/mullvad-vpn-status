# mullvad-vpn-status

Shell script that checks [Mullvad](https://mullvad.net/en) connection status and allows the user to toggle connections. It also checks how many days the account has left, and warns the user when the account will expire within a week. Intended for use with [Polybar](https://github.com/polybar/polybar). 

## Usage

Download the script and make sure it's executable (`chmod +x mullvad_vpn_status.R`). You'll also need [Font Awesome](https://fontawesome.com/) if you want icons. Then add something like this to your `user_modules.ini`:

```
[module/vpn]

type = custom/script
exec = ~/mullvad-vpn-status/mullvad_vpn_status.sh
interval = 60
format = "<label>"
```
