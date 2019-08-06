# Helper functions


convert_path () {
    file=$1

    if [ "$ENV_CONFIG_CYGWIN" = "true" ] ; then
	if [ "$file" == '/dev/null' ] || [ ! -e "$file" ] ; then 
            file="/tmp/nulla"
            `echo "">$file`
	fi
	echo `cygpath -aw "$file"`
    fi

    
    if [ "$ENV_CONFIG_WSL" = "true" ] ; then
	echo `wslpath -am "$file"`
    fi
}


set_path_vars () {
    base=$1
    local=$2
    remote=$3
    merged=$4

    # echo ========= Original paths =======
    # echo "BASE    :  $base"
    # echo "LOCAL   :  $local"
    # echo "REMOTE  :  $remote"
    # echo "MERGED  :  $merged"

    localwinpath=$(convert_path "$local")
    remotewinpath=$(convert_path "$remote")
    basewinpath=$(convert_path "$base")
    mergedwinpath=$(convert_path "$merged")

    # echo ========= Converted paths =======
    # echo "BASE    :  $basewinpath"
    # echo "LOCAL   :  $localwinpath"
    # echo "REMOTE  :  $remotewinpath"
    # echo "MERGED  :  $mergedwinpath"

    if [ "$ENV_CONFIG_CYGWIN" = "true" ] ; then
	p4mergewinpath="C:/Program Files/Perforce/p4merge.exe"
    fi
    
    if [ "$ENV_CONFIG_WSL" = "true" ] ; then
	p4mergewinpath="/mnt/c/Program Files/Perforce/p4merge.exe"
    fi
}
