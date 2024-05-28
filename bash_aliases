#!/bin/bash

# This function causes 'e' to start emacs 
e() {
    if [ "$SSH_SESSION" = true ] ; then
	# Foreground process no-window mode for ssh shells
	TERM=xterm-256color emacs -nw "$@" 
    else
	# Background process windowed for non-ssh shells
        TERM=xterm-256color emacs "$@" &
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sleep 1 # give emacs time to start
            osascript -e 'tell application "Emacs" to activate' # bring to foreground after startup in macOS
        fi	
    fi
}

alias c='clear'

alias l='less'

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
