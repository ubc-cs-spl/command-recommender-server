require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Recommendation.collection.remove
(1..9).each{ |i|
  if i > 10
    useful = Random.rand % 2 == 0 ? true : false
  else
    useful = nil
  end
  name = Faker::Company.name
  if i < 10
    time = Time.now.getutc
  else
    time = Time.now - 5 * 24
  end

  ctrl = "Ctrl"
  shift = "Shift"
  key="+#{Faker::Lorem.characters(1)}"
  if Random.rand % 2
    shortcut = ctrl + key
    if Random.rand % 2
      shortcut = "#{shift} + #{shortcut}"
    end
  end

  command = CommandDetail.create(command_name: name,
                                 command_id: "com.eclipse.#{name}",
                                 description: Faker::Lorem.paragraph(i % 10 + 5),
                                 shortcut: shortcut)
  Recommendation.create(user_id: 'abcdef',
                        new_recommendation: true,
                        useful: useful,
                        created_on: time,
                        reason: Faker::Lorem.sentence(2),
                        command_detail: command)
}