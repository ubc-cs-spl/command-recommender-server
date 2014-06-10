class CommandDetail
  include MongoMapper::Document

  key :command_name, String
  key :command_id, String
  key :description, String
  key :shortcut, String

end
