# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
command = CommandDetail.create(command_name: 'Open', command_id: 'com.eclipse.open', description: 'Stufff about it', shortcut: 'Ctrl+O')
Recommendation.create(user_id: 'abcdef', new_recommendation: true, useful: true, crated_on: Time.now.getutc, reason: 'Stuff about why we recommended this', command_detail: command)
command = CommandDetail.create(command_name: 'Close', command_id: 'com.eclipse.open', description: 'Stufff about it', shortcut: 'Ctrl+O')
Recommendation.create(user_id: 'abcdef', new_recommendation: true, useful: true, crated_on: Time.now.getutc, reason: 'Stuff about why we recommended this', command_detail: command)
command = CommandDetail.create(command_name: 'Open', command_id: 'com.eclipse.open', description: 'Stufff about it', shortcut: 'Ctrl+O')
Recommendation.create(user_id: 'abcdef', new_recommendation: true, useful: true, crated_on: Time.now.getutc, reason: 'Stuff about why we recommended this', command_detail: command)