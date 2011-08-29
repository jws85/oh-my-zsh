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

# n.b.: from http://zanshin.net/2011/08/12/oh-my-zsh/
# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "(%{$M%}detached$X)"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}

# Which character to display for the prompt
function prompt_char {
	if [ $UID -eq 0 ]; then echo "$R#$X"; else echo $; fi
}

# The prompt itself.  Top line displays "with the previous command's output"
PROMPT='$G-> Finished at %* $R%(?, ,>>> Fail: $?)$X

$R%n$X@$M%m$X: $C%~$X $(check_git_prompt_info)
$G%_$X$PCOLOR$(prompt_char)$X '

# Show history number (ripped from the 'blinks' theme)
RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'

# vim: syntax=sh
