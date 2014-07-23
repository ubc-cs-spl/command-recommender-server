class CommandStat
  include MongoMapper::EmbeddedDocument

  key :command_id, String
  key :use_count, Integer
  key :hotkey_count, Integer
  key :command_detail, CommandDetail

  embedded_in :report
end
