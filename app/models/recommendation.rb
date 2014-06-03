class Recommendation
  include MongoMapper::Document

  key :user_id, String
  key :command_id, String
  key :kind, String
  key :new_recommendation: Boolean
end
