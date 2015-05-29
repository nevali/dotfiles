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
	col="${ansi_byellow}"
	[ $is_local -eq 1 ] && col="${ansi_bmagenta}"
	printf "${ansi_reset}${col}"
	printf -- "-%.0s" {1..78}
	printf "${ansi_reset}\n"
	printf "${col}%s@%s - %s (%s)${ansi_reset}\n" "`whoami`" ""`hostname`"" "`uname -sr`" "`uname -m`"
	uptime=$(echo `uptime`)
	printf "${ansi_reset} %s\n" "$uptime"
	date=`date +"%A %e %B %Y %H:%M:%S %z (%Z)"`
	printf "${ansi_bwhite} %s\n" "$date"
	printf "${ansi_reset}${col}"
	printf -- "-%.0s" {1..78}
	printf "${ansi_reset}\n"
fi

