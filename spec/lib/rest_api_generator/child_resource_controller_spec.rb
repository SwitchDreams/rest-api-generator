# frozen_string_literal: true

require "spec_helper"
require "rest_api_generator/child_resource_controller"

RSpec.describe "ChildResourceController", type: :request do
  describe "GET cars/drivers" do
    it "returns http success" do
      car = Car.create!
      get "/cars/#{car.id}/drivers"
      expect(response).to have_http_status(:success)
    end

    context "with pagination" do
      before do
        allow_any_instance_of(RestApiGenerator::ChildResourceController).to receive(:pagination).and_return(true)
      end

      it "returns pagy headers" do
        car = Car.create!
        Driver.create!(car: car)
        get "/cars/#{car.id}/drivers"
        expect(response.headers["Total-Count"]).to eq("1")
      end

      it "returns second page correctly" do
        car = Car.create!
        21.times { Driver.create!(car: car) }
        get "/cars/#{car.id}/drivers?page=2"
        expect(response.parsed_body.length).to eq(1)
      end
    end
  end

  describe "GET cars/driver" do
    it "returns http success" do
      car = Car.create!
      driver = Driver.create!(car: car)
      get "/cars/#{car.id}/drivers/#{driver.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST cars/driver" do
    it "creates a new driver to a car" do
      car = Car.create!
      expect do
        post "/cars/#{car.id}/drivers/", params: { driver: { name: "Chefe" } }
      end.to change(car.drivers, :count).by(1)
    end
  end

  describe "PATCH cars/driver" do
    it "returns http success" do
      car = Car.create!
      driver = Driver.create!(car: car)
      patch "/cars/#{car.id}/drivers/#{driver.id}", params: { driver: { name: "Chefe2" } }
      expect(response).to have_http_status(:success)
    end

    it "changes updated params" do
      car = Car.create!
      driver = Driver.create!(car: car, name: "Chefe")
      expect do
        patch "/cars/#{car.id}/drivers/#{driver.id}", params: { driver: { name: "Chefe2" } }
        driver.reload
      end.to change(driver, :name).from("Chefe").to("Chefe2")
    end
  end

  describe "DELETE cars/driver" do
    it "destroy car driver" do
      car = Car.create!
      driver = Driver.create!(car: car)
      expect { delete "/cars/#{car.id}/drivers/#{driver.id}" }.to change(car.drivers, :count).by(-1)
    end
  end
end
