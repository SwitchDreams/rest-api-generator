# frozen_string_literal: true

module RestApiGenerator
  module Specs
    module Generators
      module Macros
        # Tell the generator where to put its output (what it thinks of as
        # Rails.root)
        def set_default_destination
          destination DEFAULT_DESTINATION_PATH
        end

        def setup_default_destination
          set_default_destination
          before do
            prepare_destination
            # Create routes file
            FileUtils.mkdir_p("#{DEFAULT_DESTINATION_PATH}/config")
            File.open("#{DEFAULT_DESTINATION_PATH}/config/routes.rb", "w") do |f|
              f.puts("Rails.application.routes.draw do")
              f.puts("")
              f.puts("end")
            end
          end
        end
      end

      def self.included(klass)
        klass.extend(Macros)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RestApiGenerator::Specs::Generators, type: :generator
end
