
source $ENV_CONFIG_DIR/bash-functions/createSymlinkBackupIfExists.sh

SYSTEM_XRESOURCES=~/.Xresources
MY_XRESOURCES=$ENV_CONFIG_DIR/xterm-config/Xresources

createSymlinkBackupIfExists $SYSTEM_XRESOURCES $MY_XRESOURCES

xrdb -merge $SYSTEM_XRESOURCES
