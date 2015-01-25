#!/bin/bash

set -euxo pipefail

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

yum -y install epel-release
curl -o /etc/yum.repos.d/ntrrgc-prosody-epel-7.repo https://copr.fedoraproject.org/coprs/ntrrgc/prosody/repo/epel-7/ntrrgc-prosody-epel-7.repo

yum -y install gcc lua-devel make prosody tar wget zlib-devel

# install lua-zlib
LUA_ZLIB_VERSION=0.4
pushd /root
wget https://github.com/brimworks/lua-zlib/archive/v$LUA_ZLIB_VERSION.tar.gz
tar -xzvf v$LUA_ZLIB_VERSION.tar.gz
pushd lua-zlib-$LUA_ZLIB_VERSION
export LUACPATH="/usr/lib64/lua/5.1"
export LIBDIR="-L/usr/lib64"
make linux
make install
popd
popd
# remove deps for lua-zlib building
yum -y remove cpp gcc lua-devel make tar wget zlib-devel

mv /etc/prosody/prosody.cfg.lua /etc/prosody/prosody.cfg.lua.rpm_orig
ln -s /var/lib/prosody/conf/prosody.cfg.lua /etc/prosody/prosody.cfg.lua

# clean cache to keep the image small
yum clean all
