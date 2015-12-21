#!/bin/bash -e

# Run some basic tests for the Puppet modules and manifest.

# Find and parse-check all the .pp files
find modules -iname '*.pp' |\
    xargs puppet parser validate --color false --render-as s --modulepath=modules

find upstream_modules -iname '*.pp' |\
    xargs puppet parser validate --color false --render-as s --modulepath=upstream_modules

# Run the catalog test on the manifest
puppet-catalog-test -v \
    -m modules:upstream_modules \
    -M manifests/default.pp \
    --fact osfamily=Debian \
    --fact ipaddress=10.2.3.4 \
    --fact architecture=amd64 \
    --fact operatingsystem=Ubuntu \
    --fact operatingsystemrelease=14.04 \
    --fact lsbdistid=Ubuntu \
    --fact lsbdistcodename=trusty \
    --fact concat_basedir=/tmp/puppetconcat
