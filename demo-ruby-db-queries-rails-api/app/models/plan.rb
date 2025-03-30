class Plan < ApplicationRecord
  self.primary_key = 'name'
  
  has_many :provider_client_plans, foreign_key: :plan_name, primary_key: :name, dependent: :destroy
  has_many :providers, through: :provider_client_plans
  has_many :clients, through: :provider_client_plans

  validates :name, presence: true, uniqueness: true
end 