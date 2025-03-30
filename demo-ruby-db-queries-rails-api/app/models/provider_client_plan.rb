class ProviderClientPlan < ApplicationRecord
  belongs_to :provider
  belongs_to :client
  belongs_to :plan, foreign_key: :plan_name, primary_key: :name

  validates :provider, presence: true
  validates :client, presence: true
  validates :plan_name, presence: true
  validates :provider_id, uniqueness: { scope: :client_id, message: 'and client combination already has a plan assigned' }
end 