
# DRP Environment


## Requirements

To run sucessfully, you'll need: 

* a nice Unix environment (linux, MacOS, WSL2) 
* working AWS credentials with access to `ul-drp-data`
* working install of docker and docker-compose

It's recommended that you use `aws-vault` to manage your aws credentials.

## Building the containers 

To download Red Hat UBI base images, you'll need to authenticate with the Red Hat package registry using a Red Hat Registry Service Account, which can be created from your Red Hat Developer Account. See Red Hat's [Registry Authentication](https://access.redhat.com/RegistryAuthentication) page.  

Once you've created a service account run `docker login`:
```
docker login -u USERNAME https://registry.redhat.io
```

And then run `make all` to build the container set.  

## Using the containers

## Configuration

Create the require `.env` file pased on the provided `env_template` file. 

Important values to set include:

```
DRP_SITE_PATH=./sites/demo-site
```

NOTE: this file is also parsed by several shell scripts, so its contents should be limited to KEY="value" statements.

### Creating a site

Use the following commands to create a site. 

* `drp_create_site.sh $SITE` - Creates a Drupal project folder for a site
* `drp_init_local.sh $SITE`  - Initializes an empty drupal site based on a Drupal project folder

You can use `drp_composer.sh` to install additional componetns to your project if required. 

## Running the Environment

Once you've created the neccessary containers and configuration files, you can start the environment with `make start` and shut it down with `make stop`.


### Misc 
The following comands exist and may be useful:

* `drp_cache_rebuild.sh` - Rebuilds the Drupal cache
* `drp_cli.sh` - Runs a bash shell in the drp-cli container
* `drp_composer.sh` - Runs Drupal Composer
* `drp_db_export.sh` - Exports a Drupal database to S3
* `drp_db_import.sh` - Imports a Drupal database from S3
* `drp_db_ls.sh` - Lists Drupal database dumps available in S3
