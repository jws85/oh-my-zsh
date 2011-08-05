################################################################################
# Author: Justin Smith
# Email: pete[dot]clark[at]gmail[dot]com
# Version: 0.1 (08/03/2011)
# License: WTFPL<http://sam.zoy.org/wtfpl/>
#
# oh-my-zsh plugin for etm
#
# (Structure of plugin taken from Pete Clark's taskwarrior plugin, a bit.)
################################################################################

#zstyle ':completion:*:*:task:*' verbose yes
#zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
#
#zstyle ':completion:*:*:task:*' group-name ''

# main command
alias e=e.py
#compdef _etm e=etm

# busy times
alias eb='e.py b'
#compdef _etm eb=etm

# outline
alias eo='e.py o'
#compdef _etm eo=etm

# GUI
alias ew=e.pyw
#compdef _etm ew=etm
