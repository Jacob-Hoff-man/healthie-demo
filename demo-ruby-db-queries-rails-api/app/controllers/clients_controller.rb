class ClientsController < ApplicationController
  def index
    result = ClientService.list_clients
    render json: result.data
  end

  def show
    result = ClientService.find_client(params[:id])
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end

  def create
    result = ClientService.create_client(client_params)
    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    find_result = ClientService.find_client(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = ClientService.update_client(find_result.data, client_params)
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    find_result = ClientService.find_client(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = ClientService.delete_client(find_result.data)
    if result.success?
      head :no_content
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email)
  end
end 