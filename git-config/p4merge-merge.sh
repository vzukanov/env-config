#!/bin/sh

library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

# echo Launching p4merge.exe - p4merge-merge.sh:


set_path_vars "$1" "$2" "$3" "$4"

# -- use p4mergeU conflictFile
"$p4mergewinpath"  "$basewinpath" "$localwinpath" "$remotewinpath" "$mergedwinpath"
