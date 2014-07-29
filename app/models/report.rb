class Report
  include MongoMapper::Document
  attr_accessor :report_items
  key :user_id, String, :required => true
  key :total_invocation, Integer, :required => true

  many :newly_learned_commands
  many :command_stats

end
