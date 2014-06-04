class Command
  include MongoMapper::Document

  key :user_id, String
  key :what, String
  key :kind, String
  key :bundleVersion, String
  key :description, String
  key :bindingUsed, Boolean
  key :time, Integer
end
