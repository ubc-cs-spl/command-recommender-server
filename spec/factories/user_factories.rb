FactoryGirl.define do
  factory :user do |f|
    f.user_id "abcdef"
    f.last_recommendation_date Time.now.getutc
    f.last_upload_date Time.now.getutc
  end
end