test x"$PROFILE_TRACE" = x"yes" && echo ">> .bashrc" >&2

if test -r /etc/bashrc ; then
	. /etc/bashrc
fi

. $HOME/.profile.common

if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

if test -r "$HOME/.bashrc.local" ; then
	. "$HOME/.bashrc.local"
fi

. "$HOME/.profile.fini.sh"
