_textmate_init() {
	# if VISUAL or EDITOR are already set, don't mess with them
	[ -z "$VISUAL" ] || textmate_enabled=no
	[ -z "$EDITOR" ] || textmate_enabled=no
}

_textmate_fini() {
	if [ $is_macosx -eq 1 ] ; then
		true
		# if `mate` exists, set VISUAL to "/path/to/mate -w"
	else
		# check to see if we should use `rmate`
		true
	fi
}