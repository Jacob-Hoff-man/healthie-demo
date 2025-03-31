require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Clients API', type: :request do
  path '/clients' do
    get 'Lists all clients' do
      tags 'Clients'
      produces 'application/json'

      response '200', 'clients found' do
        let!(:clients) { create_list(:client, 3) }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response).to be_an(Array)
          expect(json_response.length).to eq(3)
        end
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
        let(:client) { { client: attributes_for(:client) } }

        run_test! do
          expect(response).to have_http_status(:created)
          json_response = JSON.parse(response.body)
          expect(json_response['name']).to eq(client[:client][:name])
          expect(json_response['email']).to eq(client[:client][:email])
        end
      end

      response '422', 'invalid request' do
        let(:client) { { client: attributes_for(:client, :invalid_email) } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end
  end

  path '/clients/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves a client' do
      tags 'Clients'
      produces 'application/json'

      response '200', 'client found' do
        let!(:test_client) { create(:client) }
        let(:id) { test_client.id }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['id']).to eq(test_client.id)
          expect(json_response['name']).to eq(test_client.name)
          expect(json_response['email']).to eq(test_client.email)
        end
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
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
        let!(:test_client) { create(:client) }
        let(:id) { test_client.id }
        let(:client) { { client: { name: 'Updated Name' } } }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['name']).to eq('Updated Name')
          expect(json_response['email']).to eq(test_client.email)
        end
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        let(:client) { { client: { name: 'Updated Name' } } }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end

      response '422', 'invalid request' do
        let!(:test_client) { create(:client) }
        let(:id) { test_client.id }
        let(:client) { { client: { email: 'invalid_email' } } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end

    delete 'Deletes a client' do
      tags 'Clients'
      produces 'application/json'

      response '204', 'client deleted' do
        let!(:test_client) { create(:client) }
        let(:id) { test_client.id }

        run_test! do
          expect(response).to have_http_status(:no_content)
          expect(Client.exists?(id)).to be false
        end
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end
  end
end 