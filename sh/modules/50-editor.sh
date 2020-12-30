# placeholder

_editor_init() {
	# if VISUAL or EDITOR are already set, don't mess with them
	[ -z "$VISUAL" ] || editor_enabled=no
	[ -z "$EDITOR" ] || editor_enabled=no
}

_editor_done() {
	true
}