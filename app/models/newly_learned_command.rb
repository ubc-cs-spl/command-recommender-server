class NewlyLearnedCommand
  include MongoMapper::EmbeddedDocument
  key :command_detail_id, ObjectId

  belongs_to :command_detail
  embedded_in :report
end