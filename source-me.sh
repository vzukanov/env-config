#!/bin/bash

echo Starting environment configuration

export ENV_CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo Root directory of configuration files: $ENV_CONFIG_DIR

########################################
# Environmental variables
########################################

echo ----------------------------------------
echo Configuring environmental variables

# Customize the prompt
export PS1="\[\e[32m\]\A \W \[\e[1;32m\] \$ \[\e[0m\]"

# Make default term with 256 colors - allows for good looking
# terminal based Emacs
# I commented this out because https://wiki.archlinux.org/index.php/Xterm advice
# against setting this variable from shell config scripts...
# export TERM=xterm-256color

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

