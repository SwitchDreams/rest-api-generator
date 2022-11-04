# frozen_string_literal: true

require "spec_helper"
require "generators/rest_api_generator/resource_generator"
require "support/generators"

RSpec.describe RestApiGenerator::ResourceGenerator, type: :generator do
  setup_default_destination

  before do
    run_generator %w[user]
  end

  describe "controller file" do
    subject { file("app/controllers/users_controller.rb") }

    it { is_expected.to exist }
  end

  describe "spec for the controller" do
    subject { file("spec/requests/users_controller_spec.rb") }

    it { is_expected.to exist }
  end

  describe "model file" do
    subject { file("app/models/user.rb") }

    it { is_expected.to exist }
  end

  describe "migration file" do
    subject { migration_file("db/migrate/create_users.rb") }

    it { is_expected.to exist }
  end

  describe "routes" do
    subject { file("config/routes.rb") }

    it { is_expected.to exist }

    it "has routes defined to the resource" do
      is_expected.to contain("resources :users")
    end
  end
end
