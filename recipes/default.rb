#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
service "iptables" do
  action [ :disable, :stop ]
end

%w{gcc gcc-c++}.each do |pkg|
  package pkg do
    action :install
  end
end

# add exclude param to yum.conf
file '/etc/yum.conf' do
  _file = Chef::Util::FileEdit.new(path)
  _file.insert_line_if_no_match("exclude=", "exclude=kernel* centos* mysql*\n")
  _file.write_file
  action :create
end

execute "yum-update" do
  user "root"
  command "/usr/bin/yum -y update"
  action :run
end
