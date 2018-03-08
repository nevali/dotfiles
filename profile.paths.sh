test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.paths.sh" >&2


## Add a location to $PATH if it exists
profile_addpath()
{
	if test -d "$1" ; then
	case "$PATH" in
		"*:$1:*|*:$1|$1:*")
			return
			;;
		*)
			PATH="$1:$PATH"
			;;
		esac
	fi
}

profile_addpath "$HOME/Tools"
profile_addpath "$HOME/bin"
profile_addpath /Volumes/iDisk/Tools

profile_addpath /usr/local/bin
profile_addpath /usr/local/git/bin
profile_addpath /usr/local/mysql/bin
profile_addpath /opt/local/bin
profile_addpath /opt/xapian/bin
profile_addpath /opt/txsuite/bin
profile_addpath /opt/csw/bin
profile_addpath /usr/gnu/bin
profile_addpath /opt/ports/bin
profile_addpath /opt/djgpp/bin
profile_addpath /opt/mingw32/bin
profile_addpath /opt/google-cloud-sdk/bin
profile_addpath /opt/brew/bin
profile_addpath /Local/Library/PostgreSQL/Current/bin
profile_addpath /Library/PostgreSQL/Current/bin

export PATH