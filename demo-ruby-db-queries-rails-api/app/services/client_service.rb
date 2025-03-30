require_relative 'result'

class ClientService
  Result = ::Result

  class << self
    def list_clients
      Result.success(Client.all)
    end

    def find_client(id)
      client = Client.find_by(id: id)
      client ? Result.success(client) : Result.error(['Client not found'])
    end

    def create_client(params)
      client = Client.new(params)
      if client.save
        Result.success(client)
      else
        Result.error(client.errors.full_messages)
      end
    end

    def update_client(client, params)
      if client.update(params)
        Result.success(client)
      else
        Result.error(client.errors.full_messages)
      end
    end

    def delete_client(client)
      if client.destroy
        Result.success(nil)
      else
        Result.error(client.errors.full_messages)
      end
    end

    def list_client_providers(client_id)
      client = Client.find_by(id: client_id)
      return Result.error("Client not found") unless client

      providers = client.providers.distinct
      Result.success(providers)
    end
  end
end 