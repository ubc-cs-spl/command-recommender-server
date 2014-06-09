MongoMapper.connection =  Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "commands-#{Rails.env}"
User.create_indexes

if defined?(PhusionPassenger)
	PhusionPassenger.on_event(:starting_worker_process) do |forked|
		MongoMapper.conneciton.connect if forked
	end
end

