#!/bin/bash                                                                          
#
# Update the puppet code from our repo and apply
# 
# Requires:
#   puppet binary installed
#   rbeapi rubygem installed
#   eAPI configured
#     Defaults to unix-sockets, if EOS 4.14.5F or newer
# Optional:
#   git extension (requires git and 8 perl RPMs)
#
 
# May need this if using pe-puppet
export PATH=/opt/puppet/bin:${PATH}
 
#
# Where will we store the local copy?
#
BASEDIR=/persist/local
PUPPETDIR=${BASEDIR}/puppet-headless

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi
 
puppet apply ${PUPPETDIR}/manifests/default.pp --modulepath ${PUPPETDIR}/modules -t

