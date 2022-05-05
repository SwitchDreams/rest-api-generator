module RestApiGenerator
  module Helpers
    class Render
      def self.json(error, status, message)
        {
          status:,
          error:,
          message:
        }.as_json
      end
    end
  end
end