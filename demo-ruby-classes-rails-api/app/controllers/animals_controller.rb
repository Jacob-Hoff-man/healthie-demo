class AnimalsController < ApplicationController
  def index
    @animals = AnimalService.list_all
    render json: @animals
  end

  def show
    result = AnimalService.find_with_foods(params[:id])
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: { error: result[:error] }, status: result[:status]
    end
  end

  def create
    result = AnimalService.create(animal_params)
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: result[:errors], status: result[:status]
    end
  end

  def check_animal_likes_food
    result = AnimalService.check_animal_likes_food(
      animal_name: params[:id],
      food_name: params[:food_name]
    )
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: { error: result[:error] }, status: result[:status]
    end
  end

  def list_animal_likes_food
    result = AnimalService.list_animal_likes_food(params[:id])
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: { error: result[:error] }, status: result[:status]
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :noise, foods: [])
  end
end 