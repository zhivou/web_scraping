require_relative 'ebay'

def start_db
  ActiveRecord::Base.connection.close rescue ActiveRecord::ConnectionNotEstablished
  db_config = YAML::load(File.open("database.yml"))['default']
  ActiveRecord::Base.establish_connection(db_config)
end

s = Ebay.new("Sony a7 ii")
s.newly_listed = true
s.us_only = true
result = s.start
p ''