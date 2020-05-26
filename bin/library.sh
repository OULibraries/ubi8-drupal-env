
# Parse docker-compose .env file for vars and make those available to scripts
function export_docker_vars  {
  DRP_ENV="$(dirname "${BASH_SOURCE}")/../.env"
  export $( sed 's:#.*$::g' "${DRP_ENV}"  | xargs)

}

