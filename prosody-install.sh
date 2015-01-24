#!/bin/bash

set -euxo pipefail

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

yum -y install epel-release
curl -o /etc/yum.repos.d/ntrrgc-prosody-epel-7.repo https://copr.fedoraproject.org/coprs/ntrrgc/prosody/repo/epel-7/ntrrgc-prosody-epel-7.repo

yum -y install prosody sudo

mv /etc/prosody/prosody.cfg.lua /etc/prosody/prosody.cfg.lua.rpm_orig
ln -s /var/lib/prosody/conf/prosody.cfg.lua /etc/prosody/prosody.cfg.lua

# clean cache to keep the image small
yum clean all
