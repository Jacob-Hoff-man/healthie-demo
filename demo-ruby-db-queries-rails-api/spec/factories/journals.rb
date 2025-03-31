FactoryBot.define do
  factory :journal do
    association :client
    sequence(:text) { |n| "Journal entry #{n} content" }
  end
end 