# rest-api-generator

This gem helps you to build a Ruby on Rails REST API faster, using a scaffold-like generator that follows the best
practices.

## How it works?

The gems use vanilla Rails generators in combination with our templates to create all the resources needed to build a
REST API.

Following [Switch Dreams's](https://www.switchdreams.com.br/]) coding practices, the controllers are built with:

- We use an error module to centralize error handling, rescuing from a custom and some of ActiveRecord exceptions.
  The inspiration for this strategy was
  this [article](https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b.)

- For tests, we use RSpec and FactoryBot.

## Current Features

- [Automatic rest api crud generation](#example)
- [Nested Resource](#nested-resource)
- :goal_net: [Modular error handler](#modular-error-handler)
- :memo: [Automated documentation](#specsdocs)
- [Resource ordering](#ordering)
- [Resource filter](#filtering)
- [Resource pagination](#pagination)
- [Configurable](#configuration)

## Next Features

- Serialization https://github.com/SwitchDreams/rest-api-generator/issues/14
  https://github.com/SwitchDreams/rest-api-generator/issues/11
- Pagination https://github.com/SwitchDreams/rest-api-generator/issues/15
- Integration with AVO
- Select fields
- User auth module

## Installation

Add this line to your application's Gemfile:

```ruby
# Build a Ruby on Rails REST API faster
gem 'rest-api-generator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rest-api-generator

## Requirements

1. You need to have installed RSpec and FactoryBot in your application.

<ul>
  <li>RSpec: https://github.com/rspec/rspec-rails</li>
  <li>Factory bot: https://github.com/thoughtbot/factory_bot_rails</li>
</ul>

2. Include in ApplicationController the error handler module:

```ruby

class ApplicationController < ActionController::API
  include RestApiGenerator::ErrorHandler
end
```

This error handler will rescue from: `ActiveRecord::RecordNotFound`
, `ActiveRecord::ActiveRecordError`, `ActiveRecord::RecordInvalid`, `ActiveModel::ValidationError`
, `RestApiGenerator::CustomError`.

## Usage

### Generate Resource

```bash
$ rails g rest_api_generator:resource table_name attributes
```

This command will create:

- **Model and Migration**: Using rails default model generator
- **Controller**: A controller that implementes CRUD by inheritance of `RestApiGenerator::ResourceController`, or you
  can use eject option for create a controller
  that implements index, show, create, update and destroy methods.
- **Specs for the created controller**
- **Factory bot factory for created model**
- **Routes**: with rails resources

### Example

```bash
$ rails g rest_api_generator:resource car name:string color:string
```

Will generate following controller and the other files:

```ruby
# app/controllers/cars_controller.rb
class CarsController < RestApiGenerator::ResourceController
end
```

For a better experience you can override some methods from the
[default controller](https://github.com/SwitchDreams/rest-api-generator/blob/main/lib/rest_api_generator/resource_controller.rb)

### Options

| Option | Goal                                                         | Default | Usage Example   |
|--------|--------------------------------------------------------------|---------|-----------------|
| father | Generate nested resource                                     | nil     | --father Users  |
| scope  | Scope the resource for other route or namespace organization | nil     | --scope Api::V1 |
| eject  | Eject the controller to high customization                   | false   | true            |
| spec   | Choose the spec format. Current options: "rspec" or "rswag"  | rspec   | --spec rswag    |

#### Scope

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

#### Nested resource

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

Considerations:

- The children model needs to belongs_to parent model and parent model needs to have has_many children model

#### Eject

Or you can use the `eject` option for create the controller with the implemented methods:

```bash
rails g rest_api_generator:resource car name:string color:string --eject true
```

```ruby

class CarsController < ApplicationController
  before_action :set_car, only: %i[show update destroy]

  def index
    @car = Car.all
    render json: @car, status: :ok
  end

  def show
    render json: @car, status: :ok
  end

  def create
    @car = Car.create!(car_params)
    render json: @car, status: :created
  end

  def update
    @car = Car.update!(car_params)
    render json: @car, status: :ok
  end

  def destroy
    @car.destroy!
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :color)
  end
end
```

#### Specs/Docs

The default generated spec for this gem is using plain rspec, but you can choose rswag, for scaffold you specs and docs
at the same time:

For this you need to setup https://github.com/rswag/rswag and you the following flag when generating resources.

```shell
rails g rest_api_generator:resource Car name:string color:string --spec rswag
```

This spec options work as generators too, so you can call them individually:

```shell
# rest_api_generator:spec:rswag or rest_api_generator:spec:rspec
rails g rest_api_generator:spec:rswag Car name:string color:string
```

#### Configuration for specs

By default, the plain rspec and rswag specs are going to be generated in the _spec/requests_ and _spec/docs_
directories, respectively. You can override using the (config options)[#configuration]]. :


### Resource Features

#### Modular Error Handler

The error module will return a json in this following format when any active record or custom error raises.

```json
{
  "status": 422,
  "error": "",
  "message": ""
}
```

This is good to padronize the error handler in front-end too.

#### Ordering

For ordering use this format:

- Ordering asc: `GET /cars?sort=+name or GET /cars?sort=name`
- Ordering desc: `GET /card?sort=-name`

By default, every resource column can be the key for ordering.

#### Filtering

For filter is needed to add some scopes in Model file, example:

```ruby
# app/models/car.rb

class Car < ApplicationRecord
  include RestApiGenerator::Filterable

  filter_scope :filter_by_color, ->(color) { where(color: color) }
  filter_scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") }
end
```

And It's done, you can filter your index end-point:

- `GET /cars?color=blue or GET /cars?color=red&name=Ferrari`

### Pagination

For pagination, you need to create pagy initialializer file (pagy.rb) in the config directory of your project. Follow [pagy's example](https://ddnexus.github.io/pagy/quick-start/) for more information.

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

## Configuration

You can override this gem configuration using the initializer or any other method from [anyway_config](https://github.com/palkan/anyway_config):

```rb
# config/initializers/rest_api_generator.rb 

RestApiGenerator.configure do |config|
  config.test_path = "custom_test_dir/requests" # default: spec/requests
  config.docs_path = "custom_docs_dir/rswag" # default: spec/docs
  config.parent_class = "ApplicationController" # default: RestApiGenerator::ResourceController
  config.pagination = true # default: false
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SwitchDreams/rest-api-generator. This project
is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/SwitchDreams/rest-api-generator/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
