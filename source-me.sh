#!/bin/bash

echo Starting environment configuration

export ENV_CONFIG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo Root directory: $ENV_CONFIG_DIR

echo ----------------------------------------

########################################
# Aliases
########################################

source $ENV_CONFIG_DIR/bash_aliases

########################################
# Git configuration
########################################

GIT_CONFIG_DIR=$ENV_CONFIG_DIR/git-config
GIT_CONFIG_SCRIPT=$GIT_CONFIG_DIR/git-config.sh

if [[ -e "${GIT_CONFIG_SCRIPT}" ]] ; then
    echo Git configuration script: $GIT_CONFIG_SCRIPT
    source "${GIT_CONFIG_SCRIPT}" || return 1;
else
    echo Git configuration script wasn´t found: $GIT_CONFIG_SCRIPT
    return 1
fi

echo ----------------------------------------