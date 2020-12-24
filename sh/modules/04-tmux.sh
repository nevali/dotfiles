tmux_available=${tmux_available:-no}
tmux_active=${tmux_active:-no}


_tmux_init() {
	if [ -z "$TMUX" ] ; then
		true
	else
		tmux_available=yes
		tmux_active=yes
	fi
}

_tmux_fini() {
	if [ $tmux_active = yes ] ; then
		notice tmux "Welcome to tmux session [%s]" "$(tmux display-message -p '#S')"
	fi
}