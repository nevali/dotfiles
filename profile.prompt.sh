test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.prompt.sh" >&2

profile_curdir=''

if test $shell_name = zsh ; then
	setopt promptsubst
	nps='%{'
	npe='%}'
	prompt_user='%n'
	prompt_host='%m'
	prompt_path=' ${profile_curdir}'
	prompt_ind='%#'
	prompt_ps2='%_>'
elif test $shell_name = bash ; then
	nps='\['
	npe='\]'
	prompt_user='\u'
	prompt_host='\h'
	prompt_path=' \W'
	prompt_ind='\$'
	prompt_ps2='>'
else
	prompt_user="$LOGNAME"
	prompt_host=`hostname | cut -f1 -d.`
	prompt_path=''
	prompt_ind='$'
	prompt_ps2='>'
fi

pbit_preamble="${nps}${ansi_reset}${ansi_bnormal}${npe}[${nps}${ansi_normal}${npe}\${profile_timestamp} "
pbit_postamble="${nps}${ansi_bnormal}${npe}]${nps}${ansi_bred}${npe}${prompt_ind} ${nps}${ansi_normal}${npe}"
if test $is_local -eq 1 ; then
	pbit_user="${nps}${ansi_bgreen}${npe}${prompt_user}"
else
	pbit_user="${nps}${ansi_bcyan}${npe}${prompt_user}${nps}${ansi_green}${npe}@${nps}${ansi_bcyan}${npe}${prompt_host}"
fi

pbit_vcs="${nps}${ansi_bblue}${npe}\${profile_branch}${nps}${ansi_cyan}${ansi_bold}${npe}"
pbit_path="${nps}${ansi_reset}${ansi_bmagenta}${npe}${prompt_path}"

def_ps1="${pbit_preamble}${pbit_user}${pbit_vcs}${pbit_path}${pbit_postamble}"
def_ps2="${nps}${ansi_reset}${ansi_bred}${npe}${prompt_ps2}${nps}${ansi_normal}${npe} "
def_prompt_command="profile_precmd"

## Update shell variables used when evaluating $PS1 (including updating the
## window title and, on Mac OS X, current working directory)
profile_precmd()
{
	profile_vcbranch
	profile_timestamp
	profile_cwd
	profile_title

	if type -t update_terminal_cwd 2>/dev/null >&2 ; then
		update_terminal_cwd
	fi
	if type -t shell_session_history_check 2>/dev/null >&2 ; then
		shell_session_history_check
	fi
}

## Determine profile_curdir
profile_cwd()
{
	local here
	
	here=`pwd`
	if test x"$here" = x"$HOME" ; then
		profile_curdir='~'
	else
		profile_curdir=`basename "$here"`
	fi
}

## Determine the current timestamp (profile_timestamp)
profile_timestamp()
{
	profile_timestamp=`date +%H%M%S`
}

## Set the window title
profile_title()
{
	local suf
	
	if test x"$TERM" = x"xterm" || test x"$TERM" = x"xterm-color" || test x"$TERM" = x"xterm-256color" ; then
		test x"$NODENAME" = x"" && NODENAME=`echo $HOSTNAME|cut -f1 -d.`
		suf='$'
		test x"$UID" = x"0" && suf='#'
		if test x"$TERM_PROGRAM" = x"Apple_Terminal" ; then
			printf "\033]2;[%s@%s%s]%s\007" "$LOGNAME" "$NODENAME" "$profile_branch" "$suf"
		else
			printf "\033]2;[%s@%s%s %s]%s\007" "$LOGNAME" "$NODENAME" "$profile_branch" "$profile_curdir" "$suf"
			printf "\033]1;%s@%s\007" "$LOGNAME" "$NODENAME"
		fi
	fi
#	if test x"$TERM" = x"tmux" || test x"$TERM" = x"screen" || test x"$TERM" = x"xterm-256color" ; then
#		printf "\033k[%s@%s%s %s]%s\033\\" "$LOGNAME" "$NODENAME" "$df__branch" "$curdir" "$suf"
#	fi
}


## Determine what VCS branch, if any, the CWD is on
profile_vcbranch()
{
	local gitbranch
	
	gitbranch=`( git symbolic-ref HEAD | sed -e 's!^refs/heads/!!' ) 2>/dev/null`
	if test x"$gitbranch" = x"" ; then
		profile_branch=''
	else
		profile_branch=" git:$gitbranch"
	fi
}
