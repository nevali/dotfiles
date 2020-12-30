notice_enabled=${notice_enabled:-no}

_notice_init() {
	[ $is_interactive -eq 1 ] || notice_enabled=no
	[ $is_login -eq 1 ] || notice_enabled=no
	[ -r ${HOME}/.hushlogin ] && notice_enabled=no
}

_notice_fini() {
	notice "profile" "Welcome to %s %s (%s) on %s" $(uname -s) $(uname -r) $(uname -m) "${NODENAME}"
}