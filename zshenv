if test -r "$HOME/.profile.common" ; then
	. "$HOME/.profile.common"
fi
if test x"$SHLVL" = x"1" && test -r /etc/profile.local ; then
	. /etc/profile.local
fi
if test x"$SHLVL" = x"1" && test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi
if test -r "$HOME/.zshrc.local" ; then
	. "$HOME/.zshenv.local"
fi
if test x"$PS1" = x"%m%#" ; then
	PS1="$def_ps1"
fi
if test x"$PS2" = x"%_>" ; then
	PS2="$def_ps2"
fi
if test x"$VISUAL" = x"" ; then
	VISUAL="$def_visual"
fi
test x"$VISUAL" = x"" || export VISUAL

