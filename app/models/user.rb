class User
  include MongoMapper::Document

  key :user_id, String, :required => true, :unique => true
  key :last_recommendation_date, Date
  key :last_upload_date, Date, :required => true

  def self.create_indexes
    self.ensure_index(:user_id)
  end
end
