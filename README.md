
# DRP Environment

## Project Configuration
Project-level configuration should be placed in a top level `.env` folder. 

Right now, this is limited to specifying a drupal site to run. For example:

``
DRP_SITE_PATH=./sites/demo-site
``

## Container Configuration

The following files are used for container configration:
* `etc/drupal.env`
* `etc/mysql.env`

The only required value is setting the `MYSQL_ROOT_PASSWORD` variable in the mysql environment file. 

Contaienr UID/GID config is still a work in progress and you may need to 777 the folder `mysql/data`. 

## Building the containers 


To download Red Hat UBI base images, you'll need to authenticate with the Red Hat package registry using a Red Hat Developer Account or a Registry Service Account, which can be created from a developer account.

docker login -u USERNAME https://registry.redhat.io

To build the container, run `make all` from the containers folder. 


## Running the Environment

Once you've created the neccessary containers and configuration files, you can run the environment with with `docker-compose up`.


## Running the commandds

These still have a ton of rough edges and don't properly account for UID/GID differences between container and host. You may wish to 777 the project folder. 


### Creating a site

* `drp_create_site.sh $site-slug` - Creates a Drupal project folder for a site
* `drp_init_local.sh $site-slug`  - Initializes an empty drupal site based on a Drupal project folder

### Misc 

* `drp_cache_rebuild.sh $site-slug` - Rebuilds the Drupal cache
* `drp_composer.sh $site-slug` - Runs composer commands 
* `drp_sql_export.sh $site-slug` - Exports a database
