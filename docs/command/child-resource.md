# Nested resource
In REST api sometimes we need to build a nested resource, for example when we need to get all devices from a user, for
this we have nested resource option:

```bash
# Command
rails g rest_api_generator:resource Devices name:string color:string users:references --scope Users
```

```ruby
# GET users/:user_id/devices
module Users
  class DevicesController < RestApiGenerator::ChildResourceController
  end
end
```

For this option you need to manually setup routes, for this example:

```ruby
# routes.rb
resources :users do
  resources :devices, controller: 'users/devices'
end
```


## Considerations:

- The children model needs to belongs_to parent model and parent model needs to have has_many children model