# RestApiGenerator

This gem works as a scaffold to generate an endpoint, it generates:

<ul>
    <li> Model </li>
    <li> Migration </li>
    <li> Routes (resource) </li>
    <li> Controller </li>
    <li> Spec test of controller </li>
    <li> Factory bot </li>
</ul>

the commnad its simmilar to the model generator "rails g model model_name attributes", in fact it invokes this generator to genrate the model and migration file

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
   $ rails g generator table_name attributes

************************************************************************************
#### Model
this will generate a table and a migration with the table name and it's attribute, it invokes the model generator

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


create and update will have permitted params defined by the attributes defined in the command (except if the attribute is type reference)
************************************************************************************
### Spec

##### Create
checks if instance was saved in database

##### Update
checks if instance was updated in database ok

##### Delete
checks if instance was deleted from database

##### Show
check if status ok

##### Index
check if status ok 

************************************************************************************
### Factory
The factory will be generated with it's custom generator, defined in the instalation of the factory-bot

************************************************************************************
### Routes
the routes generated are the basic resources routes:
    table_name: resources

************************************************************************************
### Scope
It's possible to add flag in the command to generate an endpoint with a parent
   $ rails g generator table_name attributes --scope father_name

the only thing this won't genrate it's the nested routes, but it will generate all the previous files mentioned just liek a scaffold

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rest-api-generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rest::Api::Generator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rest-api-generator/blob/master/CODE_OF_CONDUCT.md).
