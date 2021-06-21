_textmate_init() {
	# if VISUAL or EDITOR are already set, don't mess with them
	[ -z "$VISUAL" ] || textmate_enabled=no
	[ -z "$EDITOR" ] || textmate_enabled=no
}

_textmate_fini() {
	if [ $is_macosx -eq 1 ] ; then
		if [ -x /usr/local/bin/mate ] ; then
			VISUAL="/usr/local/bin/mate -w"
			export VISUAL
		fi
	else
		# check to see if we should use `rmate`
		true
	fi
}