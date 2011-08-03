R="%{$fg[red]%}"
M="%{$fg[magenta]%}"
C="%{$fg[cyan]%}"
B="%{$fg[blue]%}"
Y="%{$fg[yellow]%}"
G="%{$fg[green]%}"
X="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="($B"
ZSH_THEME_GIT_PROMPT_SUFFIX="$X)"
if [[ $DEGRADE == 1 ]]; then
	ZSH_THEME_GIT_PROMPT_DIRTY="$R*"
else
	ZSH_THEME_GIT_PROMPT_DIRTY="$R⚡"
fi
	
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "$R#$X"; else echo $; fi
}

PROMPT='$G-> Finished at %* $R%(?, ,>>> Fail: $?)$X

$R%n$X@$M%m$X: $C%~$X $(git_prompt_info)
$G%_$X$PCOLOR$(prompt_char)$X '

RPROMPT=''

# vim: syntax=sh
