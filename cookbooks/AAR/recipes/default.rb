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

include_recipe 'AAR::web'
include_recipe 'AAR::database'
