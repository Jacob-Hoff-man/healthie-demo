require 'swagger_helper'

RSpec.describe 'Providers API', type: :request do
  path '/providers' do
    get 'Lists all providers' do
      tags 'Providers'
      produces 'application/json'

      response '200', 'providers found' do
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

    post 'Creates a provider' do
      tags 'Providers'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :provider, in: :body, schema: {
        type: :object,
        properties: {
          provider: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string }
            },
            required: %w[name email]
          }
        }
      }

      response '201', 'provider created' do
        let(:provider) { { provider: { name: 'Dr. Smith', email: 'dr.smith@example.com' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:provider) { { provider: { name: '', email: 'invalid-email' } } }
        run_test!
      end
    end
  end

  path '/providers/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a provider' do
      tags 'Providers'
      produces 'application/json'

      response '200', 'provider found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: %w[id name email]

        let(:id) { create(:provider).id }
        run_test!
      end

      response '404', 'provider not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a provider' do
      tags 'Providers'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :provider, in: :body, schema: {
        type: :object,
        properties: {
          provider: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string }
            }
          }
        }
      }

      response '200', 'provider updated' do
        let(:id) { create(:provider).id }
        let(:provider) { { provider: { name: 'Dr. Jones', email: 'dr.jones@example.com' } } }
        run_test!
      end

      response '404', 'provider not found' do
        let(:id) { 'invalid' }
        let(:provider) { { provider: { name: 'Dr. Jones', email: 'dr.jones@example.com' } } }
        run_test!
      end
    end

    delete 'Deletes a provider' do
      tags 'Providers'
      produces 'application/json'

      response '204', 'provider deleted' do
        let(:id) { create(:provider).id }
        run_test!
      end

      response '404', 'provider not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/providers/{provider_id}/clients' do
    parameter name: :provider_id, in: :path, type: :integer

    get 'Lists all clients for a provider' do
      tags 'Providers', 'Clients'
      produces 'application/json'

      response '200', 'clients found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   client_id: { type: :integer },
                   provider_id: { type: :integer },
                   plan_name: { type: :string }
                 },
                 required: %w[client_id provider_id plan_name]
               }

        let(:provider_id) { create(:provider).id }
        run_test!
      end
    end
  end

  path '/providers/{provider_id}/journals' do
    parameter name: :provider_id, in: :path, type: :integer

    get 'Lists all journals for a provider' do
      tags 'Providers', 'Journals'
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

        let(:provider_id) { create(:provider).id }
        run_test!
      end
    end
  end
end 