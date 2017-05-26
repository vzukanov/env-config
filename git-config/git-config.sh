#!/bin/bash

source $ENV_CONFIG_DIR/bash-functions/isSymlinkToSpecificFile.sh


# Ensure git installed
command -v git > /dev/null 2>&1 || { echo "Git not found. Aborting!"; return 1; }

SYSTEM_GITCONFIG=~/.gitconfig
MY_GITCONFIG=$ENV_CONFIG_DIR/git-config/gitconfig

echo Checking existence of $SYSTEM_GITCONFIG

if isSymlinkToSpecificFile $SYSTEM_GITCONFIG $MY_GITCONFIG ; then
    echo $SYSTEM_GITCONFIG is already a symlink to $MY_GITCONFIG
    return 0
fi

# Backup exisitng gitconfig if exists 
if [[ -f "$SYSTEM_GITCONFIG" || -L "$SYSTEM_GITCONFIG" ]] ; then
    GITCONFIG_BAK=~/gitconfig.bak
    echo Moving existing $SYSTEM_GITCONFIG to $GITCONFIG_BAK
    mv $SYSTEM_GITCONFIG $GITCONFIG_BAK
fi

echo Creating symlink from $SYSTEM_GITCONFIG to $MY_GITCONFIG
ln -s $MY_GITCONFIG $SYSTEM_GITCONFIG
