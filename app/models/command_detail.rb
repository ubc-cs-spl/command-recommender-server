class CommandDetail
  include MongoMapper::Document
  key :_id, ObjectId
  key :command_name, String, :required => true
  key :command_id, String, :required => true, :unique => true
  key :description, String, :required => true
  key :shortcut, String
  key :mac_shortcut, String
  key :use_count, Integer
  key :user_count, Integer
end
