require 'swagger_helper'

RSpec.describe 'Clients API', type: :request do
  path '/clients' do
    get 'Lists all clients' do
      tags 'Clients'
      produces 'application/json'

      response '200', 'clients found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   email: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id name email]
               }

        run_test!
      end
    end

    post 'Creates a client' do
      tags 'Clients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          client: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string }
            },
            required: %w[name email]
          }
        }
      }

      response '201', 'client created' do
        let(:client) { { client: { name: 'John Doe', email: 'john@example.com' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:client) { { client: { name: '', email: 'invalid-email' } } }
        run_test!
      end
    end
  end

  path '/clients/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a client' do
      tags 'Clients'
      produces 'application/json'

      response '200', 'client found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: %w[id name email]

        let(:id) { create(:client).id }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a client' do
      tags 'Clients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          client: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string }
            }
          }
        }
      }

      response '200', 'client updated' do
        let(:id) { create(:client).id }
        let(:client) { { client: { name: 'Jane Doe', email: 'jane@example.com' } } }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        let(:client) { { client: { name: 'Jane Doe', email: 'jane@example.com' } } }
        run_test!
      end
    end

    delete 'Deletes a client' do
      tags 'Clients'
      produces 'application/json'

      response '204', 'client deleted' do
        let(:id) { create(:client).id }
        run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/clients/{client_id}/providers' do
    parameter name: :client_id, in: :path, type: :integer

    get 'Lists all providers for a client' do
      tags 'Clients', 'Providers'
      produces 'application/json'

      response '200', 'providers found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   provider_id: { type: :integer },
                   client_id: { type: :integer },
                   plan_name: { type: :string }
                 },
                 required: %w[provider_id client_id plan_name]
               }

        let(:client_id) { create(:client).id }
        run_test!
      end
    end
  end

  path '/clients/{client_id}/journals' do
    parameter name: :client_id, in: :path, type: :integer

    get 'Lists all journals for a client' do
      tags 'Clients', 'Journals'
      produces 'application/json'

      response '200', 'journals found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   client_id: { type: :integer },
                   text: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id client_id text]
               }

        let(:client_id) { create(:client).id }
        run_test!
      end
    end
  end
end 