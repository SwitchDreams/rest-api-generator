# frozen_string_literal: true

class CarsController < RestApiGenerator::ResourceController
  after_set_resource :authorize_logic
  after_set_all_resources :authorized_scope

  def authorized_scope
    # Custom authorization logic
    # @resource = authorized_scope @resource
  end

  def authorize_logic
    # Custom authorization logic
    # authorize! :manage, @resource
  end
end
