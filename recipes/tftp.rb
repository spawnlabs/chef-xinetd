package "tftp" do
  action :install
end

package "tftpd" do
  action :install
end

template "/etc/xinetd.d/tftp" do
  mode 00644
  source "tftp.erb"
  notifies :restart, "service[xinetd]"
end

directory "/var/lib/tftpboot" do
  owner "root"
  group "root"
  mode 00777
  action :create
end

execute "chmod -R 777 /var/lib/tftpboot"
