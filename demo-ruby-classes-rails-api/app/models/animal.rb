class Animal < ApplicationRecord
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: true
  validates :noise, presence: true

  has_many :animal_likes_foods, foreign_key: :animal_name
  has_many :liked_foods, through: :animal_likes_foods, source: :food
end 