if test -r "$HOME/.profile.common" ; then
	. "$HOME/.profile.common"
fi
if test x"$SHLVL" = x"1" && test -r /etc/profile.local ; then
    . /etc/profile.local
fi
if test -r "$HOME/.bashrc.local" ; then
    . "$HOME/.bashrc.local"
fi
if test x"$PS1" = x'# ' || test x"$PS1" = x'$ ' || test x"$PS1" = x'\s-\v\$ ' || test x"$PS1" = x'\u@\h:\w\$ ' || test x"$PS1" = x'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ; then
	PS1="$def_ps1"
fi
if test x"$PS2" = x'> ' ; then
	PS2="$def_ps2"
fi
if test x"$PROMPT_COMMAND" = x"" ; then
	PROMPT_COMMAND="$def_prompt_command"
fi
if test x"$VISUAL" = x"" ; then
	VISUAL="$def_visual"
fi
test x"$VISUAL" = x"" || export VISUAL
