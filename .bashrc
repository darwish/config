# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
. ~/.secrets
. ~/.bash_aliases


#=================
# Prompt
#=================

. ~/.prompt/prompt.sh


#=================
# Navigation
#=================
# . ~/scripts/z.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# From https://github.com/junegunn/fzf/wiki/Examples#z
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}


#=================
# Env
#=================

export LESS="$LESS -QFRX"
export EDITOR=vim

