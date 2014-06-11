# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :command_detail do
    command_name "MyString"
    command_id "MyString"
    description "MyString"
    shortcut "MyString"
  end
end
