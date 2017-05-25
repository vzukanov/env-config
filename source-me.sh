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
export TERM=xterm-256color

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

GIT_CONFIG_DIR=$ENV_CONFIG_DIR/git-config
GIT_CONFIG_SCRIPT=$GIT_CONFIG_DIR/git-config.sh

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

EMACS_CONFIG_DIR=~/.emacs.d
MY_EMACS_CONFIG_REPO=https://github.com/vzukanov/.emacs.d.git

if [[ -e "$EMACS_CONFIG_DIR" ]] ; then
    cd $EMACS_CONFIG_DIR
    TRACKED_REPO=`git config --get remote.origin.url`
    cd - > /dev/null
    if [[ $TRACKED_REPO == $MY_EMACS_CONFIG_REPO ]] ; then
	echo $EMACS_CONFIG_DIR already exists and tracks correct origin
    else
	echo Moving $EMACS_CONFIG_DIR to $EMACS_CONFIG_DIR.bak
	mv $EMACS_CONFIG_DIR $EMACS_CONFIG_DIR.bak
	echo Clonning $MY_EMACS_CONFIG_REPO into $EMACS_CONFIG_DIR
	git clone $MY_EMACS_CONFIG_REPO $EMACS_CONFIG_DIR	
    fi
else
    echo Clonning $MY_EMACS_CONFIG_REPO into $EMACS_CONFIG_DIR
    git clone $MY_EMACS_CONFIG_REPO $EMACS_CONFIG_DIR
fi
