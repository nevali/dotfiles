motd_enabled=${motd_enabled:-no}

_motd_init() {
	[ $is_interactive -eq 1 ] || motd_enabled=no
	[ $is_login -eq 1 ] || motd_enabled=no
	[ -r ${HOME}/.hushlogin ] && motd_enabled=no
}

_motd_fini() {
	if [ -r ${HOME}/.motd ] ; then
		cat ${HOME}/.motd
	elif [ -r /etc/motd ] ; then
		cat /etc/motd
	fi
}
