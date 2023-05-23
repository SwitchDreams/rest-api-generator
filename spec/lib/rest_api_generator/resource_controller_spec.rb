# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ResourceController", type: :request do
  describe "GET transactions" do
    it "returns http success" do
      get "/transactions"
      expect(response).to have_http_status(:success)
    end

    context "with pagination" do
      before do
        allow_any_instance_of(RestApiGenerator::ResourceController).to receive(:pagination).and_return(true)
      end

      it "returns pagy headers" do
        Transaction.create!
        get "/transactions"
        expect(response.headers["Total-Count"]).to eq("1")
      end

      it "returns second page correctly" do
        21.times { Transaction.create! }
        get "/transactions?page=2"
        expect(response.parsed_body.length).to eq(1)
      end
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

  describe "Ordering/Sorting" do
    context "when sort asc by amount" do
      it "returns first the transaction with lower amount" do
        Transaction.create!(amount: 20)
        t_low = Transaction.create!(amount: 10)
        get "/transactions?sort=+amount"
        expect(JSON.parse(response.body)[0]["id"]).to eq(t_low.id)
      end
    end

    context "when sort desc by amount" do
      it "returns first the transaction with max amount" do
        Transaction.create!(amount: 10)
        t_max = Transaction.create!(amount: 20)

        get "/transactions?sort=-amount"
        expect(JSON.parse(response.body)[0]["id"]).to eq(t_max.id)
      end
    end
  end

  describe "Filtering" do
    it "works fine when model does not have included Filterable" do
      get "/cars"
      expect(response).to have_http_status(:success)
    end

    context "when filter_by side credit" do
      it "returns only the element with side" do
        credit_transaction = Transaction.create!(amount: 20, side: "credit")
        Transaction.create!(amount: 10, side: "debit")
        get "/transactions?side=credit"
        expect(JSON.parse(response.body)[0]["id"]).to eq(credit_transaction.id)
      end
    end
  end

  describe "serialization" do
    context "with panko" do
      it "be serialized by panko serializer" do
        Car.create!(name: "Car")
        get "/serializers/panko/cars"
        expect(JSON.parse(response.body)[0]["panko_field"]).to eq("panko_field")
      end
    end

    context "with ams" do
      it "be serialized by ams serializer" do
        Car.create!(name: "Car")
        get "/serializers/ams/cars"
        expect(JSON.parse(response.body)[0]["ams_field"]).to eq("ams_field")
      end
    end
  end

  describe "callbacks" do
    context "when callbacks exists" do
      it "calls callbacks" do
        car = Car.create!(name: "Car")
        controller = CarsController.new

        allow(controller).to receive(:params).and_return(ActionController::Parameters.new({ id: car.id }))

        # rubocop:disable RSpec/MessageSpies
        expect(controller).to receive(:authorize_logic)
        # rubocop:enable RSpec/MessageSpies

        controller.send(:set_resource)
      end
    end
  end
end
