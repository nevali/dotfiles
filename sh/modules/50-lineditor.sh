_lineeditor_init() {
	true
}

_lineeditor_fini() {
	case "$shell_name" in
		ksh)
			set -o emacs
			;;
		zsh)
			bindkey -e
			;;
		bash)
			set -o emacs
			;;
	esac
}
