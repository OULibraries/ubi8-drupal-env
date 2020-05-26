#!/bin/bash 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/library.sh"

if [  -z "$1" ]; then
  cat <<USAGE
drp_composer.sh runs composer in a container  
Usage: ./bin/drp_composer.sh \$ARGS
\$ARGS    subcommands and arguments to send to composer. 
USAGE
  exit 1;
fi

HOST_UID=$(id -u)
HOST_GID=$(id -g)

docker run --user ${HOST_UID}:${HOST_GID}  --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli composer  "$@"
