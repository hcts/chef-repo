set.hectic.deploy_to = '/var/www/apps/hectic'
set.hectic.revision  = '672b694c36425273d99b86565069fa0d017fa4ff'

set_unless.hectic.repository      = 'git://github.com/matthewtodd/hectic.git'
set_unless.hectic.server_name     = fqdn
set_unless.hectic.server_aliases  = []
set_unless.hectic.environment     = 'production'

set_unless.hectic.db.database     = 'hectic'
set_unless.hectic.db.username     = 'hectic'
set_unless.hectic.db.password     = random_password
set_unless.hectic.db.environment  = hectic.environment
