package 'fetchmail'

service 'fetchmail' do
  action :disable
end

directory '/var/run/fetchmail' do
  owner 'fetchmail'
  group 'nogroup'
  mode 0700
end

template '/etc/default/fetchmail' do
  source 'fetchmail.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources(:service => 'fetchmail')
end

template '/etc/fetchmailrc' do
  source 'fetchmailrc.erb'
  variables :accounts => Hectic.accounts(node)
  owner 'fetchmail'
  group 'nogroup'
  mode 0600
  notifies :restart, resources(:service => 'fetchmail')
end

template '/etc/cron.d/fetchmail' do
  backup false
  source 'crontab.erb'
  owner 'root'
  group 'root'
  mode 0644
end
