# rest-api-generator

This gem helps you to build a Ruby on Rails REST API, using a scaffold generator following the best practices.

## How it works?

The gems use rails generators and some templates to create all resources needed to build an REST API.

The controller is built following SwitchDreams default way:

- Using an error handler module to deal with a custom exception for centralize error handler following
  this article https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b.
- For tests, we use RSpec and FactoryBot.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'rest-api-generator'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rest-api-generator

## Requirements

1. You need to have installed in your application rspec and factory bot

<ul>
  <li>Rspec: https://github.com/rspec/rspec-rails</li>
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
$ rails g rest-api-generator:resource table_name attributes
```

This command will create:

- **Model and Migration**: Using rails default model generator
- **Controller**: A controller with index,show,create,update and destroy methods.
- **Specs for the created controller**
- **Factory bot factory for created model**
- **Routes**: with rails resources

### Example

```bash
$ rails g rest-api-generator:resource car name:string color:string
```

Will generate following controller and the other files:

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SwitchDreams/rest-api-generator. This project
is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/SwitchDreams/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rest::Api::Generator project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow
the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).
