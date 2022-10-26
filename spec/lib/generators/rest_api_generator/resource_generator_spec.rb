# frozen_string_literal: true

require "generators/rest_api_generator/resource_generator"
require "spec_helper"
require "support/generators"

RSpec.describe RestApiGenerator::ResourceGenerator, type: :generator do
  setup_default_destination

  before do
    run_generator %w[user]
  end

  describe "creates a controller" do
    subject { file("app/controllers/users_controller.rb") }

    it { is_expected.to exist }
  end

  describe "creates a spec for the controller" do
    subject { file("spec/requests/users_controller_spec.rb") }

    it { is_expected.to exist }
  end

  describe "creates a model file" do
    subject { file("app/models/user.rb") }

    it { is_expected.to exist }
  end
end
