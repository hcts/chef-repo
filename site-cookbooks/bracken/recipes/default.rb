gem_package 'bracken' do
  source 'http://gemcutter.org'
  version '0.1.1'
end

template '/etc/bracken.rb' do
  source 'bracken.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
end
