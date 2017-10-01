test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.dircolors.sh" >&2

## If 'ls' is GNU ls, then enable colourisation via 'ls --color=auto'
## Otherwise, the alias (if any) is OS-dependent
is_gnu_ls=0
if ls --version 2>/dev/null >/dev/null ; then
	is_gnu_ls=1
fi
if test -x "$HOME/.dircolors" ; then
	eval `"$HOME/.dircolors"`
elif test $is_gnu_ls -eq 1 ; then
	eval `dircolors -b`
fi
if test $is_gnu_ls -eq 1 ; then
	alias ls='ls --color=auto'
fi

CLICOLOR=1
export CLICOLOR
export LSCOLORS
export LS_COLORS
