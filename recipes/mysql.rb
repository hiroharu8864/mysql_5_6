#
# Cookbook Name:: mysql
# Recipe:: mysql
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
node[:mysql][:rpm].each do |rpmfile|
  cookbook_file "#{Chef::Config[:file_cache_path]}/#{rpmfile}" do
    mode 0644
  end

  package "#{rpmfile}" do
    action :install
    provider Chef::Provider::Package::Rpm
    source "#{Chef::Config[:file_cache_path]}/#{rpmfile}"
  end
end

directory '/var/run/mysqld' do
  owner 'mysql'
  group 'root'
  mode 0755
  action :create
end

file '/usr/my.cnf' do
  action :delete
  only_if { File.exists?"/usr/my.cnf"}
end

template '/etc/my.cnf' do
  path "/etc/my.cnf"
  source "mysql/my.cnf.erb"
  owner "root"
  group "root"
  notifies :restart, "service[mysql]"
end

service "mysql" do
  supports :restart => true, :reload => true
  action [:enable, :start]
end

script "modify default setting" do
  interpreter "bash"
  user "root"
  not_if "mysql -uroot -p'#{node[:mysql][:server_root_password]}' -e 'show databases;'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret | awk '{print $(NF - 0)}'`
    mysql -uroot -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('#{node[:mysql][:server_root_password]}');"
    mysql -uroot -p'#{node[:mysql][:server_root_password]}' -e "DROP DATABASE test;"
    mysql -uroot -p'#{node[:mysql][:server_root_password]}' -e "FLUSH PRIVILEGES;"
  EOL
end
