# Callbacks

You can use the callbacks in the controller to add some logic before, around or after `set_resource`
or `set_parent_resource`:

```ruby
# frozen_string_literal: true

class CarsController < RestApiGenerator::ResourceController
  after_set_resource :authorize_logic

  def authorize_logic
    # Custom authorization logic
    # authorize! :manage, @resource
  end
end
```
