# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    user_id "MyString"
    new_recommendation false
    useful false
    created_on "2014-06-11"
    reason "MyString"
    command_detail FactoryGirl.create(:command_detail)
  end
end
