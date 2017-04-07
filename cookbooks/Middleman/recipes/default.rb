#
# Cookbook:: Middleman
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

apt_update 'periodic' do
  frequency 86400
  action :periodic
end

# Install required packages
package [ 'build-essential', 'libssl-dev', 'libyaml-dev', 'libreadline-dev', 'openssl', 'curl', 'git-core', 'zlib1g-dev', 'bison', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'nodejs', 'libsqlite3-dev', 'sqlite3' ]

# Download and install ruby from source
remote_file '#{Chef::Config[:file_cache_path]}/ruby-#{node[:ruby][:version]}.tar.gz' do
  source 'http://cache.ruby-lang.org/pub/ruby/#{node[:ruby][:main_version]}/ruby-#{node[:ruby][:version]}.tar.gz'
  notifies :run, 'bash[install_program]', :immediately
end

bash 'extract_ruby' do
  user 'root'
  cwd '#{Chef::Config[:file_cache_path]}'
  code <<-EOH
    tar -xzf ruby-#{node[:ruby][:version]}.tar.gz
    (cd ruby-#{node[:ruby][:version]}/ && ./configure && make && make-install)
  EOH
  action :nothing
end

