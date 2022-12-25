# frozen_string_literal: true

require "spec_helper"
require "rest_api_generator/resource_controller"

RSpec.describe "ResourceController", type: :request do
  describe "GET transactions" do
    it "returns http success" do
      get "/transactions"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET transaction" do
    it "returns http success" do
      t = Transaction.create!
      get "/transactions/#{t.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST transactions" do
    it "creates a new transaction" do
      expect { post "/transactions", params: { transaction: { amount: 20 } } }.to change(Transaction, :count).by(1)
    end
  end

  describe "PATCH transaction" do
    it "returns http success" do
      t = Transaction.create!(amount: 10)
      patch "/transactions/#{t.id}", params: { transaction: { amount: 20 } }
      expect(response).to have_http_status(:success)
    end

    it "changes updated params" do
      t = Transaction.create!(amount: 10)
      expect do
        patch "/transactions/#{t.id}", params: { transaction: { amount: 20 } }
        t.reload
      end.to change(t, :amount).from(10).to(20)
    end
  end

  describe "DELETE transaction" do
    it "destroy the transaction" do
      t = Transaction.create!(amount: 10)
      expect { delete "/transactions/#{t.id}" }.to change(Transaction, :count).by(-1)
    end
  end
end
