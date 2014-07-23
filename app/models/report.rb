class Report
  include MongoMapper::Document

  key :user_id, String, :required => true
  key :total_invokation, Integer, :required => true

  many :report_item
end
