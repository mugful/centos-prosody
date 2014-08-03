#!/bin/bash

set -euxo pipefail

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum -y install prosody sudo supervisor

mv /etc/prosody/prosody.cfg.lua /etc/prosody/prosody.cfg.lua.rpm_orig
ln -s /var/lib/prosody/conf/prosody.cfg.lua /etc/prosody/prosody.cfg.lua

# clean cache to keep the image small
yum clean all
