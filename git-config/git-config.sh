#!/bin/bash

source $ENV_CONFIG_DIR/bash-functions/createSymlinkBackupIfExists.sh


# Ensure git installed
command -v git > /dev/null 2>&1 || { echo "Git not found. Aborting!"; return 1; }

SYSTEM_GITCONFIG=~/.gitconfig
MY_GITCONFIG=$ENV_CONFIG_DIR/git-config/gitconfig

createSymlinkBackupIfExists $SYSTEM_GITCONFIG $MY_GITCONFIG
