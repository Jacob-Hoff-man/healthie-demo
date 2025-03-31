require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Journals API', type: :request do
  path '/clients/{client_id}/journals' do
    parameter name: :client_id, in: :path, type: :string, description: 'Client ID'

    get 'Lists all journals for a client' do
      tags 'Journals'
      produces 'application/json'
      
      response '200', 'journals found' do
        let!(:client) { create(:client) }
        let!(:journals) { create_list(:journal, 3, client: client) }
        let(:client_id) { client.id }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response).to be_an(Array)
          expect(json_response.length).to eq(3)
          expect(json_response.first).to include('text', 'client_id')
          expect(json_response.first['client_id']).to eq(client.id)
        end
      end

      response '200', 'client not found returns empty array' do
        let(:client_id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq([])
        end
      end
    end

    post 'Creates a journal entry' do
      tags 'Journals'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :journal, in: :body, schema: {
        type: :object,
        properties: {
          journal: {
            type: :object,
            properties: {
              text: { type: :string },
              client_id: { type: :integer }
            },
            required: ['text', 'client_id']
          }
        }
      }

      response '201', 'journal created' do
        let!(:client) { create(:client) }
        let(:client_id) { client.id }
        let(:journal) { { journal: { text: 'New journal entry', client_id: client.id } } }

        run_test! do
          expect(response).to have_http_status(:created)
          json_response = JSON.parse(response.body)
          expect(json_response['text']).to eq('New journal entry')
          expect(json_response['client_id']).to eq(client.id)
        end
      end

      response '422', 'invalid request' do
        let!(:client) { create(:client) }
        let(:client_id) { client.id }
        let(:journal) { { journal: { text: '', client_id: client.id } } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end
  end

  path '/journals/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'Journal ID'

    get 'Retrieves a journal entry' do
      tags 'Journals'
      produces 'application/json'

      response '200', 'journal found' do
        let!(:journal) { create(:journal) }
        let(:id) { journal.id }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['id']).to eq(journal.id)
          expect(json_response['text']).to eq(journal.text)
          expect(json_response['client_id']).to eq(journal.client_id)
        end
      end

      response '404', 'journal not found' do
        let(:id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end

    put 'Updates a journal entry' do
      tags 'Journals'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :journal, in: :body, schema: {
        type: :object,
        properties: {
          journal: {
            type: :object,
            properties: {
              text: { type: :string }
            }
          }
        }
      }

      response '200', 'journal updated' do
        let!(:test_journal) { create(:journal) }
        let(:id) { test_journal.id }
        let(:journal) { { journal: { text: 'Updated journal entry' } } }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['text']).to eq('Updated journal entry')
          expect(json_response['client_id']).to eq(test_journal.client_id)
        end
      end

      response '404', 'journal not found' do
        let(:id) { 'invalid' }
        let(:journal) { { journal: { text: 'Updated journal entry' } } }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end

      response '422', 'invalid request' do
        let!(:test_journal) { create(:journal) }
        let(:id) { test_journal.id }
        let(:journal) { { journal: { text: '' } } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end

    delete 'Deletes a journal entry' do
      tags 'Journals'
      produces 'application/json'

      response '204', 'journal deleted' do
        let!(:journal) { create(:journal) }
        let(:id) { journal.id }

        run_test! do
          expect(response).to have_http_status(:no_content)
          expect(Journal.exists?(id)).to be false
        end
      end

      response '404', 'journal not found' do
        let(:id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)).to have_key('errors')
        end
      end
    end
  end

  path '/providers/{provider_id}/journals' do
    parameter name: :provider_id, in: :path, type: :string, description: 'Provider ID'

    get 'Lists all journals for a provider\'s clients' do
      tags 'Journals'
      produces 'application/json'

      response '200', 'journals found' do
        let!(:provider) { create(:provider) }
        let!(:client) { create(:client) }
        let!(:plan) { create(:plan) }
        let!(:provider_client_plan) do
          create(:provider_client_plan,
                provider: provider,
                client: client,
                plan_name: plan.name)
        end
        let!(:journals) { create_list(:journal, 3, client: client) }
        let(:provider_id) { provider.id }

        run_test! do
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response).to be_an(Array)
          expect(json_response.length).to eq(3)
          expect(json_response.first).to include('text', 'client_id')
        end
      end

      response '200', 'provider not found returns empty array' do
        let(:provider_id) { 'invalid' }

        run_test! do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq([])
        end
      end
    end
  end
end 