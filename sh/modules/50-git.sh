# In interactive shells, install a hook which detects when the CWD is
# within a git repository and set ${_profile_vcbranch} to its name

_git_init() {
	[ $is_interactive -eq 1 ] || git_enabled=no
}

_git_fini() {
	profile_hook precmd _git_prompthook
}

_git_prompthook() {
	local gitbranch
	
	gitbranch=$( git symbolic-ref HEAD 2>/dev/null | sed -e 's!^refs/heads/!!' )
	if test x"$gitbranch" = x"" ; then
		_prompt_vcbranch=''
	else
		_prompt_vcbranch=":${gitbranch}"
	fi
}
