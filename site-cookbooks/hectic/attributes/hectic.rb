raise('hectic["server_password"] is required!') unless hectic.server_password
raise('hectic["db"]["password"] is required!')  unless hectic.db.password

set.hectic.deploy_to            = '/var/www/apps/hectic'
set.hectic.revision             = 'e5c0363f79800e6a0f41c1ec0ce1bfa981a3a614'
set.hectic.server_password_file = "#{hectic.deploy_to}/shared/passwd"

set_unless.hectic.repository      = 'git://github.com/matthewtodd/hectic.git'
set_unless.hectic.server_name     = fqdn
set_unless.hectic.server_aliases  = []
set_unless.hectic.server_username = 'admin'
set_unless.hectic.environment     = 'production'

set_unless.hectic.db.database     = 'hectic'
set_unless.hectic.db.username     = 'hectic'
set_unless.hectic.db.environment  = hectic.environment
