R="%{$fg[red]%}"
M="%{$fg[magenta]%}"
C="%{$fg[cyan]%}"
B="%{$fg[blue]%}"
Y="%{$fg[yellow]%}"
G="%{$fg[green]%}"
X="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="($B"
ZSH_THEME_GIT_PROMPT_SUFFIX="$X)"
ZSH_THEME_GIT_PROMPT_DIRTY=" $R⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "$R#$X"; else echo $; fi
}

PROMPT='$R%(?, ,FAIL: $?
)$X
$R%n$X@$M%m$X: $C%~$X $(git_prompt_info)
$G%_$X$PCOLOR$(prompt_char)$X '

RPROMPT='$G%D{%H:%M}$X'
