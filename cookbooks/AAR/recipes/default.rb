#
# Cookbook:: AAR
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update 'periodic' do
  frequency 86400
  action :periodic
end

package [ 'apache2', 'mysql-server', 'unzip', 'libapache2-mod-wsgi', 'python-pip', 'python-mysqldb', 'git' ]

execute 'install-flask' do
  command <<-EOF
    pip install flask
  EOF
end

git 'tmp/Awesome-Appliance-Repair' do
  action :export
  repository 'https://github.com/colincam/Awesome-Appliance-Repair.git'
end

bash 'mv AAR' do
  cwd '/tmp/Awesome-Appliance-Repair'
  code <<-EOH
    mv AAR /var/www/
    EOH
  not_if { ::File.exist?('/var/www') }
end

template '/etc/apache2/sites-enabled/AAR-apache.conf' do
  source 'AAR-apache.conf.erb'
end

service 'apache2' do
  action :restart
end
