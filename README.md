# Exercises from the Chef workshop
## Tomcat
### Setup
Workstation: Centos7 vagrant box

Chef Server: Hosted Chef

Node: Cenos7 instance on Google Cloud Compute Engine

### Steps

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

Notes/Future Improvements:
- Getting the tomcat file (remote_file) does not account for changes in version, location, etc. Use attributes to define these variables and make it easier to maintain this.
