#!/bin/bash

# Enables Third-Party Drupal 8 Modules via Drush
# SITE_ROOT defined in drupal/resources/drupal.env

# Simple function to provide some of the standard drush command boilerplate.
function d () {
    drush -y --root=$SITE_ROOT "$@"
}

d en admin_toolbar
d en bootstrap
d en config_filter
d en config_split
d en datetime_range
d en devel
d en entity_browser
d en layout_builder
d en layout_discovery
d en media
d en media_library
d en responsive_image
d en s3fs
d en s3fs_cors
d en stage_file_proxy
d en telephone
d en twig_tweak