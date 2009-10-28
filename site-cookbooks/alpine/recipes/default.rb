package 'alpine'

template '/usr/local/bin/virtual_alpine' do
  source 'virtual_alpine.erb'
  owner 'root'
  group 'root'
  mode 0755
end
