class FoodsController < ApplicationController
  def index
    @foods = FoodService.list_all
    render json: @foods
  end

  def create
    result = FoodService.create(food_params)
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: result[:errors], status: result[:status]
    end
  end

  def list_food_liked_by_animals
    result = FoodService.list_food_liked_by_animals(params[:id])
    
    if result[:success]
      render json: result[:data], status: result[:status]
    else
      render json: { error: result[:error] }, status: result[:status]
    end
  end

  private

  def food_params
    params.require(:food).permit(:name)
  end
end 