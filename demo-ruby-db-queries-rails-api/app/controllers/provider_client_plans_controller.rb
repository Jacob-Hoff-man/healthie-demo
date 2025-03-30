class ProviderClientPlansController < ApplicationController
  def create
    result = ProviderClientPlanService.create_provider_client_plan(provider_client_plan_params)
    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    result = ProviderClientPlanService.delete_provider_client_plan(
      params[:provider_id],
      params[:client_id],
      params[:plan_name]
    )

    if result.success?
      head :no_content
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end

  def provider_clients
    result = ProviderClientPlanService.list_provider_clients(params[:provider_id])
    render json: result.data
  end

  def client_providers
    result = ProviderClientPlanService.list_client_providers(params[:client_id])
    render json: result.data
  end

  def plan_provider_client_plans
    result = ProviderClientPlanService.list_plan_provider_client_plans(params[:plan_name])
    render json: result.data
  end

  private

  def provider_client_plan_params
    params.require(:provider_client_plan).permit(:provider_id, :client_id, :plan_name)
  end
end 