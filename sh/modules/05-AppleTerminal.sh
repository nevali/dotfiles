## support for Apple's Terminal.app

_appleterminal_init() {
	[ $is_interactive -eq 1 ] || appleterminal_enabled=no
	
	if [ x"$TERM_PROGRAM" = x"Apple_Terminal" ] ; then
		true
	else
		appleterminal_enabled=no
	fi	
}
