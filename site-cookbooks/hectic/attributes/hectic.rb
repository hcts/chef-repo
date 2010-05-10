set.hectic.deploy_to = '/var/www/apps/hectic'
set.hectic.revision  = 'df686ac5403565e580e6d1b377b1b6d6245dcc8f'

set_unless.hectic.repository      = 'git://github.com/hcts/hectic.git'
set_unless.hectic.server_name     = fqdn
set_unless.hectic.server_aliases  = []
set_unless.hectic.environment     = 'production'

set_unless.hectic.db.database     = 'hectic'
set_unless.hectic.db.username     = 'hectic'
set_unless.hectic.db.password     = random_password
set_unless.hectic.db.environment  = hectic.environment
