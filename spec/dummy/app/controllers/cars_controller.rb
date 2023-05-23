# frozen_string_literal: true

class CarsController < RestApiGenerator::ResourceController
  after_set_resource :authorize_logic

  def authorize_logic
    # Custom authorization logic
    # authorize! :manage, @resource
  end
end
