# Integration with iTerm2.app 
iterm2_loaded=no

_iterm2_fini() {
	[ $is_interactive -eq 1 ] || return 0
	
	if test x"$shell_name" = x"bash" ; then
		. "${PROFILEDIR}/../bash/iterm2_shell_integration.bash"
		type -t iterm2_preexec_invoke_cmd && iterm2_loaded=yes 2>/dev/null >&2
	elif test x"$shell_name" = x"zsh" ; then
		. "${PROFILEDIR}/../zsh/iterm2_shell_integration.zsh"
		whence iterm2_preexec_invoke_cmd && iterm2_loaded=yes 2>/dev/null >&2
       fi
	debug 'iTerm2' "iterm2_loaded=${iterm2_loaded}"
	if [ $iterm2_loaded = yes ] ; then
		ITERM_PREEXEC_INTERACTIVE_MODE=yes
		iterm2_preexec_invoke_cmd
	fi
}
