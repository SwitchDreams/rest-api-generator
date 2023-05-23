# Scope

In REST api one of the best practices is versioning the end-points, and you can achieve this using scope options,
example:

```bash
# Command
rails g rest_api_generator:resource car name:string color:string --scope Api::V1
```

```ruby
# GET api/v1/cars
module Api::V1
  class CarsController < RestApiGenerator::ResourceController
  end
end
```

For this option you need to manually setup routes, for this example:

```ruby
# routes.rb
namespace :api do
  namespace :v1 do
    resources :cars
  end
end
```