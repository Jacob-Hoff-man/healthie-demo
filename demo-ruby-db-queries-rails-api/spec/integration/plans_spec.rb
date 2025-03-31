require 'swagger_helper'

RSpec.describe 'Plans API', type: :request do
  path '/plans' do
    get 'Lists all plans' do
      tags 'Plans'
      produces 'application/json'

      response '200', 'plans found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id name]
               }

        run_test!
      end
    end

    post 'Creates a plan' do
      tags 'Plans'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :plan, in: :body, schema: {
        type: :object,
        properties: {
          plan: {
            type: :object,
            properties: {
              name: { type: :string }
            },
            required: %w[name]
          }
        }
      }

      response '201', 'plan created' do
        let(:plan) { { plan: { name: 'premium-plan' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:plan) { { plan: { name: '' } } }
        run_test!
      end
    end
  end

  path '/plans/{name}' do
    parameter name: :name, in: :path, type: :string

    get 'Retrieves a plan' do
      tags 'Plans'
      produces 'application/json'

      response '200', 'plan found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: %w[id name]

        let(:name) { create(:plan).name }
        run_test!
      end

      response '404', 'plan not found' do
        let(:name) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a plan' do
      tags 'Plans'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :plan, in: :body, schema: {
        type: :object,
        properties: {
          plan: {
            type: :object,
            properties: {
              name: { type: :string }
            }
          }
        }
      }

      response '200', 'plan updated' do
        let(:name) { create(:plan).name }
        let(:plan) { { plan: { name: 'updated-plan' } } }
        run_test!
      end

      response '404', 'plan not found' do
        let(:name) { 'invalid' }
        let(:plan) { { plan: { name: 'updated-plan' } } }
        run_test!
      end
    end

    delete 'Deletes a plan' do
      tags 'Plans'
      produces 'application/json'

      response '204', 'plan deleted' do
        let(:name) { create(:plan).name }
        run_test!
      end

      response '404', 'plan not found' do
        let(:name) { 'invalid' }
        run_test!
      end
    end
  end

  path '/plans/{name}/provider_client_plans' do
    parameter name: :name, in: :path, type: :string

    get 'Lists all provider-client relationships for a plan' do
      tags 'Plans', 'Provider Client Plans'
      produces 'application/json'

      response '200', 'relationships found' do
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

        let(:name) { create(:plan).name }
        run_test!
      end
    end
  end
end 