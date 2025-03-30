class AnimalLikesFood < ApplicationRecord
  belongs_to :animal, primary_key: :name, foreign_key: :animal_name
  belongs_to :food, primary_key: :name, foreign_key: :food_name

  validates :animal_name, presence: true
  validates :food_name, presence: true
  validates :animal_name, uniqueness: { scope: :food_name }
end 