test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.banner.sh" >&2

## In a new login shell, print a banner
if [ $is_interactive -eq 1 ] && [ $is_login -eq 1 ] ; then
	col="${ansi_byellow}"
	[ $is_local -eq 1 ] && col="${ansi_bmagenta}"
	printf "${ansi_reset}${col}"
	printf -- "-%.0s" {1..78}
	printf "${ansi_reset}\n"
	printf "${col}%s@%s - %s (%s)${ansi_reset}\n" "`whoami`" ""`hostname`"" "`uname -sr`" "`uname -m`"
	uptime=$(echo `uptime`)
	printf "${ansi_reset} %s\n" "$uptime"
	date=`date +"%A %e %B %Y %H:%M:%S %z (%Z)"`
	printf "${ansi_bwhite} %s\n" "$date"
	printf "${ansi_reset}${col}"
	printf -- "-%.0s" {1..78}
	printf "${ansi_reset}\n"
fi
