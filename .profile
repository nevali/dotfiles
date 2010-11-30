if test -r /etc/profile ; then
	. /etc/profile
fi
if test -r "$HOME/.profile.common" ; then
	. "$HOME/.profile.common"
fi
if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

if test x"$PS1" = x'# ' || test x"$PS1" = x'$ ' || test x"$PS1" = x'\s-\v\$ '; then
	PS1="$def_ps1"
fi
if test x"$PS2" = x'> ' ; then
    PS2="$def_ps2"
fi
if test x"$PROMPT_COMMAND" = x"" ; then
    PROMPT_COMMAND="$def_prompt_command"
fi
