class AnimalLikesFoodService
  def self.create(animal_name:, food_name:)
    relationship = AnimalLikesFood.new(
      animal_name: animal_name,
      food_name: food_name
    )
    
    if relationship.save
      { success: true, data: relationship, status: :created }
    else
      { success: false, errors: relationship.errors, status: :unprocessable_entity }
    end
  end

  def self.list_foods_for_animal(animal_name)
    animal = Animal.find_by(name: animal_name)
    return { success: false, errors: "Animal not found", status: :not_found } unless animal

    { success: true, data: animal.liked_foods, status: :ok }
  end

  def self.list_animals_for_food(food_name)
    food = Food.find_by(name: food_name)
    return { success: false, errors: "Food not found", status: :not_found } unless food

    { success: true, data: food.liked_by_animals, status: :ok }
  end
end 