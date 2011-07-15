# Aliases
alias g='git'
compdef g=git
alias gk='gitk --all'
alias gg='git gui'

# Add
alias ga='git add'
compdef _git ga=git-add
alias gai='git add --interactive'
compdef _git gai=git-add
alias gaa='git add -A'
compdef _git gaa=git-add
alias gap='git add -p'
compdef _git gap=git-add

# committing
alias gc='git commit'
compdef _git gc=git-commit
alias gca='git commit -a'
compdef _git gca=git-commit

# logging
alias gl='git log'
compdef _git gl=git-log
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log
alias gla='git log --graph --decorate --all'
compdef _git gla=git-log
alias glol='git log --graph --decorate --pretty=oneline --abbrev-commit'
compdef _git glol=git-log
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
compdef _git glola=git-log

# miscellaneous
alias gst='git status'
compdef _git gst=git-status
alias gpl='git pull'
compdef _git gpl=git-pull
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
gdv() { git-diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git
