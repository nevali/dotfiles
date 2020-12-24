# Portable Home Directories (PHDs)

# Sets:
#  PHD
#  XDG_DATA_HOME
#  XDG_CONFIG_HOME

unset PHD

_phd_init() {
	# if ~/.profile.portable doesn't exist, bail out
	[ -r "$HOME/.profile.portable" ] || phd_enabled=no
}

_phd_fini() {
	if [ x"$KBFSROOT" = x"" ] ; then
		debug "phd" "No portable home available"
		return
	fi
	PHD="${KBFSROOT}/private/${KBFSUSER}"
	export PHD

	notice "phd" "Portable home activated at %s" "$PHD"
	cd "${PHD}" || fatal "phd" "Failed to change working directory to %s" "${PHD}"

	if [ x"$XDG_DATA_HOME" = x"" ] ; then
		debug "phd" "Updating \${XDG_DATA_HOME}"
		if ! [ -d .share ] ; then
			mkdir .share || fatal "phd" "Failed to create %s/.share" "${PHD}"
		fi
		XDG_DATA_HOME="$PHD/.share"
		export XDG_DATA_HOME
	fi

	if [ x"$XDG_CONFIG_HOME" = x"" ] ; then
		debug "phd" "Updating \${XDG_CONFIG_HOME}"
		if ! [ -d .config ] ; then
			mkdir .config || fatal "phd" "Failed to create %s/.config" "${PHD}"
		fi
		XDG_CONFIG_HOME="$PHD/.config"
		export XDG_CONFIG_HOME
	fi



	pathspec_prepend "$PHD/Tools/${NODENAME}"
	pathspec_prepend "$PHD/Tools/${SYSTYPE}"
	pathspec_prepend "$PHD/Tools"
	pathspec_prepend "$PHD/bin"

	if test -r "$PHD/.profile.portable" ; then
		info "phd" "Loading shared preferences from $PHD/.profile.portable"
		. "$PHD/.profile.portable"
	fi
}
