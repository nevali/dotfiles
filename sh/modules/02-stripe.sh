
stripe() {
	local lines=${LINES:-24}
	local cols=${COLUMNS:-80}
	local s=$(expr $cols / 2 - 2)

	reset
	clear
	gotoxy 1 1
	printf "%s%s%s%-${cols}s" "${ansi_reset}" "${ansi_bgblue}" "${ansi_bwhite}" " "
	gotoxy 1 1
	printf " %-${s}s %s%${s}s " "$(uname -rs)" "${ansi_byellow}" "${NODENAME}"
	printf "%s" "${ansi_reset}"
	gotoxy 1 2
	
}

_stripe_init() {
	[ $is_interactive -eq 1 ] || stripe_enabled=no
	[ $is_login -eq 1 ] || stripe_enabled=no
	[ $has_ansi -eq 1 ] || stripe_enabled=no
	show_stripe=${show_stripe:-no}
	[ $show_stripe = "yes" ] || stripe_enabled=no
}

_stripe_fini() {
	stripe
}