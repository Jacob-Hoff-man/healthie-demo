require_relative 'result'

class JournalService
  Result = ::Result
  
  class << self
    def list_journals
      Result.success(Journal.all)
    end

    def find_journal(id)
      journal = Journal.find_by(id: id)
      journal ? Result.success(journal) : Result.error(['Journal not found'])
    end

    def create_journal(params)
      journal = Journal.new(params)
      if journal.save
        Result.success(journal)
      else
        Result.error(journal.errors.full_messages)
      end
    end

    def update_journal(journal, params)
      if journal.update(params)
        Result.success(journal)
      else
        Result.error(journal.errors.full_messages)
      end
    end

    def delete_journal(journal)
      if journal.destroy
        Result.success(nil)
      else
        Result.error(journal.errors.full_messages)
      end
    end

    def list_client_journals(client_id)
      journals = Journal.where(client_id: client_id).order(updated_at: :desc)
      Result.success(journals)
    end

    def list_provider_client_journals(provider_id)
      journals = Journal.joins(client: :provider_client_plans)
                       .where(provider_client_plans: { provider_id: provider_id })
                       .includes(:client)  # Eager load client data
                       .order(updated_at: :desc)
      Result.success(journals)
    end
  end
end 