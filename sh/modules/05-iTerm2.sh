# Integration with iTerm2.app 

_iterm2_init() {
	[ $is_interactive -eq 1 ] || iterm2_enabled=no
	
	if [ x"$TERM_PROGRAM" = x"iTerm.app" ] || [ x"$LC_TERMINAL" = x"iTerm2" ] ; then
		if [ $shell_name = bash ] ; then
#		. "${PROFILEDIR}/../bash/iterm2_shell_integration.bash"
true
		elif [ $shell_name = zsh ] ; then
		. "${PROFILEDIR}/../zsh/iterm2_shell_integration.zsh"
		fi
	else
		iterm2_enabled=no
	fi
}

_iterm2_fini() {
	profile_hook precmd _iterm2_prompt_hook
}

_iterm2_prompt_hook() {
	printf "\033]1337;RemoteHost=$USERNAME@$HOSTNAME\007"
	printf "\033]1337;CurrentDir=$(pwd)\007"
}
