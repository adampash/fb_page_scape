require 'active_record'
require 'sqlite3'
require 'pg'
require 'logger'

ActiveRecord::Base.logger = Logger.new('dev-debug.log')
configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])


