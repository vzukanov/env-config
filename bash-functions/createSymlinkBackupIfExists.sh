#!/bin/bash

source $ENV_CONFIG_DIR/bash-functions/isSymlinkToSpecificFile.sh

function createSymlinkBackupIfExists() {
    
    SYMLINK=$1
    TARGET=$2
    
    if [[ -z "$SYMLINK" ]] ; then
	echo Error: first argument to createSymlinkBackupIfExists is empty!
	return 1
    fi
    if [[ -z "$TARGET" ]] ; then
	echo Error: second argument to createSymlinkBackupIfExists is empty!
	return 1
    fi

    if isSymlinkToSpecificFile $SYMLINK $TARGET ; then
	echo $SYMLINK is already a symlink to $TARGET
	return 0
    fi

    # Backup exisitng gitconfig if exists 
    if [[ -f "$SYMLINK" || -L "$SYMLINK" ]] ; then
	SYMLINK_BACKUP=$SYMLINK.bak
	echo Moving existing $SYMLINK to $SYMLINK_BACKUP
	mv $SYMLINK $SYMLINK_BACKUP
    fi

    echo Creating symlink from $SYMLINK to $TARGET
    ln -s $TARGET $SYMLINK

}
