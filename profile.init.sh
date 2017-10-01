test x"$PROFILE_TRACE" = x"yes" && echo ">> .profile.init.sh" >&2

## Determine the name of the shell
shell_name="sh"
test x"$BASH_VERSION" = x"" || shell_name="bash"
test x"$ZSH_NAME" = x"" || shell_name="zsh"

## Determine whether this is an interactive shell
is_interactive=0
[[ $- == *i* ]] && is_interactive=1

## Determine whether this is a login shell
is_login=0
case "$shell_name" in
	bash)
		shopt -q login_shell && is_login=1
		;;
	zsh)
		[[ -o login ]] && is_login=1
		;;
esac

## Determine whether this is a remote or a local session
if test x"$SHELL_LOCATION" = x"remote" ; then
	is_local=0
elif test x"$SHELL_LOCATION" = x"local" ; then
	is_local=1
elif test -z "$SSH_CLIENT" && test -z"$SSH_CONNECTION" ; then
	is_local=1
	SHELL_LOCATION="local"
else
	is_local=0
	SHELL_LOCATION="remote"
fi
export SHELL_LOCATION

## Detect Mac OS X
is_macosx=0
[ x"$Apple_Ubiquity_Message" = x"" ] || is_macosx=1
[ x"$TERM_PROGRAM" = x"Apple_Terminal" ] && is_macosx=1
[ x"$TERM_PROGRAM" = x"iTerm.app" ] && is_macosx=1

## On interactive shells, determine whether we should set the
## prompt or not based upon whether the contents of PS1/PS2/PROMPT_COMMAND
## contain default values

update_ps1=0
update_ps2=0
update_promptcmd=0

if [ $is_interactive -eq 1 ] ; then
	if test x"$PS1" = x'# ' || \
		test x"$PS1" = x'$ ' || \
		test x"$PS1" = x'\$ ' || \
		test x"$PS1" = x'\s-\v\$ ' || \
		test x"$PS1" = x'\u@\h:\w\$ ' || \
		test x"$PS1" = x'\h:\W \u\$ ' || \
		test x"$PS1" = x'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' || \
		test x"$PS1" = x"%m%#" ; then
		update_ps1=1
	fi
	if test x"$PS2" = x'> ' || test x"$PS2" = x"%_>" ; then
		update_ps2=1
	fi
	if test x"$PROMPT_COMMAND" = x"" || \
		test x"$PROMPT_COMMAND" = x"update_terminal_cwd; " || \
		test x"$PROMPT_COMMAND" = x"update_terminal_cwd" || \
		test x"$PROMPT_COMMAND" = x"shell_session_history_check; update_terminal_cwd" || \
		test x"$PROMPT_COMMAND" = x"update_terminal_cwd; shell_session_history_check; update_terminal_cwd"; then
		update_promptcmd=1
	fi
fi