#!/bin/bash

function isSymlinkToSpecificFile() {
    if [[ -z "$1" ]] ; then
	echo Error: first argument to isSymlinkToSpecificFile is empty!
	return 1
    fi
    if [[ -z "$2" ]] ; then
	echo Error: second argument to isSymlinkToSpecificFile is empty!
	return 1
    fi

    local linkTarget
    if [[ -L "$1" && `readlink $1 | xargs realpath` == `realpath $2` ]] ; then
	return 0
    else
	return 1
    fi
    
}

