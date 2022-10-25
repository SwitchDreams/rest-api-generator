# frozen_string_literal: true

require "generator_spec"
require "generators/rest_api_generator/resource_generator"

RSpec.describe RestApiGenerator::ResourceGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __dir__)
  arguments %w[user]

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a controller" do
    assert_file "app/controllers/users_controller.rb"
  end

  it "creates a spec for the controller" do
    assert_file "spec/requests/users_controller_spec.rb"
  end
end
