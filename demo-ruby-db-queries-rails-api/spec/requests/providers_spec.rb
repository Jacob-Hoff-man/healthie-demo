require 'rails_helper'

RSpec.describe "Providers", type: :request do
  describe "GET /providers" do
    context "when there are providers" do
      let!(:providers) { create_list(:provider, 3) }

      it "returns all providers" do
        get "/providers"
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(3)
        expect(json_response.first["name"]).to eq(providers.first.name)
        expect(json_response.first["email"]).to eq(providers.first.email)
      end
    end

    context "when there are no providers" do
      it "returns an empty array" do
        get "/providers"
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_empty
      end
    end
  end

  describe "GET /providers/:id" do
    context "when the provider exists" do
      let!(:provider) { create(:provider) }

      it "returns the provider" do
        get "/providers/#{provider.id}"
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(provider.id)
        expect(json_response["name"]).to eq(provider.name)
        expect(json_response["email"]).to eq(provider.email)
      end
    end

    context "when the provider does not exist" do
      it "returns not found status" do
        get "/providers/0"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /providers" do
    let(:valid_attributes) do
      {
        provider: {
          name: "Dr. Smith",
          email: "dr.smith@example.com"
        }
      }
    end

    let(:invalid_attributes) do
      {
        provider: {
          name: "",
          email: "invalid-email"
        }
      }
    end

    context "with valid params" do
      it "creates a new provider" do
        expect {
          post "/providers", params: valid_attributes
        }.to change(Provider, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq("Dr. Smith")
        expect(json_response["email"]).to eq("dr.smith@example.com")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        post "/providers", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /providers/:id" do
    let!(:provider) { create(:provider) }
    let(:new_attributes) do
      {
        provider: {
          name: "Dr. Jones",
          email: "dr.jones@example.com"
        }
      }
    end

    context "when the provider exists" do
      it "updates the provider" do
        put "/providers/#{provider.id}", params: new_attributes
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq("Dr. Jones")
        expect(json_response["email"]).to eq("dr.jones@example.com")
      end
    end

    context "when the provider does not exist" do
      it "returns not found status" do
        put "/providers/0", params: new_attributes
        expect(response).to have_http_status(:not_found)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        put "/providers/#{provider.id}", params: { provider: { name: "", email: "invalid-email" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /providers/:id" do
    let!(:provider) { create(:provider) }

    context "when the provider exists" do
      it "deletes the provider" do
        expect {
          delete "/providers/#{provider.id}"
        }.to change(Provider, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the provider does not exist" do
      it "returns not found status" do
        delete "/providers/0"
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

  describe "GET /providers/:provider_id/journals" do
    let!(:provider) { create(:provider) }
    let!(:client) { create(:client) }
    let!(:plan) { create(:plan) }
    let!(:provider_client_plan) do
      create(:provider_client_plan,
             provider: provider,
             client: client,
             plan: plan)
    end
    let!(:journals) { create_list(:journal, 3, client: client) }

    it "returns all journals for the provider" do
      get "/providers/#{provider.id}/journals"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
      expect(json_response.first["client_id"]).to eq(client.id)
    end
  end
end 