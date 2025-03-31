require 'rails_helper'

RSpec.describe "ProviderClientPlans", type: :request do
  describe "POST /provider_client_plans" do
    let(:provider) { create(:provider) }
    let(:client) { create(:client) }
    let(:plan) { create(:plan) }
    let(:valid_attributes) do
      {
        provider_client_plan: {
          provider_id: provider.id,
          client_id: client.id,
          plan_name: plan.name
        }
      }
    end
    let(:invalid_attributes) do
      {
        provider_client_plan: {
          provider_id: nil,
          client_id: nil,
          plan_name: nil
        }
      }
    end

    context "with valid params" do
      it "creates a new provider_client_plan" do
        expect {
          post "/provider_client_plans", params: valid_attributes
        }.to change(ProviderClientPlan, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["provider_id"]).to eq(provider.id)
        expect(json_response["client_id"]).to eq(client.id)
        expect(json_response["plan_name"]).to eq(plan.name)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        post "/provider_client_plans", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /provider_client_plans/:provider_id/:client_id/:plan_name" do
    let!(:provider) { create(:provider) }
    let!(:client) { create(:client) }
    let!(:plan) { create(:plan) }
    let!(:provider_client_plan) do
      create(:provider_client_plan,
             provider: provider,
             client: client,
             plan: plan)
    end

    context "when the relationship exists" do
      it "destroys the provider_client_plan" do
        expect {
          delete "/provider_client_plans/#{provider.id}/#{client.id}/#{plan.name}"
        }.to change(ProviderClientPlan, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the relationship does not exist" do
      it "returns not found status" do
        delete "/provider_client_plans/0/0/nonexistent"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /providers/:provider_id/clients" do
    let!(:provider) { create(:provider) }
    let!(:clients) { create_list(:client, 3) }
    let!(:plan) { create(:plan) }

    before do
      clients.each do |client|
        create(:provider_client_plan,
               provider: provider,
               client: client,
               plan: plan)
      end
    end

    it "returns all clients for the provider" do
      get "/providers/#{provider.id}/clients"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
      expect(json_response.first["client_id"]).to eq(clients.first.id)
    end
  end

  describe "GET /clients/:client_id/providers" do
    let!(:client) { create(:client) }
    let!(:providers) { create_list(:provider, 3) }
    let!(:plan) { create(:plan) }

    before do
      providers.each do |provider|
        create(:provider_client_plan,
               provider: provider,
               client: client,
               plan: plan)
      end
    end

    it "returns all providers for the client" do
      get "/clients/#{client.id}/providers"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
      expect(json_response.first["provider_id"]).to eq(providers.first.id)
    end
  end

  describe "GET /plans/:name/provider_client_plans" do
    let!(:plan) { create(:plan) }
    let!(:provider) { create(:provider) }
    let!(:client) { create(:client) }
    let!(:provider_client_plan) do
      create(:provider_client_plan,
             provider: provider,
             client: client,
             plan: plan)
    end

    it "returns all provider_client_plans for the plan" do
      get "/plans/#{plan.name}/provider_client_plans"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
      expect(json_response.first["provider_id"]).to eq(provider.id)
      expect(json_response.first["client_id"]).to eq(client.id)
      expect(json_response.first["plan_name"]).to eq(plan.name)
    end
  end
end 