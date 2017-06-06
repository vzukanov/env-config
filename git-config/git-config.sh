#!/bin/bash

source $ENV_CONFIG_DIR/bash-functions/createSymlinkBackupIfExists.sh


# Ensure git installed
command -v git > /dev/null 2>&1 || { echo "Git not found. Aborting!"; return 1; }

# If running under Cygwin - need to set BASE_DIR env variable for p4merge to work

if [[ `uname -o` == "Cygwin" ]] ; then
    export PATH=$PATH:$ENV_CONFIG_DIR/git-config/cygwin/
fi


SYSTEM_GITCONFIG=~/.gitconfig
MY_GITCONFIG=$ENV_CONFIG_DIR/git-config/gitconfig

createSymlinkBackupIfExists $SYSTEM_GITCONFIG $MY_GITCONFIG
