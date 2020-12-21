## Display a login banner and message of the day when a new session is started

_banner_init() {
	[ $is_interactive -eq 1 ] || return 0
	[ $is_login -eq 1 ] || return 0

	notice "banner" "Welcome to %s %s (%s) on %s" $(uname -s) $(uname -r) $(uname -m) "${NODENAME}"
}

_banner_fini() {
	local col bcol uptime line
	local cols=${COLUMNS:-80}

	[ $is_interactive -eq 1 ] || return 0
	[ $is_login -eq 1 ] || return 0

    [ -x ${HOME}/.hushlogin ] && return 0
    
    if [ -r ${HOME}/.motd ] ; then
        cat ${HOME}/.motd
    elif [ -r /etc/motd ] ; then
        cat /etc/motd
    fi
    
	if [ $has_utf8 -eq 1 ] ; then
		line=$(printf -- "─%.0s" {1..${cols}})
	else
		line=$(printf -- "-%.0s" {1..${cols}})
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
