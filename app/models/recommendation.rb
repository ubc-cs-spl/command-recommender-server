class Recommendation
  include MongoMapper::Document

  key :user_id, String
  key :new_recommendation, Boolean
  key :useful, Boolean
  key :created_on, Date
  key :reason, String

  key :command_detail_id, ObjectId
  belongs_to :command_detail

  def self.create_indexes
    self.ensure_index([[:user_id, 1], [:command_detail_id, 1]])
  end
end
