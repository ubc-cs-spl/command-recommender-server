class ReportItem
  include MongoMapper::EmbeddedDocument

  key :command_id, String
  key :useCount, Integer
  key :hotkeyCount, Integer

  embedded_in :report
end
