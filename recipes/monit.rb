#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
%w{monit}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/monit.conf" do
  path "/etc/monit.conf"
  source "monit/monit.conf.erb"
  owner "root"
  group "root"
  mode 0700
end

node.monit.db_server.each do |k,v|
  template "process_monit.conf" do
    path "/etc/monit.d/#{v[:process]}_monit.conf"
    source "monit/process_monit.conf.erb"
    owner "root"
    group "root"
    notifies :restart, "service[monit]"
    mode 0644
    variables({
      :process => "#{v[:process]}",
      :pidfile => "#{v[:pidfile]}"
    })
  end
end

service "monit" do
  supports :restart => true, :reload => true
  action [ :start, :enable]
end
