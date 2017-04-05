#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Install OpenJDK
yum_package 'java-1.7.0-openjdk-devel'

# Create user and group
group 'chef'
user 'chef' do
  gid 'chef'
end

# Download and extract Tomcat binary
remote_file '/tmp/apache-tomcat-8.0.9.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.9/bin/apache-tomcat-8.0.9.tar.gz'
end

bash 'extract_module' do
  cwd '/tmp'
  code <<-EOH
    mkdir -p /opt/tomcat
    tar xvf apache-tomcat-8.0.9.tar.gz -C /opt/tomcat --strip-components=1
    EOH
  not_if { ::File.exist?('/opt/tomcat') }
end

# Permissions
# directory '/opt/tomcat' do
#  group 'tomcat'
#  recursive true
 
# Systemd Unit File
file '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service'
end


# Reload, enable, and start service
execute 'daemon-reload' do
  command "systemctl daemon-reload"
  action :nothing
end

service 'tomcat' do
  action [:enable, :start] 
