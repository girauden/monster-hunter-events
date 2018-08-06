FactoryBot.define do
  factory :hunt do
    title 'firstraid'
    datetime 3.hour.from_now
    duration 3
    max_hunter 10
    platform 'ps4'
    association :leader, factory: :user
  end
end
