#!/bin/bash

# This function causes 'e' to start emacs in background
e() { emacs "$@" & }

alias c='clear'

alias l='less'

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
