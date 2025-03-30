class ProvidersController < ApplicationController
  def index
    result = ProviderService.list_providers
    render json: result.data
  end

  def show
    result = ProviderService.find_provider(params[:id])
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end

  def create
    result = ProviderService.create_provider(provider_params)
    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    find_result = ProviderService.find_provider(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = ProviderService.update_provider(find_result.data, provider_params)
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    find_result = ProviderService.find_provider(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = ProviderService.delete_provider(find_result.data)
    if result.success?
      head :no_content
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email)
  end
end 