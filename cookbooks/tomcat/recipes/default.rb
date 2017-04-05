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

