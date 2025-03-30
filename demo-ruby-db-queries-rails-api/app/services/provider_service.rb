require_relative 'result'

class ProviderService
  Result = ::Result

  class << self
    def list_providers
      Result.success(Provider.all)
    end

    def find_provider(id)
      provider = Provider.find_by(id: id)
      provider ? Result.success(provider) : Result.error(['Provider not found'])
    end

    def create_provider(params)
      provider = Provider.new(params)
      if provider.save
        Result.success(provider)
      else
        Result.error(provider.errors.full_messages)
      end
    end

    def update_provider(provider, params)
      if provider.update(params)
        Result.success(provider)
      else
        Result.error(provider.errors.full_messages)
      end
    end

    def delete_provider(provider)
      if provider.destroy
        Result.success(nil)
      else
        Result.error(provider.errors.full_messages)
      end
    end

    def list_provider_clients(provider_id)
      provider = Provider.find_by(id: provider_id)
      return Result.error("Provider not found") unless provider

      clients = provider.clients.distinct
      Result.success(clients)
    end
  end
end 