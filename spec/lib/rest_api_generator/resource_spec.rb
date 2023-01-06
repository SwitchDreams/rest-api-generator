# frozen_string_literal: true

# Testing rswag
require "swagger_helper"
require "rest_api_generator/resource_controller"

RSpec.describe "/cars", type: :request do
  let(:resource) { Car.create! }

  path "/cars" do
    get("list cars") do
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

    post("create car") do
      consumes "application/json"
      # You'll want to customize the parameter types...
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          color: { type: :string },
        },
      }
      response(201, "successful") do
        let(:car) { { name: "Switch", color: "Dreams" } }

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

  path "/cars/{id}" do
    parameter name: "id", in: :path, type: :string, description: "id"

    get("show car") do
      consumes "application/json"

      response(200, "successful") do
        let(:id) { resource.id }

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

    patch("update car") do
      consumes "application/json"
      # You'll want to customize the parameter types...
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          color: { type: :string },
        },
      }

      response(200, "successful") do
        let(:id) { resource.id }
        let(:car) { { name: "Switch", color: "Dreams" } }

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
        let(:id) { resource.id }

        run_test!
      end
    end
  end
end
