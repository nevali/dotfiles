_ssh_init() {
	[ $is_interactive -ge 1 ] || ssh_enabled=no
	[ $is_local -ge 1 ] || ssh_enabled=no
}

_ssh_fini() {
	if [ $is_macosx -eq 1 ] ; then
		# Add any keys whose passphrases are stored in the Keychain
		ssh-add -A
	fi
}
