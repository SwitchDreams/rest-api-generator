# rest-api-generator

This gem helps you to build a Ruby on Rails REST API faster, using a scaffold-like generator that follows the best
practices.

## Get started

:zap: **Quick Start**: [docs](https://rest-api-generator.switchdreams.com.br/quick-start)\
:books: **Documentation**: [docs](https://rest-api-generator.switchdreams.com.br/)

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
- [Resource serialization](#serialization)
- [Configurable](#configuration)
- [Callbacks](#callbacks)

## Next Features

- Integration with AVO
- Select fields
- User auth module

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
