# Helper functions
convert_path () {
    local file="$1"

    if [[ "$ENV_CYGWIN" == "true" ]]; then
        if [[ "$file" == "/dev/null" || ! -e "$file" ]]; then 
            file="/tmp/nulla"
            echo "" > "$file"
        fi
        cygpath -aw "$file"
        return
    fi

    if [[ "$ENV_WSL1" == "true" || "$ENV_WSL2" == "true" ]]; then
        wslpath -am "$file"
        return
    fi

    # If not in WSL or Cygwin, return original path
    echo "$file"
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
    
    if [[ "$ENV_CYGWIN" == "true" ]]; then
        p4mergewinpath="C:/Program Files/Perforce/p4merge.exe"
    elif [[ "$ENV_WSL1" == "true" || "$ENV_WSL2" == "true" ]];  then
        p4mergewinpath="/mnt/c/Program Files/Perforce/p4merge.exe"
    fi
}
