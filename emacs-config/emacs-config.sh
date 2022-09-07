#!/bin/bash

SYSTEM_EMACS_CONFIG_DIR=~/.emacs.d
MY_EMACS_CONFIG_REPO_REGEXP=".*vzukanov/.emacs.d.git$"

if [[ -e "$SYSTEM_EMACS_CONFIG_DIR" ]] ; then

    # check which git repo is being tracked by the current emacs config dir
    cd $SYSTEM_EMACS_CONFIG_DIR
    TRACKED_REPO=`git config --get remote.origin.url`
    cd - > /dev/null
    
    if [[ $TRACKED_REPO =~ $MY_EMACS_CONFIG_REPO_REGEXP ]] ; then
	echo $SYSTEM_EMACS_CONFIG_DIR already exists and tracks correct origin
    else
	echo Moving $SYSTEM_EMACS_CONFIG_DIR to $SYSTEM_EMACS_CONFIG_DIR.bak
	mv $SYSTEM_EMACS_CONFIG_DIR $SYSTEM_EMACS_CONFIG_DIR.bak
	echo Clonning $MY_EMACS_CONFIG_REPO into $SYSTEM_EMACS_CONFIG_DIR
	git clone $MY_EMACS_CONFIG_REPO $SYSTEM_EMACS_CONFIG_DIR	
    fi
else
    echo Clonning $MY_EMACS_CONFIG_REPO into $SYSTEM_EMACS_CONFIG_DIR
    git clone $MY_EMACS_CONFIG_REPO $SYSTEM_EMACS_CONFIG_DIR
fi
