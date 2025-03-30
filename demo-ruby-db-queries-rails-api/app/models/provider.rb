class Provider < ApplicationRecord
  has_many :provider_client_plans, dependent: :destroy
  has_many :clients, through: :provider_client_plans
  has_many :plans, through: :provider_client_plans

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end 