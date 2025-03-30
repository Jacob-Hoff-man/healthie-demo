class FoodService
  def self.list_all
    Food.all.to_a
  rescue StandardError => e
    Rails.logger.error("Error fetching foods: #{e.message}")
    []
  end

  def self.create(params)
    Food.create!(name: params[:name])
    { success: true, data: food, status: :created }
  rescue ActiveRecord::RecordInvalid => e
    { success: false, errors: e.message, status: :unprocessable_entity }
  end

  def self.list_food_liked_by_animals(food_name)
    food = Food.includes(:liked_by_animals).find_by(name: food_name)
    return { success: false, error: "Food not found", status: :not_found } unless food

    { 
      success: true, 
      data: food.liked_by_animals.pluck(:name), 
      status: :ok 
    }
  end
end 