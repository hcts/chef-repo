package 'vnc4server'
package 'xrdp'

service 'xrdp' do
  action :enable
end

template '/etc/init.d/xrdp' do
  source 'xrdp.erb'
  owner 'root'
  group 'root'
  mode 0755
  notifies :restart, resources(:service => 'xrdp')
end

template '/etc/xrdp/sesman.ini' do
  source 'sesman.ini.erb'
  owner 'xrdp'
  group 'xrdp'
  mode 0644
  notifies :restart, resources(:service => 'xrdp')
end

template '/etc/xrdp/xrdp.ini' do
  source 'xrdp.ini.erb'
  owner 'xrdp'
  group 'xrdp'
  mode 0644
  notifies :restart, resources(:service => 'xrdp')
end

template '/etc/PolicyKit/PolicyKit.conf' do
  source 'PolicyKit.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end
