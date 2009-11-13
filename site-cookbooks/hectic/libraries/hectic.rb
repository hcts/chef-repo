class Hectic
  # These class-level convenience methods are the ones I intend to call in my recipes.
  def self.accounts(node)
    new(node).accounts
  end

  def self.base_mailbox_paths(node)
    accounts(node).map { |account| account['mailbox_path'] }.map do |mailbox_path|
      if mailbox_path.end_with?('/')
        mailbox_path
      else
        ::File.dirname(mailbox_path)
      end
    end.uniq
  end

  def self.local_hostnames(node)
    new(node).hosts.map { |host| host['local_name'] }
  end

  def self.smallest_account_limit(node)
    accounts(node).map { |account| account['limit'].to_i }.reject { |limit| limit.zero? }.min
  end

  # And here's the "lower level" interface.
  def initialize(node)
    @database_config = node[:hectic][:db]
  end

  def accounts
    query('SELECT * FROM hosts JOIN accounts ON hosts.id=accounts.host_id WHERE accounts.enabled=1 ORDER BY hosts.name, accounts.username')
  end

  def hosts
    query('SELECT * FROM hosts ORDER BY name')
  end

  private

  def query(sql)
    be_sure_we_have_mysql

    results = []
    begin
      mysql = Mysql.new('localhost', @database_config[:username], @database_config[:password], @database_config[:database])
      mysql.query(sql) { |rows| rows.each_hash { |row| results.push(row) } }
    rescue Mysql::Error => error
      # FIXME the only reason I'm catching errors here is because the Postfix
      # (and other?) recipes try to read the Hectic database without a
      # guarantee that the database exists or that the hectic user has
      # permission to access it. For now, the best we can do is return
      # nothing. But maybe it would be better to restructure those other
      # recipes so that they play nicer.
      Chef::Log.warn(error.message)
    ensure
      mysql.close if mysql
    end

    results
  end

  def be_sure_we_have_mysql
    begin
      require 'mysql'
    rescue LoadError
      Gem.clear_paths
      require 'mysql' # if that didn't help, we're sunk
    end
  end
end
