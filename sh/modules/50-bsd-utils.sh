_bsd_utils_init() {
	if ls --version 2>/dev/null >/dev/null ; then
		bsd_utils_enabled=no
	fi
}

_bsd_utils_fini() {
	CLICOLOR=1
	export CLICOLOR
}

