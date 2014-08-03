centos-prosody
==============

Prosody XMPP server docker image based on CentOS.

Pull
----

    docker pull dockingbay/centos-prosody:latest .

Usually you'll want to pull some specific tag instead of `latest`. See
[available centos-prosody tags](https://registry.hub.docker.com/u/dockingbay/centos-prosody/tags/manage/).

Run
---

* Prepare a place for Prosody volume on the host machine.

    mkdir -p /var/lib/prosody

* Label the directories to make SELinux happy.

    chcon -R system_u:object_r:svirt_sandbox_file_t:s0 /var/lib/prosody

* Run Prosody docker container.

    docker run -p :5222 -p :5269 -p 127.0.0.1::5582 \
        -v /var/lib/prosody:/var/lib/prosody
        dockingbay/centos-prosody:latest

* Config file in the volume on the host machine was generated
  (`/var/lib/prosody/conf/prosody.cfg.lua`). Change the domain name in
  the config file to yours, specify paths to TLS key/cert to use.

* Restart the container so that config changes take effect.

    docker restart <container-id>

* Create a user.

    docker run --rm -i -t -v /var/lib/prosody:/var/lib/prosody \
        dockingbay/centos-prosody:latest \
        prosodyctl adduser username@example.com

  or if are ok with specifying password on the command line:

    docker run --rm -i -t -v /var/lib/prosody:/var/lib/prosody \
        dockingbay/centos-prosody:latest \
        prosodyctl register username example.com password

* Open firewall ports 5222 and 5269 on the host.

    firewall-cmd --add-port=5222 --zone=public --permanent
    firewall-cmd --add-port=5269 --zone=public --permanent
