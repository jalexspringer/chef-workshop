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

directory '/home/middleman'
directory '/home/middleman/'

user 'middleman' do
  home '/home/middleman'
end

template '/etc/sudoers.d/middleman_conf' do
  source 'middleman_conf.erb'
end

# Install required packages
package [ 'build-essential', 'libssl-dev', 'libyaml-dev', 'libreadline-dev', 'openssl', 'curl', 'git-core', 'zlib1g-dev', 'bison', 'libxml2-dev', 'libxslt1-dev', 'libcurl4-openssl-dev', 'nodejs', 'libsqlite3-dev', 'sqlite3' ]

# Download and install ruby from source
#remote_file '/home/middleman/ruby/ruby-2.1.3.tar.gz' do
#  source 'http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz'
#  notifies :run, 'bash[install_ruby]', :immediately
#end

package ['ruby', 'ruby-dev']

#bash 'install_ruby' do
#  user 'middleman'
#  cwd '/home/middleman/ruby'
#  code <<-EOH
#    tar -xzf ruby-2.1.3.tar.gz
#    (cd ruby-2.1.3/ && ./configure && make && make-install)
#  EOH
#  action :nothing
#end
#

bash 'ruby_core_commands' do
  user 'middleman'
  cwd '/'
  code <<-EOH
    cp /usr/local/bin/ruby /usr/bin/ruby
    cp /usr/local/bin/gem /usr/bin/gem
  EOH
  only_if {File.exists?('/usr/local/bin/ruby')}
end

# Apache install and configure
package 'apache2'

bash 'a2enmod_commands' do
  user 'root'
  code <<-EOH
    a2enmod proxy_http
    a2enmod rewrite
  EOH
end

template '/etc/apache2/sites-enabled/blog.conf' do
  source 'blog.conf.erb'
end

file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

service 'apache2' do
  action :restart
end

# Install git and clone repo
package 'git'

git '/home/middleman/middleman-blog' do
  repository node[:middleman][:git_repository]
end
  
directory '/home/middleman/middleman-blog' do
  owner 'middleman'
end

file '/home/middleman/middleman-blog/*' do
  owner 'middleman'
end

# Install Bundler
gem_package 'bundler'

bash 'bundle_install' do
  user 'middleman'
  cwd '/home/middleman/middleman-blog'
  code <<-EOH
    bundle update
    bundle install
  EOH
end
