include_recipe "xinetd"

package "tftp" do
  action :install
end

package "tftpd" do
  action :install
  notifies :restart, "service[xinetd]"
end

if node[:xinetd][:tftpd][:overwrite_service_config] then
    template "/etc/xinetd.d/tftp" do
      mode 00644
      source "tftp.erb"
      notifies :restart, "service[xinetd]"
    end
end

directory "/var/lib/tftpboot" do
  owner "root"
  group "root"
  mode 00777
  action :create
  notifies :restart, "service[xinetd]"
end

execute "chmod -R 777 /var/lib/tftpboot"
