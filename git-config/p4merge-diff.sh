#!/bin/sh

library=githelperfunctions.sh

#[ -f $library ] && . $library
. $library

# echo Launching p4merge.exe - p4merge-diff.sh:

set_path_vars "$1" "$2" "$3" "$4"

#"$p4mergewinpath" /dl "LOCAL.$caption" /dr "TO_VERSION.$caption" "$localwinpath" "$remotewinpath"

"$p4mergewinpath" "$localwinpath" "$remotewinpath"
