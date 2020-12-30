_ksh_prompt_init() {
	[ $shell_name = ksh ] || ksh_prompt_enabled=no
	[ $is_interactive -eq 1 ] || ksh_prompt_enabled=no
}

_ksh_prompt_fini() {
	local _defps1 _esc _escn
	
	if [ $is_root -eq 1 ] ; then
		_defps1='# '
	else
		_defps1='$ '
	fi
	PS1="\$(_profile_precmd_hook)[\${LOGNAME}@\${NODENAME} \${PWD##*/}]${_defps1}"
	PS2='> '
	unset _defps1
	
	debug "ksh_prompt" "PS1=%s, PS2=%s" "$PS1" "$PS2"
}
