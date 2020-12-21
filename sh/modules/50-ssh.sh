_ssh_fini() {
	if [ $is_interactive -eq 1 ] && [ $is_local -eq 1 ] && [ $is_macosx -eq 1 ] ; then
		ssh-add -A
	fi
}
