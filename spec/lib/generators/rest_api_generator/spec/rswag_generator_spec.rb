# frozen_string_literal: true

require "spec_helper"
require "generators/rest_api_generator/spec/rswag_generator"
require "support/generators"

RSpec.describe RestApiGenerator::Spec::RswagGenerator, type: :generator do
  setup_default_destination

  context "when is normal resource" do
    before do
      run_generator ["User", "name:string"]
    end

    describe "spec file" do
      subject(:spec_file) { file("spec/docs/users_spec.rb") }

      it { is_expected.to exist }

      it "describe index and create path" do
        expect(spec_file).to contain("/users")
      end

      it "describe show, update, delete path" do
        expect(spec_file).to contain("/users/{id}")
      end

      it "has name schema for input" do
        expect(spec_file).to contain("name: { type: :string }")
      end
    end
  end

  context "when is nested resource" do
    before do
      run_generator ["Driver", "car:references", "name:string", "--father", "Cars"]
    end

    describe "spec file" do
      subject(:spec_file) { file("spec/docs/cars/drivers_spec.rb") }

      it { is_expected.to exist }

      it "describe index and create path" do
        expect(spec_file).to contain("/cars/{car_id}/drivers")
      end

      it "describe show, update, delete path" do
        expect(spec_file).to contain("/cars/{car_id}/drivers/{id}")
      end

      it "has name schema for input" do
        expect(spec_file).to contain("name: { type: :string }")
      end
    end
  end
end
