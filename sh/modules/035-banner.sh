## Display a login banner and message of the day when a new session is started

banner_enabled=${banner_enabled:-no}

_banner_init() {
	[ $is_interactive -eq 1 ] || banner_enabled=no
	[ $is_login -eq 1 ] || banner_enabled=no
	[ -r ${HOME}/.hushlogin ] && banner_enabled=no
}

_banner_repl() {
	printf %$2s |tr " " "$1"
}

_banner_fini() {
	local col bcol uptime line
	local cols=${COLUMNS:-80}
	
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
}
