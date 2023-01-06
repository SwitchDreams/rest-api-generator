# frozen_string_literal: true

require "spec_helper"
require "generators/rest_api_generator/spec/rspec_generator"
require "support/generators"

RSpec.describe RestApiGenerator::Spec::RspecGenerator, type: :generator do
  setup_default_destination

  context "when is nested resource" do
    before do
      run_generator ["Driver", "car:references", "name:string", "--father", "Cars"]
    end

    describe "spec file" do
      subject(:spec_file) { file("spec/requests/cars/drivers_controller_spec.rb") }

      it { is_expected.to exist }

      it "describe right routes for show" do
        expect(spec_file).to contain('/cars/#{car.id}/drivers/#{driver.id}')
      end
    end
  end

  context "when is scoped resource" do
    before do
      run_generator ["Driver", "car:references", "name:string", "--scope", "Cars"]
    end

    describe "spec file" do
      subject(:spec_file) { file("spec/requests/cars/drivers_controller_spec.rb") }

      it { is_expected.to exist }

      it "describe right routes for show" do
        expect(spec_file).to contain('/cars/drivers/#{driver.id}')
      end
    end
  end

  context "when is scoped and nested resource" do
    before do
      run_generator ["Driver", "car:references", "name:string", "--scope", "api", "--father", "Cars"]
    end

    describe "spec file" do
      subject(:spec_file) { file("spec/requests/api/cars/drivers_controller_spec.rb") }

      it { is_expected.to exist }

      it "describe right routes for show" do
        expect(spec_file).to contain('/api/cars/#{car.id}/drivers/#{driver.id}')
      end
    end
  end
end
