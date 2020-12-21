## Determine what type of terminal device (if any) is in use and tailor
## output accordingly


csib=""
csie=""

_tty_early() {
	[ $is_interactive -eq 1 ] || return 0
	esc=`printf "\033"`
	test "$shell_name" = "bash" && esc='\e'

	case "$TERM" in
		xterm-256color|aixterm)
			has_ansi=1
			has_colour=1
			has_256colour=1
			has_xterm=1
			;;
		xterm|xterm-color|rxvt)
			has_ansi=1
			has_colour=1
			has_xterm=1
			;;
		sun-color|linux|vt340)
			has_ansi=1
			has_colour=1
			;;
		dumb|none)
			;;
		*)
			has_ansi=1
			;;
	esac

	if [ $has_ansi -eq 1 ] ; then
		csib="${esc}["
		csie="m"
	fi
	ansi_reset=$(tput sgr0)
	ansi_bold=$(tput bold)
	ansi_normal=$(tput sgr0)
	ansi_bnormal=$(tput sgr0 ; tput bold)
	for col in black red green yellow blue magenta cyan white ; do
		eval ansi_$col="$(tput setaf $(colourcode $col) 2>/dev/null)"
		eval ansi_b$col="$(tput setaf $(($(colourcode $col) + 8)) 2>/dev/null)"
		eval ansi_bg$col="$(tput setab $(colourcode $col) 2>/dev/null)"
		eval ansi_bgb$col="$(tput setab $(($(colourcode $col) + 8)) 2>/dev/null)"
	done
	
	if [ $has_256colour -eq 1 ] ; then
		true
	fi
}

colourcode()
{
	case "$1" in
		black) echo 0 ;;
		red) echo 1 ;;
		green) echo 2 ;;
		yellow|brown) echo 3 ;;
		blue) echo 4 ;;
		magenta|purple) echo 5 ;;
		cyan|teal) echo 6 ;;
		white|gray|grey) echo 7 ;;
	esac
}

cprintf()
{
	if [ $_term_dirty -eq 1 ] ; then
		_term_dirty=0
	fi
	printf $*
}

textcolor()
{
	local col
	
	[ $has_ansi -eq 1 ] || return 0
	col=$(colourcode "$1")
	printf "${csib}%d${csie}" $(( 30 + $col ))
}

reset()
{
	tput reset
}

clear()
{
	tput clear
}

scrollarea()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "${csib}%d;%dr" "$1" "$2"
}

scrollreset()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "${csib}r"
}

delline()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "${csib}%d;1H${csib}3K" "$1"
}

gotoxy()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "${csib}%d;%dH" "$2" "$1"
}

savecp()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "\0337"
}

restorecp()
{
	[ $has_ansi -eq 1 ] || return 0
	printf "\0338"
}

# _tty_prefix PREFIX COLOUR=bnormal [END-COLOUR=normal]
_tty_prefix() {
	local c s

	if [ x"$3" = x"" ] ; then
		s="${ansi_normal}"
	else
		eval s=\$"{ansi_$3}"
	fi	
	[ $has_ansi -ge 1 ] || return
	[ $has_colour -ge 1 ] || return
	if [ x"$1" = x"" ] ; then
		printf "%s" "$s"
		return
	fi
	if [ x"$2" = x"" ] ; then
		c="${ansi_bnormal}"
	else
		eval c=\$"{ansi_$2}"
	fi
	if [ x"$3" = x"" ] ; then
		s="${ansi_normal}"
	else
		eval s=\$"{ansi_$3}"
	fi
	printf "%s%s%s%s: %s" "${ansi_reset}" "$c" "$1" "${ansi_normal}" "$s"
}

_tty_early

if [ $has_ansi -ge 1 ] && [ $has_colour -ge 1 ] ; then
	
	# debug MODULE FORMAT ...
	debug() {
		local mod
		[ $profile_debug -ge 1 ] || return
		mod="$1"
		shift
		( printf "%s[Debug] " "${ansi_bblack}" ; _tty_prefix $mod bblack bblack ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
	}

	# info MODULE FORMAT ...
	info() {
		local mod
		mod="$1"
		shift
		( _tty_prefix "" bblack ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
	}

	# notice MODULE FORMAT ...
	notice() {
		local mod
		mod="$1"
		shift
		( _tty_prefix "" bblack bwhite ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
	}

	# warn MODULE FORMAT ...
	warn() {
		local mod
		mod="$1"
		shift
		( _tty_prefix "Warning" byellow ; _tty_prefix ${mod} bblack bnormal ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
	}
	
	# err MODULE FORMAT ...
	err() {
		local mod
		mod="$1"
		shift
		( _tty_prefix "Error" bred ; _tty_prefix ${mod} bblack bnormal ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
	}

	# fatal MODULE FORMAT ...
	fatal() {
		local mod
		mod="$1"
		shift
		( _tty_prefix "Critical error" bred ; _tty_prefix ${mod} bblack bnormal ; printf "$@" ; printf "%s\n" "${ansi_normal}" ) >&2
		exit 10
	}
	debug "tty" "Terminal type is %s, dimensions are %sx%s" "$TERM" "$COLUMNS" "$LINES"
fi
