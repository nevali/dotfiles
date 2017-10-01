test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile" >&2

if test -r /etc/profile ; then
	. /etc/profile
fi

. $HOME/.profile.common

if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

. "$HOME/.profile.fini.sh"
