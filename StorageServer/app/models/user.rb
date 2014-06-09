class User
  include MongoMapper::Document

  key :user_id, String
  key :last_recommendation_date, Date
  key :last_upload_date, Date

  def self.create_indexes
    self.ensure_index(:user_id)
  end
end
