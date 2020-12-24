_bash_prompt_init() {
	[ $shell_name = bash ] || bash_prompt_enabled=no
	[ $is_interactive -eq 1 ] || bash_prompt_enabled=no
	true
}

_bash_prompt_fini() {
	local user host term path vc indicator hostbit
	local bold reset

	prompt_user_local=${prompt_user_local:-93}
	prompt_user_remote=${prompt_user_local:-96}
	prompt_term=${prompt_term:-33}
	prompt_host=${prompt_user_local:-36}
	prompt_path_local=${prompt_path_local:-95}
	prompt_path_remote=${prompt_path_remote:-95}
	prompt_vc_local=${prompt_vc_local:-36}
	prompt_vc_remote=${prompt_vc_remote:-36}
	prompt_indicator_local=${prompt_indicator_local:-96}
	prompt_indicator_remote=${prompt_indicator_remote:-96}
	prompt_root_local=${prompt_root_local:-91}
	prompt_root_remote=${prompt_root_remote:-91}
	
	if [ $has_ansi -eq 1 ] ; then
		bold='\[\033[1m\]'
		reset='\[\033[0m\]'
	else
		bold=""
		reset=""
	fi

	if [ $shell_location = local ] ; then
		user="\\[\\033[${prompt_user_local}m\\]"
		term="\\[\\033[${prompt_term}m\\]"
		path="\\[\\033[${prompt_path_local}m\\]"
		vc="\\[\\033[${prompt_vc_local}m\\]"
		if [ $is_root -eq 1 ] ; then
			indicator="\\[\\033[${prompt_root_local}m\\]"
		else
			indicator="\\[\\033[${prompt_indicator_local}m\\]"
		fi
		if [ $has_colour -eq 1 ] ; then
			hostbit="${bold}:${reset}${term}\\l${reset}"
		else
			hostbit="${bold}:${reset}\\l"
		fi
	else
		user="\\[\\033[${prompt_user_remote}m\\]"
		host="\\[\\033[${prompt_host}m\\]"
		path="\\[\\033[${prompt_path_remote}m\\]"
		vc="\\[\\033[${prompt_vc_remote}m\\]"
		if [ $is_root -eq 1 ] ; then
			indicator="\\[\\033[${prompt_root_remote}m\\]"
		else
			indicator="\\[\\033[${prompt_indicator_remote}m\\]"
		fi
		if [ $has_colour -eq 1 ] ; then
			hostbit="${bold}@${reset}${host}\\h${reset}"
		else
			hostbit="${bold}@${reset}\\h"
		fi
	fi
	if [ $has_colour -eq 1 ] ; then
		PS1="${bold}[${reset}${user}\\u${reset}${hostbit} ${path}\\W${vc}\${_prompt_vcbranch}${reset}${bold}]${reset}${indicator}\\\$${reset} "
	else
		PS1="${bold}[${reset}\\u${hostbit} \\W\${_prompt_vcbranch}${bold}]${reset}\\\$ "
	fi
	PS2='> '
	
	debug "bash_prompt" "PS1=%s, PS2=%s" "$PS1" "$PS2"
}
