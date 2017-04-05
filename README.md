# Exercises from the Chef workshop
## Tomcat
### setup
Workstation: Centos7 vagrant box

Chef Server: Hosted Chef

Node: Centos7 instance on Google Cloud Compute Engine

### steps

1. Install ChefDK on vagrant box (workstation)
2. Configure Chef Server, get keys and create knife config on workstation
3. Generate cookbook 'tomcat' on workstation - add first step of config (OpenJDK install)
4. Spin up GCE instance with Centos7 (node)
5. knife bootstrap on workstation with GCE ip and ssh keys, run-list[tomcat]
6. Confirm new node in knife node list. Confirm JDK installation on node.
7. Write up that default recipe, testing in Test Kitchen along the way

### default recipe
1. OpenJDK - package
2. User and groups
	- The instructions do not list creating the tomcat user or group, so I added that step in.
3. Download tomcat - remote_file (See notes)
4. Extract files - bash
5. Change permissions
	- Spent a considerable amount of time with the file resource. Eventually just used bash.
6. Add systemd unit file
7. Reload, start, and enable systemd services

### testing
TODO: 'curl localhost:8080' to confirm setup

TODO: confirm external access?

### notes
- Getting the tomcat file (remote_file) does not currently account for changes in version, location, etc. TODO Use attributes to define these variables and make it easier to maintain this.

## AAR - AwesomeApplianceRepair

### setup
Workstation: Centos7 vagrant box

Chef Server: Hosted Chef

Node: Ubuntu 12.04 instance on Google Cloud Compute Engine

### steps

1. Using the same workstation and Chef Server organization as above.
3. Generate cookbook 'AAR' on workstation - add first step of config (apache2, mysql, unzip install)
4. Spin up GCE instance with Ubuntu 12.04 (node)
5. knife bootstrap on workstation with GCE ip and ssh keys, run-list[AAR]
6. Confirm new node in knife node list.
7. Write up that default recipe, testing in Test Kitchen along the way.

### default recipe
1. Install packages - apache2, mysql, unzip
2. Install packages - libapache2-mod-wsgi python-pip python-mysqldb
3. Pip install - flask
4. Stop apachectl service
5. Create /etc/apache2/sites-enabled from template
6. Generate /var/www/AAR/AAR_config.py
7. Create DB, user, permissions

### testing

### notes
