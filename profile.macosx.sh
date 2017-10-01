test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.macosx.sh" >&2

## On Mac OS X interactive shells:-
#
# if Kaleidoscope is installed, use it for 'git diff' and 'svn diff'
#
# if TextMate's command-line integration is available, use it as $VISUAL

if test $is_macosx -eq 1 && test $is_interactive -eq 1 ; then
	for d in /usr/local/bin /opt/local/bin "$HOME/bin" "$HOME/Tools" /Volumes/iDisk/Tools ; do
		
		if test -x "$d/kaleidoscope-git" ; then
		   GIT_EXTERNAL_DIFF="$d/kaleidoscope-git"
		   export GIT_EXTERNAL_DIFF
		fi
		if test -x "$d/ksdiff" ; then
			SVN_EXTERNAL_DIFF="$d/ksdiff"
			export SVN_EXTERNAL_DIFF
		fi
		if test -x "$d/mate" ; then
			def_visual="$d/mate -w"
			export VISUAL
		fi

	done
fi
