# MY WIRED IP
  typeset -g POWERLEVEL9K_MY_WIRED_IP_FOREGROUND=38							# Text color
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_FOREGROUND='#ffffff'		# Text color if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_BACKGROUND='#aa1100'		# Segment color if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME=false						# Show the name of the IF
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED=false					# Show segment even if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_PREFIX='󰍸 '							# Prefix for the wired segment
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_PREFIX='󰍸'				# Prefix for the wired segment if no wired IF is connected
# MY WIFI IP
  typeset -g POWERLEVEL9K_MY_WIFI_IP_FOREGROUND=38							# Text color
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_FOREGROUND='#ffffff'		# Text color if no wifi IF is connected
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_BACKGROUND='#aa1100'		# Segment color if no wifi IF is connected 
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME=false						# Show the name of the IF
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED=true					# Show segment even if no wifi
  typeset -g POWERLEVEL9K_MY_WIFI_IP_PREFIX=' '							# Prefix for the wifi segment
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_PREFIX=''					# Prefix for the wifi segment if no wifi IF is connected
# MY IF COUNT
  typeset -g POWERLEVEL9K_MY_IF_COUNT_FOREGROUND=38							# Text color
  typeset -g POWERLEVEL9K_MY_IF_COUNT_PREFIX='#'							# Prefix for the Count segment
  typeset -g POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL=2							# If more than this number of wired/wifi IF are connected,
  																			#	segment will turn red
  typeset -g POWERLEVEL9K_MY_IF_COUNT_UNUSUAL_FOREGROUND='#cc2222'			# Color of the segment if 0 or more than the number above
  																			#	are connected


#####################
# BEGIN OF SEGMENTS #
#####################

function prompt_my_uptime () {
	local uptime_seconds_in=$( /bin/cat /proc/uptime | /bin/awk '{print int($1)}' )
	local uptime_hours=$(( uptime_seconds_in / 3600 ))
	local uptime_minutes=$(( (uptime_seconds_in % 3600) / 60 ))
	local uptime_seconds=$(( uptime_seconds_in % 60 ))

	if [[ $POWERLEVEL9K_MY_UPTIME_SHOW_SECONDS == true ]]; then
		if (( uptime_minutes < 10 )); then
			if (( uptime_seconds < 10 )); then
				p10k segment -t "$uptime_hours:0$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "$uptime_hours:0$uptime_minutes:$uptime_seconds"
			fi
		else
			if ((uptime_seconds < 10 )); then
				p10k segment -t "$uptime_hours:$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "$uptime_hours:$uptime_minutes:$uptime_seconds"
			fi
		fi
	else
		if (( uptime_minutes < 10 )); then
			p10k segment -t "$uptime_hours:0$uptime_minutes"
		else
			p10k segment -t "$uptime_hours:$uptime_minutes"
		fi
	fi
}

function prompt_my_wired_ip () {
	local interface=$( /bin/ip link show | /bin/grep -Eo '^[0-9]+: ([Ee]\w+):' | /bin/grep -Eo '[Ee]\w+' | /bin/head -n 1 )

	if [[ -n "$interface" ]]; then
		local ip=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | /bin/head -n 1 )
	fi
	if [[ -n "$ip" ]]; then
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: $ip"
		else
			p10k segment -t "$ip"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_wifi_ip () {
	local interface=$( /bin/ip link show | /bin/grep -Eo '^[0-9]+: ([Ww]\w+):' | /bin/grep -Eo '[Ww]\w+' | /bin/head -n 1 )

	if [[ -n "$interface" ]]; then
		local ip=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | /bin/head -n 1 )
	fi
	if [[ -n "$ip" ]]; then
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: $ip"
		else
			p10k segment -t "$ip"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_if_count () {
	local count=$( /bin/ip -4 addr show | /bin/grep -Eo '^[0-9]+: (e\w+|w\w+):' | /bin/wc -l )
	if [[ ( $count -le $POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL ) && ( $count -gt 0 ) ]]; then
		p10k segment -t "$count"
	else
		p10k segment -s UNUSUAL -t "$count"
	fi
}

