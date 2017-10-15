test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.colours.sh" >&2

## Terminal escape sequences
have_colorterm=0
nps=`printf "\001"`
npe=`printf "\002"`
esc=`printf "\033"`
test "$shell_name" = "bash" && esc='\e'
ansi_reset="${esc}[0m"
ansi_bold="${esc}[1m"
ansi_black="${esc}[0m${esc}[30m"
ansi_red="${esc}[0m${esc}[31m"
ansi_green="${esc}[0m${esc}[32m"
ansi_yellow="${esc}[0m${esc}[33m"
ansi_blue="${esc}[0m${esc}[34m"
ansi_magenta="${esc}[0m${esc}[35m"
ansi_cyan="${esc}[0m${esc}[36m"
ansi_normal="${ansi_reset}"
ansi_bnormal="${ansi_reset}${ansi_bold}"

case "$TERM" in
	sun-color|linux)
		ansi_white="${ansi_normal}"
		ansi_bblack="${ansi_black}${ansi_bold}"
		ansi_bred="${ansi_red}${ansi_bold}"
		ansi_bgreen="${ansi_green}${ansi_bold}"
		ansi_byellow="${ansi_yellow}${ansi_bold}"
		ansi_bblue="${ansi_blue}${ansi_bold}"
		ansi_bmagenta="${ansi_magenta}${ansi_bold}"
		ansi_bcyan="${ansi_cyan}${ansi_bold}"
		ansi_bwhite="${ansi_white}${ansi_bold}"
		have_colorterm=1
		;;
	xterm|xterm-color|xterm-256color)
		ansi_white="${esc}[37m"
		ansi_bblack="${esc}[90m"
		ansi_bred="${esc}[91m"
		ansi_bgreen="${esc}[92m"
		ansi_byellow="${esc}[93m"
		ansi_bblue="${esc}[94m"
		ansi_bmagenta="${esc}[95m"
		ansi_bcyan="${esc}[96m"
		ansi_bwhite="${esc}[97m"    
		have_colorterm=1
		;;
	*)
		ansi_reset=""
		ansi_bold=""
		ansi_black=""
		ansi_red=""
		ansi_green=""
		ansi_yellow=""
		ansi_blue=""
		ansi_magenta=""
		ansi_cyan=""
		ansi_normal=""
		ansi_bnormal=""
		ansi_white=""
		ansi_bblack=""
		ansi_bred=""
		ansi_bgreen=""
		ansi_byellow=""
		ansi_bblue=""
		ansi_bmagenta=""
		ansi_bcyan=""
		ansi_bwhite=""
		;;
esac
