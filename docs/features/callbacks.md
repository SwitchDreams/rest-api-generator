# Callbacks

You can use the callbacks in the controller to add some logic before, around or after `set_resource`
, `set_parent_resource` or `set_all_resources`:

- The `set_resource` method is called in [:show, :update, :destroy] actions
- The `set_parent_resource` method is called in all actions if you are using nested resources
- The `set_all_resources` method is called in [:index] actions

```ruby
# frozen_string_literal: true

class CarsController < RestApiGenerator::ResourceController
  after_set_resource :authorize_logic
  set_all_resources -> { @resources = authorized_resource(@resources) }

  def authorize_logic
    # Custom authorization logic
    # authorize! :manage, @resource
  end
end
```
