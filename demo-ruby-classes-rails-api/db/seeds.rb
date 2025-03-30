# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database"
AnimalLikesFood.destroy_all
Animal.destroy_all
Food.destroy_all

puts "Creating animals with their food preferences"

# Create Cat and food preferences
AnimalService.create(
  name: "Cat",
  noise: "meow",
  foods: ["Cat Food", "Chicken", "Milk"]
)

# Create Dog and food preferences
AnimalService.create(
  name: "Dog",
  noise: "bark",
  foods: ["Dog Food", "Cat Food", "Chicken", "Human Food"]
)

puts "Seeding completed"
