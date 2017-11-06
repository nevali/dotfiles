test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.fini.sh" >&2

if test $update_ps1 -eq 1 ; then
	PS1="$def_ps1"
fi

if test $update_ps2 -eq 1 ; then
	PS2="$def_ps2"
fi

if test x"$shell_name" = x"bash" ; then
	. "$HOME/.iterm2_shell_integration.bash"
	if type -t iterm2_preexec_invoke_cmd 2>/dev/null >&2 ; then
		ITERM_PREEXEC_INTERACTIVE_MODE="yes"
		iterm2_preexec_invoke_cmd
	fi
fi

if test $update_promptcmd -eq 1 ; then
	PROMPT_COMMAND="profile_precmd"
	
	precmd() {
		profile_precmd
	}

	if type -t iterm2_preexec_invoke_cmd 2>/dev/null >&2 ; then
		PROMPT_COMMAND="profile_precmd ; iterm2_preexec_invoke_cmd"
	fi
fi
