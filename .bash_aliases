#!/bin/bash


#=================
# MX aliases
#=================

source ~/.bash_aliases-mx
source ~/code/darwish/config-mx/mcd.sh
source ~/code/darwish/config-mx/review.sh
alias re=review


#=================
# Git aliases
#=================

alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git status'
alias gb='git branch -a'
alias gfo='git fetch origin master:master'
alias gapf='git commit -a --amend --no-edit && git push -f'
alias gsu='git submodule update'
alias gsl='git stash list'
alias gcmp='git checkout master && git pull'
alias ghpr='gh pr create --assignee=@me --web'

gi() {
    if [[ "${1:0:1}" == "t" ]]; then
        newcmd=(git "${1:1}" "${@:2}")

        # bash and zsh handle the read command slightly differently
        if [[ -n "$ZSH_VERSION" ]]; then
            read -r "?${newcmd[*]}? [Y/n] "
        else
            read -rp "${newcmd[*]}? [Y/n] "
        fi

        if [[ "$REPLY" == "" || "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
            "${newcmd[@]}"
        fi
    else
        echo "bash: gi: command not found..." >&2
        return 127
    fi
}


#=================
# Docker aliases
#=================

alias dpa='docker ps -a'
alias dclean='docker rm $(docker ps -aqf status=exited)'
alias ddangling='docker rmi $(docker images -qfdangling=true)'
de() {
    [[ ! -t 0 || ! -t 1 ]] && opt=-i || opt=-it

    container=$1
    shift

    if [[ -z "$container" ]]; then
        echo "No container specified" >&2
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        docker exec $opt "$container" bash
    else
        docker exec $opt "$container" "$@"
    fi
}

_de() {
    _completion_loader docker
    export COMP_WORDS=(docker exec)
    line="${COMP_WORDS[*]} "
    COMP_CWORD=${#COMP_WORDS[@]} COMP_LINE="$line" COMP_POINT=${#line} _docker
}
complete -F _de de


#=================
# Misc aliases
#=================

# Alias sudo with a trailing space so that the word after will also be checked for aliases
# https://askubuntu.com/a/22043
alias sudo='sudo '

alias ll='ls -al --color=auto'

# Default vim to multiple tabs instead of multiple buffers and alias vi to vim as well
alias vim='vim -p'
alias vi='vim -p'

# Copy either stdin or file argument to clipboard
alias xc='xclip -selection clipboard'

# Shortcut to view process forest
alias psf='ps -efj --forest | less'

# Alias for SSH without bothering with known_hosts
alias sssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Alias for SSH without offering keys
alias nssh='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# Print text output for an x509 certificate
alias cert='openssl x509 -noout -text -in'

# Edit a file (e.g. ~/.bashrc) and immediately source it
vimsrc() {
    vim "$1" && . "$1"
}

f() {
    find -name "$1"
}

