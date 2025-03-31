class PlansController < ApplicationController
  def index
    result = PlanService.list_plans
    render json: result.data
  end

  def show
    result = PlanService.find_plan(params[:name])
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end

  def create
    result = PlanService.create_plan(plan_params)
    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    find_result = PlanService.find_plan(params[:name])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = PlanService.update_plan(find_result.data, plan_params)
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    find_result = PlanService.find_plan(params[:name])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = PlanService.delete_plan(find_result.data)
    if result.success?
      head :no_content
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name)
  end
end 