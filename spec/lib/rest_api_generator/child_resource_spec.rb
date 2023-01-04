# frozen_string_literal: true

# Generated with: "rails g rest_api_generator:spec:rswag Driver car:references name:string --father Cars"
require "swagger_helper"
require "rest_api_generator/child_resource_controller"

RSpec.describe "/cars/{car_id}/drivers", type: :request do
  let(:resource) { Driver.create!(car: parent_resource) }
  let(:parent_resource) { Car.create! }

  path "/cars/{car_id}/drivers" do
    parameter name: "car_id", in: :path, type: :string, description: " car id"

    let(:car_id) { parent_resource.id }

    get("list drivers") do
      consumes "application/json"

      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test!
      end
    end

    post("create driver") do
      consumes "application/json"

      # You'll want to customize the parameter types...
      parameter name: :driver, in: :body, schema: {
        type: :object,
        properties: {
          car: { type: :string },
          name: { type: :string },
        },
      }
      response(201, "successful") do
        let(:driver) { { name: "Chefe" } }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test!
      end
    end
  end

  path "/cars/{car_id}/drivers/{id}" do
    parameter name: "id", in: :path, type: :string, description: "id"
    parameter name: "car_id", in: :path, type: :string, description: " car id"

    let(:id) { resource.id }
    let(:car_id) { parent_resource.id }

    get("show driver") do
      consumes "application/json"

      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test!
      end
    end

    patch("update driver") do
      consumes "application/json"

      # You'll want to customize the parameter types...
      parameter name: :driver, in: :body, schema: {
        type: :object,
        properties: {
          car: { type: :string },
          name: { type: :string },
        },
      }

      response(200, "successful") do
        let(:driver) { { name: "Chefe" } }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test!
      end
    end

    delete("delete plan") do
      consumes "application/json"

      response(204, "successful") do
        run_test!
      end
    end
  end
end
