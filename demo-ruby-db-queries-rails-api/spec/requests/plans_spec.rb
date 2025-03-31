require 'rails_helper'

RSpec.describe "Plans", type: :request do
  describe "GET /plans" do
    it "returns all plans" do
      create_list(:plan, 3)
      get "/plans"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe "POST /plans" do
    let(:valid_attributes) { { plan: { name: "premium-plan" } } }
    let(:invalid_attributes) { { plan: { name: "" } } }

    context "with valid params" do
      it "creates a new plan" do
        post "/plans", params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["name"]).to eq("premium-plan")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        post "/plans", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /plans/:name" do
    let(:plan) { create(:plan) }

    it "returns a success response" do
      get "/plans/#{plan.name}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /plans/:name" do
    let(:plan) { create(:plan) }
    let(:new_attributes) { { plan: { name: "updated-plan" } } }

    it "updates the requested plan" do
      put "/plans/#{plan.name}", params: new_attributes
      expect(response).to have_http_status(:ok)
      expect(Plan.find_by(name: "updated-plan")).to be_present
    end
  end

  describe "DELETE /plans/:name" do
    let(:plan) { create(:plan) }

    it "destroys the requested plan" do
      delete "/plans/#{plan.name}"
      expect(response).to have_http_status(:no_content)
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

    it "returns a success response" do
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