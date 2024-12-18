# MY WIRED IP
  typeset -g POWERLEVEL9K_MY_WIRED_IP_FOREGROUND='#a050ff'		# Text color
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_FOREGROUND='#ffffff'	# Text color if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_BACKGROUND='#aa1100'	# Segment color if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME=true			# Show the name of the IF
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED=true		# Show segment even if no wired IF is connected
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWNETSIZE=true			# Show CIDR notation of subnetmask
  typeset -g POWERLEVEL9K_MY_WIRED_IP_PREFIX='󰍸 '			# Prefix for the wired segment
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_PREFIX='󰍸'		# Prefix for the wired segment if no wired IF is connected
# MY WIFI IP
  typeset -g POWERLEVEL9K_MY_WIFI_IP_FOREGROUND='#a050ff'		# Text color
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_FOREGROUND='#ffffff'	# Text color if no wifi IF is connected
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_BACKGROUND='#aa1100'	# Segment color if no wifi IF is connected 
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME=true			# Show the name of the IF
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED=true		# Show segment even if no wifi
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWNETSIZE=true			# Show CIDR notation of subnetmask
  typeset -g POWERLEVEL9K_MY_WIFI_IP_PREFIX=' '			# Prefix for the wifi segment
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_PREFIX=''		# Prefix for the wifi segment if no wifi IF is connected
# MY IF COUNT
  typeset -g POWERLEVEL9K_MY_IF_COUNT_FOREGROUND='#a050ff'		# Text color
  typeset -g POWERLEVEL9K_MY_IF_COUNT_PREFIX='#'			# Prefix for the Count segment
  typeset -g POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL=2			# If more than this number of wired/wifi IF are connected,
  									#	segment will turn red
  typeset -g POWERLEVEL9K_MY_IF_COUNT_UNUSUAL_FOREGROUND='#cc2222'	# Color of the segment if 0 or more than the number above
  									#	are connected


#####################
# BEGIN OF SEGMENTS #
#####################

function prompt_my_wired_ip () {
	local interface=$( /usr/bin/ip -4 addr show | /usr/bin/grep -Eo '^[0-9]+: ([Ee]\w+)' | /usr/bin/grep -Eo '[Ee]\w+' | /usr/bin/head -n 1 )
	if [[ -n $interface ]]; then
		local ip=$( /usr/bin/ip -4 addr show $interface | /usr/bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | head -n 1 )
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWNETSIZE == true ]]; then
			local netmask=$( /usr/bin/ip -4 addr show $interface | /usr/bin/grep -Eo '/[0-9]{1,2}' )
		fi
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: %B$ip%b$netmask"
		else
			p10k segment -t "%B$ip%b$netmask"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_wifi_ip () {
	local interface=$( /usr/bin/ip -4 addr show | /usr/bin/grep -Eo '^[0-9]+: ([Ww]\w+)' | /usr/bin/grep -Eo '[Ww]\w+' | /usr/bin/head -n 1 )
	if [[ -n $interface ]]; then
		local ip=$( /usr/bin/ip -4 addr show $interface | /usr/bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | head -n 1 )
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWNETSIZE == true ]]; then
			local netmask=$( /usr/bin/ip -4 addr show $interface | /usr/bin/grep -Eo '/[0-9]{1,2}' )
		fi
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: %B$ip%b$netmask"
		else
			p10k segment -t "%B$ip%b$netmask"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_if_count () {
	local count=$( /usr/bin/ip -4 addr show | /usr/bin/grep -Eo '^[0-9]+: ([Ee]\w+|[Ww]\w+)' | /usr/bin/wc -l )
	if [[ ( $count -le $POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL ) && ( $count -gt 0 ) ]]; then
		p10k segment -t "%B$count%b"
	else
		p10k segment -s UNUSUAL -t "%B$count%b"
	fi
}

# Settings so that vims tabsize is the same as in the github online code viewer
# Needs ":set modeline=true" to work

# vim: set tabstop=8 :
# vim: set shiftwidth=8 :
