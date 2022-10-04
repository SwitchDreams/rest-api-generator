# RestApiGenerator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rest/api/generator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

then inside your folder app/spec create a new folder called "requests", that's where your tests will be generated

## Usage
### Run command
> rails g generator table_name attributes

************************************************************************************
#### Model
this will generate a table named car with two attributes, door type integer and name type string

************************************************************************************
#### Endpoint
It will genrate a controller CarsController that has the methods

##### Create
saves instance of generated model to database and return json of instance with status ok

##### Update
updates instance of generated modelfrom database and return json of instance with status ok

##### Delete
deletes instance of generated model from database 

##### Show
returns JSON instance of generated model from database with status ok

##### Index
returns JSON instance of generated model from database with status ok
************************************************************************************
### Spec



create and update will have permitted params defined by the attributes defined in the command, in this case door and name
    
    
    



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rest-api-generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rest::Api::Generator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).
