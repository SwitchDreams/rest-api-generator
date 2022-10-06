# Rest Api Generator

This gem helps your to build a Ruby on Rails REST api, using a scaffold generator following the best pratices.

## How it works?

We use SwitchDreams default way to make controller using RSpec and FactoryBot for testing and use a custom expection to centralize error handle like this article https://medium.com/rails-ember-beyond/error-handling-in-rails-the-modular-way-9afcddd2fe1b

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rest-api-generator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rest-api-generator

## Requirements
You need to have installed in your application rspec and factory bot

<ul>
  <li>Rspec: https://github.com/rspec/rspec-rails</li>
  <li>Factory bot: https://github.com/thoughtbot/factory_bot_rails</li>
</ul>

## Usage
### Generate Resource
```bash
$ rails g rest-api-generator-resource table_name attributes
```
This command will create:
- **Model and Migration**: Using rails default model generator
- **Controller**: A controller with index,show,create,update and destroy methods.
- **Specs for the created controller**
- **Factory bot factory for created model**
- **Routes**: with rails resources

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SwitchDreams/rest-api-generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SwitchDreams/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rest::Api::Generator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).
