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

