package 'alpine'

template '/usr/local/bin/virtual_alpine' do
  backup false
  source 'virtual_alpine.erb'
  owner 'root'
  group 'root'
  mode 0755
end
