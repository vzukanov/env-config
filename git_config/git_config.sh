#!/bin/bash

# Ensure git installed
command -v git > /dev/null 2>&1 || { echo "Git not found. Aborting!"; return 1; }

SYSTEM_GITCONFIG=~/.gitconfig
MY_GITCONFIG=$GIT_CONFIG_DIR/gitconfig

# Backup exisitng gitconfig if exists
if [ -f "${SYSTEM_GITCONFIG}" ] ; then
    DATE=`date -Iseconds`
    GITCONFIG_BAK=~/gitconfig.bak.$DATE
    echo Moving existing $SYSTEM_GITCONFIG to $GITCONFIG_BAK
    mv $SYSTEM_GITCONFIG $GITCONFIG_BAK
fi

# Create symlink to gitconfig file
echo Creating symlink from $SYSTEM_GITCONFIG to $MY_GITCONFIG
ln -s $MY_GITCONFIG $SYSTEM_GITCONFIG
