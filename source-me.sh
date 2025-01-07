#!/bin/bash

# if not interactive shell - don't do anything
[[ $- != *i* ]] && return

echo
echo ----------------------------------------
echo Starting environment configuration


if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ] ; then
    SSH_SESSION=true
    echo The shell corresponds to ssh session
fi

if [ ! -z ${ZSH_VERSION+x} ]; then
    ZSH=true
elif [ ! -z ${BASH_VERSION+x} ]; then
    BASH=true
else
    echo "unsupported shell type"
fi

# Find out where this script is located
if [ "$BASH" = true ] ; then
    export ENV_CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elif [ "$ZSH" = true ] ; then
    export ENV_CONFIG_DIR="${0:A:h}"
else
    echo "unsupported shell type"
fi

echo Root directory of configuration files: $ENV_CONFIG_DIR

# Detect WSL env on Windows
if grep -qEi "(microsoft|wsl)" /proc/version &> /dev/null ; then
    export ENV_CONFIG_WSL="true"
else
    export ENV_CONFIG_WSL="false"
fi

# Detect Cygwin env on Windows
if [[ `uname -o` == "Cygwin" ]] ; then
    export ENV_CONFIG_CYGWIN="true"
fi


########################################
# Environmental variables
########################################

echo ----------------------------------------
echo Configuring environmental variables

if [  "$SSH_SESSION" = true ] ; then
    # Do nothing
else
    # Customize the prompt for non-ssh sessions
    if [ "$BASH" = true ] ; then
        export PS1="\[\e[32m\]\A \W \[\e[1;32m\]\$ \[\e[0m\]"
    elif [ "$ZSH" = true ] ; then
        autoload -U colors && colors
        export PS1=$'%{\e[32m%}%D{%H:%M} %1d %{\e[1;32m%}\$ %{\e[0m%}'
    else
        echo "unsupported shell type"
    fi
fi

# Make less search case insensitive, while preserving the colors
# and keeping the output in the terminal
export LESS='-iRX'

########################################
# Shell configurations
########################################

export LSCOLORS="Exfxcxdxcxegecabagacad" 

if [ "$ZSH" = true ] ; then
    setopt noautomenu # disable zsh's default circling through auto-complete options
fi


########################################
# History
########################################

unset HISTFILESIZE
export HISTSIZE=10000
export SAVEHIST=10000

if [ "$BASH" = true ] ; then
    echo "Configuring history for Bash"
    shopt -s histappend
    export PROMPT_COMMAND="history -a; history -n"
    export HISTTIMEFORMAT="[%F %T] "
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
elif [ "$ZSH" = true ] ; then
    echo "Configuring history for Zsh"
    setopt BANG_HIST                 # Treat the '!' character specially during expansion.
    setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
    setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY             # Share history between all sessions.
    setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
    setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
    setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
    bindkey "^[[A" history-beginning-search-backward
    bindkey "^[[B" history-beginning-search-forward
else
    echo "unsupported shell type"
fi

########################################
# Aliases
########################################

echo ----------------------------------------
echo Configuring aliases

source $ENV_CONFIG_DIR/bash_aliases

########################################
# Git configuration
########################################

echo ----------------------------------------
echo Configuring Git

GIT_CONFIG_SCRIPT=$ENV_CONFIG_DIR/git-config/git-config.sh

if [[ -e "$GIT_CONFIG_SCRIPT" ]] ; then
    echo Git configuration script: $GIT_CONFIG_SCRIPT
    source "$GIT_CONFIG_SCRIPT" || return 1;
else
    echo Git configuration script wasn´t found: $GIT_CONFIG_SCRIPT
    return 1
fi

echo ----------------------------------------

########################################
# Emacs configuration
########################################

echo ----------------------------------------
echo Configuring Emacs

EMACS_CONFIG_SCRIPT=$ENV_CONFIG_DIR/emacs-config/emacs-config.sh

if [[ -e "$EMACS_CONFIG_SCRIPT" ]] ; then
    echo Emacs configuration script: $EMACS_CONFIG_SCRIPT
    source "$EMACS_CONFIG_SCRIPT" || return 1;
else
    echo Emacs configuration script wasn´t found: $EMACS_CONFIG_SCRIPT
    return 1
fi

########################################
# Display configuration for X apps
########################################

echo ----------------------------------------
echo Configuring DISPLAY env variable

if [ "$ENV_CONFIG_WSL" = "true" ] ; then
    echo "WSL Bash detected; DISPLAY=localhost:0; LIBGL_ALWAYS_INDIRECT=1"
    export DISPLAY=localhost:0
    export LIBGL_ALWAYS_INDIRECT=1
else
    echo "Non-WSL Bash; no need to configure DISPLAY"
fi

########################################
# Xterm configuration
########################################

if [ "$SSH_SESSION" = true ] ; then
    # Don't configure Xterm if ssh session
    :
else
    echo ----------------------------------------
    echo Configuring Xterm

    XTERM_CONFIG_SCRIPT=$ENV_CONFIG_DIR/xterm-config/xterm-config.sh

    if [[ -e "$XTERM_CONFIG_SCRIPT" ]] ; then
	echo Xterm configuration script: $XTERM_CONFIG_SCRIPT
	source "$XTERM_CONFIG_SCRIPT" || return 1;
    else
	echo Xterm configuration script wasn´t found: $XTERM_CONFIG_SCRIPT
	return 1
    fi
fi
