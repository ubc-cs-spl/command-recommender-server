class Recommendation
  include MongoMapper::Document

  key :user_id, String, :required => true
  key :new_recommendation, Boolean
  key :useful, Boolean
  key :created_on, Date, :required => true
  key :reason, String, :required => true
  key :reason_value, String, :required => true
  key :algorithm_type, String
  key :algorithm_value, Float
  key :command_id, String, :required => true

  key :command_detail_id, ObjectId, :require => true
  belongs_to :command_detail

  def self.create_indexes
    self.ensure_index([[:user_id, 1], [:command_detail_id, 1]])
  end
end
