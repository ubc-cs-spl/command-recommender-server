class Report
  include MongoMapper::Document
  attr_accessor :report_items
  key :user_id, String, :required => true
  key :total_invokation, Integer, :required => true

  many :command_stats
end
