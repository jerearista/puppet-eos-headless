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

#
# Define the source repo by method
#
#GITREPO=https://github.com/jerearista/puppet-headless.git
RSYNCREPO='vagrant@172.16.130.10:/var/www/html/puppet-headless'
#WGETREPO=http://172.16.130.10/puppet-headless
 
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi
 
if [ -x /usr/bin/git -a -n "${GITREPO}" ]; then
    if [ ! -d ${PUPPETDIR} ]; then
        git clone ${REPO} ${PUPPETDIR}
    fi 
    cd ${PUPPETDIR}
    git reset --hard HEAD
    git pull

elif [ -x /usr/bin/rsync -a -n "${RSYNCREPO}" ]; then
    # Must perform the following before this will work:
    #   ssh-keygen -f ~/.ssh/id_rsa -q -P ""
    #   ssh-copy-id vagrant@172.16.130.10
    rsync -az --delete --delete-excluded --exclude '.git' --exclude '*.swp' \
         -e "ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
         ${RSYNCREPO} ${BASEDIR}

elif [ -x /usr/bin/wget -a -n "${WGETREPO}" ]; then
    
    if [ ! -d ${PUPPETDIR} ]; then
        mkdir -p ${PUPPETDIR}
    fi 
    wget -q --no-host-directories --recursive --mirror \
         --directory-prefix=${PUPPETDIR} --cut-dirs=1 ${REPO}
    # --mirror = -r -N -l inf --no-remove-listing

else
    echo "Error: I don't know how to get my puppet modules!"
    exit 1
fi
