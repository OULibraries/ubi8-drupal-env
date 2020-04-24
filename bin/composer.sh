#!/bin/bash 

podman run --volume "$PWD":/mnt/data:z --workdir /mnt/data --rm -it drp-cli composer  "$@"
