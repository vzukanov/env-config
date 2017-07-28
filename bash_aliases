#!/bin/bash

# This function causes 'e' to start emacs 
e() {
    if [ "$SSH_SESSION" = true ] ; then
	# Foreground no-window mode for ssh shells
	TERM=xterm-256color emacs -nw "$@" 
    else
	# Background for non-ssh shells
	TERM=xterm-256color emacs "$@" &
    fi
}

alias c='clear'

alias l='less'

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
