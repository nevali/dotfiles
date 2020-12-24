## Display a login banner and message of the day when a new session is started

_banner_init() {
	[ $is_interactive -eq 1 ] || banner_enabled=no
	[ $is_login -eq 1 ] || banner_enabled=no
	[ -r ${HOME}/.hushlogin ] && banner_enabled=no
	[ $banner_enabled = yes ] || return

	# show ~/.motd or /etc/motd (if available; defaults to no unless
	# show_stripe is yes)
	show_motd=${show_motd:-$show_stripe}

	# show a banner showing the system type and load averages
	# (defaults to the value of $show_stripe)
	show_banner=${show_banner:-$show_stripe}

	notice "banner" "Welcome to %s %s (%s) on %s" $(uname -s) $(uname -r) $(uname -m) "${NODENAME}"
}

_banner_repl() {
	printf -- "$1"'%.s' $(eval "echo {1.."$(($2))"}")
}

_banner_fini() {
	local col bcol uptime line
	local cols=${COLUMNS:-80}

	if [ $show_motd = "yes" ] ; then
		if [ -r ${HOME}/.motd ] ; then
			cat ${HOME}/.motd
		elif [ -r /etc/motd ] ; then
			cat /etc/motd
		fi
	fi
	
	if [ $show_banner = "yes" ] ; then
		if [ $has_utf8 -eq 1 ] ; then
			line=$(_banner_repl "─" $cols)
		else
			line=$(_banner_repl "-" $cols)
		fi
		if [ $is_local -eq 1 ] ; then
			# Local terminals have a different colour scheme to remote to make
			# it easier to distinguish at a glance
			col="${ansi_bgreen}"
			bcol="${ansi_bmagenta}"
		else
			col="${ansi_bwhite}"
			bcol="${ansi_byellow}"
		fi
		printf "${ansi_reset}${bcol}%s${ansi_reset}\n" "${line}"
		printf "${col}  %s@%s:%s${ansi_reset} - ${ansi_bblue}%s${ansi_reset} (%s)${ansi_reset}\n" "$LOGNAME" "$NODENAME" "$TTYNAME" "`uname -sr`" "`uname -m`"
		printf "${ansi_reset}${ansi_bold}   %s${ansi_reset}\n" "$(date '+%A %e %B %Y %H:%M:%S %z (%Z)')"
		uptime=$(echo `uptime`)
		printf "${ansi_reset}   %s\n" "$uptime"
		printf "${ansi_reset}${bcol}%s${ansi_reset}\n" "${line}"
	fi
}
