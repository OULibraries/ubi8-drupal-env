
# DRP Environment


## Requirements

To run sucessfully, you'll need: 

* a nice Unix environment (linux, MacOS, WSL2) 
* working AWS credentials with access to `ul-drp-data`
* working install of docker and docker-compose

It's recommended that you use [aws-vault](https://github.com/99designs/aws-vault) to manage your aws credentials.

## Building the containers 

To download Red Hat UBI base images, you'll need to authenticate with the Red Hat package registry using a Red Hat Registry Service Account, which can be created from your Red Hat Developer Account. See Red Hat's [Registry Authentication](https://access.redhat.com/RegistryAuthentication) page for general information, and then go to the [Registry](https://access.redhat.com/terms-based-registry/) page to set up a service account. 

Once you've created a service account run `docker login`:
```
docker login -u USERNAME https://registry.redhat.io
```

And then run `make all` to build the container set.  

## Using the containers

## Configuration

Create the require `.env` file pased on the provided `env_template` file. 

Important values to set include:

* `DRP_USER`- your unique user id, for publishing to the `ul-drp-data` bucket 
* `DRP_SITE_PATH` - path to a folder in the `sites` directory for the active Drupal site.  
* `MYSQL_ROOT_PASSWORD` - password for MySQL root user

NOTE: This file is a [Docker env file], not a shell file, but we are paring this file and making `VAR=value` lines available to shell scripts for this project. 


### Cloning an existing project

If you already have a Drupal project to work with, clone it under the `sites` folder at the location you specified with `DRP_SITE_PATH`. 

### Creating a new project

If you're starting a new Drupal project, run `drp_create_project.sh $SITE` to creates a Drupal project under the `sites` folder. 

### Initializing a site

Once you have a Drupal project in place, you can run `drp_init_local.sh $SITE` to create a`settings.local.php` file and local database to initialize a site based on your project. 

## Running the Environment

Once you've created the neccessary containers and configuration files, you can start the environment with `make start` and shut it down with `make stop`. You'll need to do a `start/stop` if you change the value for `DRP_SITE_PATH` or recreate the project at that path. 

### Misc 
The following comands exist and may be useful:

* `drp_cache_rebuild.sh` - Rebuilds the Drupal cache
* `drp_cli.sh` - Runs a bash shell in the drp-cli container
* `drp_composer.sh` - Runs Drupal Composer
* `drp_create_project.sh` - Creates a Drupal project folder
* `drp_db_export.sh` - Exports a Drupal database to S3
* `drp_db_import.sh` - Imports a Drupal database from S3
* `drp_db_ls.sh` - Lists Drupal database dumps available in S3
* `drp_enable_modules.sh` - Enables a default set of modules
* `drp_init_local.sh` - Creates `settings.local.php` and local database to initialize site. 

