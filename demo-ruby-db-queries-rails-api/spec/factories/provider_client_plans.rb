FactoryBot.define do
  factory :provider_client_plan do
    association :provider
    association :client
    transient do
      plan { association :plan }
    end
    plan_name { plan.name }

    after(:build) do |provider_client_plan, evaluator|
      provider_client_plan.plan = evaluator.plan
    end
  end
end 