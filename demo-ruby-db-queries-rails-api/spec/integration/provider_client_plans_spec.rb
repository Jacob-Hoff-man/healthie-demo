require 'swagger_helper'

RSpec.describe 'Provider Client Plans API', type: :request do
  path '/provider_client_plans' do
    post 'Creates a provider-client-plan relationship' do
      tags 'Provider Client Plans'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :provider_client_plan, in: :body, schema: {
        type: :object,
        properties: {
          provider_client_plan: {
            type: :object,
            properties: {
              provider_id: { type: :integer },
              client_id: { type: :integer },
              plan_name: { type: :string }
            },
            required: %w[provider_id client_id plan_name]
          }
        }
      }

      response '201', 'relationship created' do
        let(:provider) { create(:provider) }
        let(:client) { create(:client) }
        let(:plan) { create(:plan) }
        let(:provider_client_plan) do
          {
            provider_client_plan: {
              provider_id: provider.id,
              client_id: client.id,
              plan_name: plan.name
            }
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:provider_client_plan) do
          {
            provider_client_plan: {
              provider_id: nil,
              client_id: nil,
              plan_name: nil
            }
          }
        end
        run_test!
      end
    end
  end

  path '/provider_client_plans/{provider_id}/{client_id}/{plan_name}' do
    parameter name: :provider_id, in: :path, type: :integer
    parameter name: :client_id, in: :path, type: :integer
    parameter name: :plan_name, in: :path, type: :string

    delete 'Deletes a provider-client-plan relationship' do
      tags 'Provider Client Plans'
      produces 'application/json'

      response '204', 'relationship deleted' do
        let(:provider) { create(:provider) }
        let(:client) { create(:client) }
        let(:plan) { create(:plan) }
        let(:provider_id) { provider.id }
        let(:client_id) { client.id }
        let(:plan_name) { plan.name }

        before do
          create(:provider_client_plan,
                 provider: provider,
                 client: client,
                 plan: plan)
        end

        run_test!
      end

      response '404', 'relationship not found' do
        let(:provider_id) { 0 }
        let(:client_id) { 0 }
        let(:plan_name) { 'invalid' }
        run_test!
      end
    end
  end
end 