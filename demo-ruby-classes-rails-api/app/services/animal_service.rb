class AnimalService
  def self.list_all
    Animal.all.to_a
  rescue StandardError => e
    Rails.logger.error("Error fetching animals: #{e.message}")
    []
  end

  def self.create(params)
    ActiveRecord::Base.transaction do
      animal = Animal.new(
        name: params[:name],
        noise: params[:noise]
      )
      
      if animal.save
        # Handle food relationships if provided
        if params[:foods].present?
          params[:foods].each do |food_name|
            # Find or create the food
            food = Food.find_or_create_by!(name: food_name)
            
            # Create the relationship
            AnimalLikesFood.create!(
              animal_name: animal.name,
              food_name: food.name
            )
          end
        end
        
        # Return animal with its relationships
        { 
          success: true, 
          data: animal.as_json(include: :liked_foods), 
          status: :created 
        }
      else
        { success: false, errors: animal.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    { 
      success: false, 
      errors: e.message, 
      status: :unprocessable_entity 
    }
  end

  def self.check_animal_likes_food(animal_name:, food_name:)
    # Check if relationship exists first (this is the fastest query due to the index)
    relationship = AnimalLikesFood.find_by(animal_name: animal_name, food_name: food_name)
    
    if relationship
      # If relationship exists, we know both animal and food exist, just get animal's noise
      animal = Animal.find(animal_name)
      return { success: true, data: "#{animal.noise} #{animal.noise} #{animal.noise}", status: :ok }
    end

    # If no relationship, check if animal exists
    animal = Animal.find_by(name: animal_name)
    return { success: false, error: "Animal not found", status: :not_found } unless animal

    # Check if food exists
    food = Food.find_by(name: food_name)
    return { success: false, error: "Food not found", status: :not_found } unless food

    # Both exist but no relationship
    { success: true, data: animal.noise, status: :ok }
  end

  def self.list_animal_likes_food(animal_name)
    animal = Animal.includes(:liked_foods).find_by(name: animal_name)
    return { success: false, error: "Animal not found", status: :not_found } unless animal

    { 
      success: true, 
      data: animal.liked_foods.pluck(:name), 
      status: :ok 
    }
  end
end 