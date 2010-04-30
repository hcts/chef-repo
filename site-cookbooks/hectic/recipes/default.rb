require 'chef-deploy'
require 'pathname'

# It's kind of nice, I suppose, to keep app access in sync with the server
# adminstrators' unix accounts. So, let's try this:
package 'libapache2-mod-auth-pam'
apache_module 'auth_pam'

# www-data has to be in the shadow group to do PAM authentication
group 'shadow' do
  action :modify
  members 'www-data'
  append true
  notifies :restart, resources(:service => 'apache2')
end

# Hectic shells out to rrdtool to keep time-series logs of network activity.
package 'rrdtool'

mysql_database node[:hectic][:db][:database] do
  username node[:hectic][:db][:username]
  password node[:hectic][:db][:password]
end

# FIXME Chef::Resource::Template will only accept a Hash, not a Chef::Node::Attribute
database_configuration_hash = Hash.new
node[:hectic][:db].each_attribute { |k,v| database_configuration_hash[k]=v }

capistrano_deployment_structure node[:hectic][:deploy_to] do
  owner node[:apache][:user]
  group node[:apache][:user]
  database_configuration database_configuration_hash
end

# Gem dependencies are now bundled inside the Hectic app.
# But we'll still need bundler to unpack them.
gem_package 'bundler' do
  source 'http://gemcutter.org'
end

deploy node[:hectic][:deploy_to] do
  repo node[:hectic][:repository]
  revision node[:hectic][:revision]
  migrate true
  migration_command 'rake db:migrate'
  environment node[:hectic][:environment]
  restart_command 'touch tmp/restart.txt'
  user node[:apache][:user]
  group node[:apache][:user]

  current_revision = Pathname.new(node[:hectic][:deploy_to]).join('current', 'REVISION')
  if current_revision.exist? && current_revision.read.strip == node[:hectic][:revision]
    action :nothing
  else
    action :deploy
  end
end

web_app 'hectic' do
  docroot "#{node[:hectic][:deploy_to]}/current/public"
  server_name node[:hectic][:server_name]
  server_aliases node[:hectic][:server_aliases]
  rails_env node[:hectic][:environment]
  template 'hectic_web_app.conf.erb'
end

apache_site '000-default' do
  enable false
end

template '/etc/logrotate.d/hectic' do
  source 'logrotate-hectic.erb'
  variables :base => node[:hectic][:deploy_to]
  owner 'root'
  group 'root'
  mode 0644
end
