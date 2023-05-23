# Pagination

For pagination, you need to create pagy initialializer file (pagy.rb) in the config directory of your project.
Follow [pagy's example](https://ddnexus.github.io/pagy/quick-start/) for more information.

Next, you should add some lines on top of the previously created pagy file:

```ruby
# config/initializers/pagy.rb
require "pagy"
require "pagy/extras/headers"
```

At last, change the pagination variable on RestApiGenerator initializer to true;

```rb
# config/initializers/rest_api_generator.rb 
config.pagination = true # default: false
```

Note, if the parent controller is changed, it is necessary to include Pagy::Backend in the new parent.

```rb
# new_parent_controller.rb 
class NewParentController < ActionController::Base
  include Pagy::Backend
end
```