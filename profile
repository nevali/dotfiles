test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile" >&2

. $HOME/.profile.common

if test -r "$HOME/.profile.local" ; then
	. "$HOME/.profile.local"
fi

. "$HOME/.profile.fini.sh"
