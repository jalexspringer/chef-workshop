# Exercises from the Chef workshop
## Tomcat
### Setup
Workstation: Centos7 vagrant box

Chef Server: Hosted Chef

Node: Cenos7 instance on Google Cloud Compute Engine

### Steps

1. Install ChefDK on vagrant box (workstation)
2. Configure Chef Server, get keys and create knife config on workstation
3. Generate cookbook 'tomcat' on workstation
4. Spin up GCE instance with Centos7 (node)
5. knife bootstrap on workstation with GCE ip and ssh keys, run-list[tomcat]
