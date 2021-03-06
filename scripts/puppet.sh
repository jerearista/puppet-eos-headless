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

# What and where am I?
SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
SCRIPT=$SCRIPTPATH/$(basename $0)
 
#
# Where will we store the local copy?
#
BASEDIR=/persist/local
PUPPETDIR=${BASEDIR}/puppet-headless

[ -x ${PUPPETDIR}/scripts/puppet_update.sh ] && ${PUPPETDIR}/scripts/puppet_update.sh || exit 1

[ -x ${PUPPETDIR}/scripts/puppet_apply ] && ${PUPPETDIR}/scripts/puppet_apply

#
# To self-add this to the scheduler, uncomment the following
#
#FastCli -p 15 -c "configure t
#schedule puppet interval 30 max-log-files 1 command bash ${SCRIPT}
#end"
