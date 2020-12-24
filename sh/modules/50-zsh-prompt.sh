_zsh_prompt_init() {
	[ $shell_name = zsh ] || zsh_prompt_enabled=no
	[ $is_interactive -eq 1 ] || zsh_prompt_enabled=no
	true
}

_zsh_prompt_fini() {
	local user host term path vc indicator hostbit
	setopt PROMPT_PERCENT
	setopt PROMPT_SUBST
	
	prompt_user_local=${prompt_user_local:-yellow}
	prompt_user_remote=${prompt_user_local:-cyan}
	prompt_term=${prompt_term:-yellow}
	prompt_host=${prompt_user_local:-cyan}
	prompt_path_local=${prompt_path_local:-magenta}
	prompt_path_remote=${prompt_path_remote:-magenta}
	prompt_vc_local=${prompt_vc_local:-cyan}
	prompt_vc_remote=${prompt_vc_remote:-cyan}
	prompt_indicator_local=${prompt_indicator_local:-cyan}
	prompt_indicator_remote=${prompt_indicator_remote:-cyan}
	prompt_root_local=${prompt_root_local:-red}
	prompt_root_remote=${prompt_root_remote:-red}

	if [ $shell_location = local ] ; then
		user=$prompt_user_local
		term=$prompt_term
		path=$prompt_path_local
		vc=$prompt_vc_local
		if [ $is_root -eq 1 ] ; then
			indicator=$prompt_root_local
		else
			indicator=$prompt_indicator_local
		fi
		hostbit="%B:%b%F{$term}%y%f"
	else
		user=$prompt_user_remote
		host=$prompt_term
		path=$prompt_path_remote
		vc=$prompt_vc_remote
		if [ $is_root -eq 1 ] ; then
			indicator=$prompt_root_remote
		else
			indicator=$prompt_indicator_remote
		fi
		hostbit="%B@%b%F{$host}%m%f"
	fi
	if [ $has_colour -eq 1 ] ; then
		PS1="%B[%b%F{$user}%n%f${hostbit} %F{$path}%1~%F{$vc}\${_prompt_vcbranch}%f%B]%b%F{$indicator}%#%f "
	else
		PS1="%B[%b%n${hostbit} %1~\${_prompt_vcbranch}%B]%b%# "
	fi
	PS2='%B%_>%b '
	
	debug "zsh_prompt" "PS1=%s, PS2=%s" "$PS1" "$PS2"
}
