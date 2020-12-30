
_line_editor_fini() {
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
