if test -r "$HOME/.profile.common" ; then
	. "$HOME/.profile.common"
fi
if test x"$SHLVL" = x"1" && test -r /etc/profile.local ; then
	. /etc/profile.local
fi
if test -r "$HOME/.bashrc.local" ; then
	. "$HOME/.bashrc.local"
fi

## For interactive shells, set PS1, PS2 and PROMPT_COMMAND to defaults if not already overidden
if [ $is_interactive -eq 1 ] ; then
	if test x"$PS1" = x'# ' || test x"$PS1" = x'$ ' || test x"$PS1" = x'\s-\v\$ ' || test x"$PS1" = x'\u@\h:\w\$ ' || test x"$PS1" = x'\h:\W \u\$ ' || test x"$PS1" = x'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ; then
		PS1="$def_ps1"
	fi
	if test x"$PS2" = x'> ' ; then
		PS2="$def_ps2"
	fi
	if test x"$PROMPT_COMMAND" = x"" || \
		test x"$PROMPT_COMMAND" = x"update_terminal_cwd; " || \
		test x"$PROMPT_COMMAND" = x"update_terminal_cwd" || \
		test x"$PROMPT_COMMAND" = x"shell_session_history_check; update_terminal_cwd" ; \
	then
		PROMPT_COMMAND="$def_prompt_command"
	fi
fi

if test x"$VISUAL" = x"" ; then
	VISUAL="$def_visual"
fi
test x"$VISUAL" = x"" || export VISUAL
