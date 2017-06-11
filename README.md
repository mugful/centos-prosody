Not maintained
==============

This image is no longer used by the author, and is no longer maintained.


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

        chcon -Rt svirt_sandbox_file_t /var/lib/prosody

* Run Prosody docker container.

        docker run --name myprosody -p 5222:5222 -p 5269:5269 \
            -v /var/lib/prosody:/var/lib/prosody \
            dockingbay/centos-prosody:latest

* Config file in the volume on the host machine has been generated
  (`/var/lib/prosody/conf/prosody.cfg.lua`) on the container's first
  launch. Change the domain name in the config file to yours, specify
  paths to TLS key/cert to use. On production systems you'll probaby
  want to pre-create that file using your favorite configuration
  management tool.

* Reload the config file in case you made changes to it.

        docker exec -i -t myprosody prosodyctl reload

* Create a user.

        docker exec -i -t myprosody prosodyctl adduser

  You will be prompted for details.

* Open firewall ports 5222 and 5269 on the host.

    firewall-cmd --add-port=5222 --zone=public --permanent
    firewall-cmd --add-port=5269 --zone=public --permanent
