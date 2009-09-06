package 'squid'

service 'squid'

template '/etc/squid/squid.conf' do
  source 'squid.conf.erb'
  owner 'root'
  group 'root'
  mode 0600
  notifies :restart, resources(:service => 'squid')
end
