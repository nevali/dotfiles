test x"$PROFILE_TRACE" = x"yes" && echo ">> .zshenv" >&2

if test -r /etc/zshenv ; then
	. /etc/zshenv
fi

. $HOME/.profile.common

if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

. "$HOME/.profile.fini.sh"
