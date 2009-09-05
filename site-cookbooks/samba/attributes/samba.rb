raise('samba["password"] is required!') unless samba.password

set.samba.path  = '/var/lib/samba/share'
set.samba.user  = 'samba'
set.samba.group = 'samba'

set_unless.samba.workgroup  = domain.split('.').first.upcase
set_unless.samba.name       = hostname.upcase
set_unless.samba.interfaces = ['eth0']
