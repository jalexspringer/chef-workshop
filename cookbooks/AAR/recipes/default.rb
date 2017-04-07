#
# Cookbook:: AAR
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Regular apt-get update
apt_update 'periodic' do
  frequency 86400
  action :periodic
end

# Install required packages
package [ 'apache2', 'mysql-server', 'unzip', 'libapache2-mod-wsgi', 'python-pip', 'python-mysqldb', 'git' ]

# Get flask python module
# TODO Add a guard here. Maybe?
execute 'install-flask' do
  command <<-EOF
    pip install flask
  EOF
end

# Get the latest from the AAR master branch
git 'tmp/Awesome-Appliance-Repair' do
  action :export
  repository 'https://github.com/colincam/Awesome-Appliance-Repair.git'
end

# Mv the application it to the right spot
bash 'mv AAR' do
  cwd '/tmp/Awesome-Appliance-Repair'
  code <<-EOH
    mv AAR /var/www/
    EOH
  not_if { ::File.exist?('/var/www/AAR') }
end

# Place apache config and python script
template '/etc/apache2/sites-enabled/AAR-apache.conf' do
  source 'AAR-apache.conf.erb'
end

template '/tmp/create_config.py' do
  source 'create_config.py.erb'
end

template '/tmp/make_AARdb.sql' do
  source 'make_AARdb.sql.erb'
end

# Generate AAR_config.py
execute 'execute_py_file' do
  cwd '/tmp'
  command 'python create_config.py'
  not_if { ::File.exist?('/var/www/AAR/AAR_config.py') }
end

# Restart the web server
service 'apache2' do
  action :restart
end


