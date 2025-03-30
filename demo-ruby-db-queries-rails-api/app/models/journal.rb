class Journal < ApplicationRecord
  belongs_to :client

  validates :text, presence: true
  validates :client, presence: true
end 