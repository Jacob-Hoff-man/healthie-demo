class Food < ApplicationRecord
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: true

  has_many :animal_likes_foods, foreign_key: :food_name
  has_many :liked_by_animals, through: :animal_likes_foods, source: :animal
end 