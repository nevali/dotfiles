_xterm_init() {
	[ $is_interactive -ge 1 ] || xterm_enabled=no
}

_xterm_fini() {
	profile_hook precmd _xterm_precmd_hook
}

_xterm_precmd_hook() {
	[ $has_xterm -ge 1 ] || return
	printf "\033]1;%s@%s\007" "$LOGNAME" "$NODENAME"
	# only set the "icon" title on Terminal.app and iTerm
	[ "$appleterminal_enabled" = "yes" ] && return
	[ "$iterm2_enabled" = "yes" ] && return
	if [ $has_utf8 ] ; then
		printf "\033]2;%s@%s — %s\007" "$LOGNAME" "$NODENAME" "$PWD"
	else
		printf "\033]2;%s@%s -- %s\007" "$LOGNAME" "$NODENAME" "$PWD"
	fi
}