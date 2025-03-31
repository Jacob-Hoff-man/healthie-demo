FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    sequence(:email) { |n| "client#{n}@example.com" }

    trait :invalid_email do
      email { "invalid_email" }
    end
  end
end 