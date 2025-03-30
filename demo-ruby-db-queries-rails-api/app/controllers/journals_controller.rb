class JournalsController < ApplicationController
  def index
    result = if params[:client_id]
      JournalService.list_client_journals(params[:client_id])
    elsif params[:provider_id]
      JournalService.list_provider_client_journals(params[:provider_id])
    else
      JournalService.list_journals
    end
    render json: result.data
  end

  def show
    result = JournalService.find_journal(params[:id])
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :not_found
    end
  end

  def create
    result = JournalService.create_journal(journal_params)
    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def update
    find_result = JournalService.find_journal(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = JournalService.update_journal(find_result.data, journal_params)
    if result.success?
      render json: result.data
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    find_result = JournalService.find_journal(params[:id])
    return render json: { errors: find_result.errors }, status: :not_found unless find_result.success?

    result = JournalService.delete_journal(find_result.data)
    if result.success?
      head :no_content
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:client_id, :text)
  end
end 