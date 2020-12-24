# Add any paths matching /opt/*/bin to the pathspec
#
# Set opt_paths_enabled=no in ~/.profile.rc to disable

_opt_paths_init() {
	local i
	
	if test -d /opt ; then
		for i in /opt/* ; do
			pathspec "$i/bin"
		done
	fi
}
