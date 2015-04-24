#!/bin/bash                                                                          
#
# Update the puppet code from our repo and apply
# 
# Requires:
#   puppet binary installed
#   rbeapi rubygem installed
#   eAPI configured
#     Defaults to unix-sockets, if EOS 4.14.5F or newer
 
export PATH=/opt/puppet/bin:${PATH}
 
BASEDIR=/persist/local/puppet-headless
#REPO=https://github.com/jerearista/puppet-headless.git
#REPO=http://10.0.2.2/puppet-headless
REPO=http://172.16.130.10/puppet-headless
 
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi
 
#cd /mnt/flash/
#wget http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/14/Everything/i386/os/Packages/git-1.7.3.1-1.fc14.i686.rpm
#FastCli -p 15 -c << "copy git-1.7.3.1-1.fc14.i686.rpm  extension:
#extension git-1.7.3.1-1.fc14.i686.rpm
#copy installed-extensions boot-extensions"

if [[ -x /usr/bin/git ]]; then
    if [[ ! -d ${BASEDIR} ]]; then
        git clone ${REPO} ${BASEDIR}
    fi 
    cd ${BASEDIR}
    git reset --hard HEAD
    git pull
else
    
    if [[ ! -d ${BASEDIR} ]]; then
        mkdir -p ${BASEDIR}
    fi 
    wget -q --no-host-directories --recursive --mirror \
         --directory-prefix=${BASEDIR} --cut-dirs=1 ${REPO}
    # --mirror = -r -N -l inf --no-remove-listing
fi

puppet apply ${BASEDIR}/manifests/default.pp --modulepath ${BASEDIR}/modules
