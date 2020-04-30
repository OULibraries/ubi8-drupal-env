#!/bin/bash 

HOST_UID=$(id -u)
HOST_GID=$(id -g)

docker run --user ${HOST_UID}:${HOST_GID}  --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli composer  "$@"
