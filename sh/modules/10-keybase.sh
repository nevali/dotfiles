# Keybase integration

unset KBFSUSER
unset KBFSROOT

_keybase_fini() {
	pathspec /Applications/Utilities/Keybase.app/Contents/SharedSupport/bin
	pathspec /Applications/Keybase.app/Contents/SharedSupport/bin

	KBFSUSER=$(keybase whoami 2>/dev/null)

	if [ $? -ne 0 ] ; then
		unset KBFSUSER
		debug "keybase" "Keybase is not available"
		return 1
	fi
	notice "keybase" "Logged in to Keybase as %s" ${KBFSUSER}
	
	if [ "${SYSTYPE}" = "Darwin" ] ; then
		if test -d "/Volumes/Keybase (${LOGNAME})/public" ; then
			KBFSROOT="/Volumes/Keybase (${LOGNAME})"
			return
		fi
	fi
	if [ -d /keybase/public ] ; then
		KBFSROOT="/keybase"
	fi
	
	if [ x"$KBFSROOT" = x"" ] ; then
		warn "keybase" "No Keybase filesystem root could be located"
		return
	fi
	export KBFSROOT KBFSUSER
	debug "keybase" "Keybase root located at %s" "$KBFSROOT"
}
