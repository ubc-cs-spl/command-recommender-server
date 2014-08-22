require 'mongo'

class Report
  include Mongo

  def self.retrieve_report(user_id, num_days)
    commands_coll = MongoClient.new["commands-#{Rails.env}"]['commands']
    results = commands_coll.aggregate(
        [{'$match' => {kind: 'command', user_id: user_id}},
         {'$project' => {description: 1, bindingUsed: 1,
                         current: {'$gt'=> ['$time', get_time_n_days_before(num_days.to_i)]}}},
         {'$group' => {_id: '$description',
                       use_count: {'$sum' => {'$cond' => ['$current', 1, 0]}},
                       hotkey_count: {'$sum' => {'$cond' => [{'$and'=> ['$bindingUsed', '$current']}, 1, 0]}},
                       new: {'$min' => '$current'}}},
         {'$match' => {use_count: {'$gt' => 0}}},
         {'$sort' => {use_count: -1}}])
    total_invocation = 0
    results.each do |cmd|
      total_invocation += cmd['use_count']
      if (detail = CommandDetail.find_by_command_id(cmd['_id']))
        cmd['name'] = detail['command_name']
        cmd['shortcut'] = detail['shortcut']
        cmd['mac_shortcut'] = detail['mac_shortcut']
        cmd['_id'] = detail['_id']
      end
    end
    {stats: results, total_invocation: total_invocation}
  end

  def self.get_time_n_days_before(num_days)
    (Time.now.to_i - 60 * 60 * 24 * num_days) * 1000
  end

  private_class_method :get_time_n_days_before

end