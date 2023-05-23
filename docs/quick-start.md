# Quick start

## Requirements

1. If you want to get full advantage for this gem you need to have installed RSpec and FactoryBot in your application.

<ul>
  <li>RSpec: https://github.com/rspec/rspec-rails</li>
  <li>Factory bot: https://github.com/thoughtbot/factory_bot_rails</li>
</ul>

## Installation

```ruby
# Build a Ruby on Rails REST API faster
gem "rest-api-generator"
```

And then execute:

` bundle install`

2. Include in `ApplicationController` the error handler module:

```ruby

class ApplicationController < ActionController::API
  include RestApiGenerator::ErrorHandler
end
```

3. Create a resource using following command:

`rails g rest_api_generator:resource <resource_name> <attributes>`

Example:

`rails g rest_api_generator:resource car name:string color:string`