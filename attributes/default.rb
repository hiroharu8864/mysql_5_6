default[:mysql][:user] = "vagrant"
default[:mysql][:group] = "vagrant"
default[:mysql][:server_root_password] = "YOUR_SERVER_PASSWORD"
default[:mysql][:rpm] = [
  'MySQL-client-5.6.17-1.el6.x86_64.rpm',
  'MySQL-devel-5.6.17-1.el6.x86_64.rpm',
  'MySQL-shared-5.6.17-1.el6.x86_64.rpm',
  'MySQL-shared-compat-5.6.17-1.el6.x86_64.rpm',
  'MySQL-server-5.6.17-1.el6.x86_64.rpm'
]
default[:monit][:db_server] = {
  'mysql' => {
    'process' => 'mysql',
    'pidfile' => '/var/run/mysqld/mysqld.pid'
  }
}

