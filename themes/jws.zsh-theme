# ------------------------------------------------------------------------------
#          FILE:  jws.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file.
#        AUTHOR:  J. W. Smith (jwsmith2spam@gmail.com)
#       VERSION:  0.1
#    SCREENSHOT:  n/a
# ------------------------------------------------------------------------------
# The 'jws' theme is an edited version of the 'tjkirch' theme.
# Among other things, it's smart enough to not query the version control in
# a sshfs volume

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Only display the git repo if not on a sshfs volume
function vcs_prompt {
	SSHFS_MOUNTS=$(mount | grep sshfs | sed -n 's/^.*on \([^ ]*\).*$/\1/p')
	pwd | grep "^$SSHFS_MOUNTS" > /dev/null
	if [ $? -eq 0 ]; then echo ""; else echo "$(git_prompt_info)"; fi
}

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}»%{$reset_color%}"; else echo »; fi
}

PROMPT='%(?, ,%{$fg[red]%}↳$?%{$reset_color%}
)
%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~ %{$reset_color%}$(vcs_prompt)
%_$(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

# vim: syntax=sh
