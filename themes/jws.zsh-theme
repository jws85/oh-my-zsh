# ----------------------------------------------------------------------
# jws' theme for oh-my-zsh
# Modified version of tjkirch's theme.  Pretty simple... so far.
#
# You can export the PCOLOR variable with a color (i.e. %{$fg[red]%})
# in your zshrc to color the prompt character differently.  I'd 
# recommend leaving your main machine white, and avoiding red because 
# that's what the root prompt uses.
# ----------------------------------------------------------------------

# colors
R="%{$fg[red]%}"
M="%{$fg[magenta]%}"
C="%{$fg[cyan]%}"
B="%{$fg[blue]%}"
Y="%{$fg[yellow]%}"
G="%{$fg[green]%}"
X="%{$reset_color%}"

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="($B"
ZSH_THEME_GIT_PROMPT_SUFFIX="$X)"
ZSH_THEME_GIT_PROMPT_DIRTY=" $R*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Which character to display for the prompt
function prompt_char {
	if [ $UID -eq 0 ]; then echo "$R#$X"; else echo $; fi
}

# The prompt itself.  Top line displays "with the previous command's output"
PROMPT='$G-> Finished at %* $R%(?, ,>>> Fail: $?)$X

$R%n$X@$M%m$X: $C%~$X $(git_prompt_info)
$G%_$X$PCOLOR$(prompt_char)$X '

# Haven't figured out anything interesting to do with this
RPROMPT=''

# vim: syntax=sh
