# frozen_string_literal: true

require "spec_helper"
require "generators/rest_api_generator/resource_generator"
require "support/generators"

RSpec.describe RestApiGenerator::ResourceGenerator, type: :generator do
  setup_default_destination

  context "when run with normal attributes" do
    before do
      run_generator ["user"]
    end

    describe "controller file" do
      subject { file("app/controllers/users_controller.rb") }

      it { is_expected.to contain(/RestApiGenerator::ResourceController/) }
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
      subject(:route_file) { file("config/routes.rb") }

      it { is_expected.to exist }

      it "has routes defined to the resource" do
        expect(route_file).to contain("resources :users")
      end
    end
  end

  context "when run with eject" do
    before do
      run_generator(["user", "--eject", "true"])
    end

    describe "controller file" do
      subject { file("app/controllers/users_controller.rb") }

      it { is_expected.to contain(/index/) }
      it { is_expected.to exist }
    end
  end

  context "with scope" do
    before do
      run_generator(["user", "--scope", "Api::V1"])
    end

    describe "controller file" do
      subject { file("app/controllers/api/v1/users_controller.rb") }

      it { is_expected.to exist }
      it { is_expected.to contain(/module Api::V1/) }
    end
  end

  context "with nested resource" do
    before do
      run_generator(["user", "--father", "Country"])
    end

    describe "controller file" do
      subject { file("app/controllers/country/users_controller.rb") }

      it { is_expected.to exist }
      it { is_expected.to contain(/module Country/) }
      it { is_expected.to contain(/RestApiGenerator::ChildResourceController/) }
    end
  end

  context "with nested resource and scope" do
    before do
      run_generator(["user", "--father", "Country", "--scope", "Api"])
    end

    describe "controller file" do
      subject { file("app/controllers/api/country/users_controller.rb") }

      it { is_expected.to exist }
      it { is_expected.to contain(/module Api::Country/) }
    end
  end

  context "with custom spec" do
    before do
      run_generator(["user", "--spec", "rswag"])
    end

    describe "rswag file" do
      subject { file("spec/docs/users_spec.rb") }

      it { is_expected.to exist }
    end
  end
end
