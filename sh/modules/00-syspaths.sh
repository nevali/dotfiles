## Note that these are only added to PATH if they exist

_syspaths_init() {
	pathspec "$HOME/Tools/${NODENAME}"
	pathspec "$HOME/Tools/${SYSTYPE}"
	pathspec "$HOME/Tools"
	pathspec "$HOME/bin"

	pathspec /usr/local/bin
	pathspec /sbin
	pathspec /usr/sbin
	pathspec /usr/local/sbin
}
