if test -r "$HOME/.profile.common" ; then
	. "$HOME/.profile.common"
fi
if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

if [ $is_interactive -eq 1 ] ; then
	if test x"$PS1" = x'# ' || test x"$PS1" = x'$ ' || test x"$PS1" = x'\s-\v\$ ' || test x"$PS1" = x'\u@\h:\w\$ ' || test x"$PS1" = x'\h:\W \u\$ ' || test x"$PS1" = x'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ; then
		PS1="$def_ps1"
	fi
	if test x"$PS2" = x'> ' ; then
	    PS2="$def_ps2"
	fi
	if test x"$PROMPT_COMMAND" = x"" || test x"$PROMPT_COMMAND" = x'update_terminal_cwd; ' ; then
	    PROMPT_COMMAND="$def_prompt_command"
	fi
fi

if test x"$VISUAL" = x"" ; then
	VISUAL="$def_visual"
fi
test x"$VISUAL" = x"" || export VISUAL

if [ $is_interactive -eq 1 ] && [ $is_login -eq 1 ] ; then
	col=96
	[ $is_local -eq 1 ] && col=95
	printf "\033[0m\033[${col}m\033[1m"
	printf -- "-%.0s" {1..78}
	printf "\033[0m\n\033[1m"
	printf "\033[1m%s@%s - %s (%s)\033[0m\n" "`whoami`" ""`hostname`"" "`uname -sr`" "`uname -m`"
	uptime
	date +"%A %e %B %Y %H:%M:%S %z (%Z)"
	printf "\033[0m\033[${col}m\033[1m"
	printf -- "-%.0s" {1..78}
	printf "\033[0m\n"
fi

