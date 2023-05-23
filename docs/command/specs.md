# Specs/Docs

This lib automatic generate rspec specs for your controller. In this section you will find how to use it.

The default generated spec for this gem is using plain rspec, but you can choose rswag, for scaffold you specs and docs
at the same time:

For this you need to setup https://github.com/rswag/rswag and you the following flag when generating resources.

```shell
rails g rest_api_generator:resource Car name:string color:string --spec rswag
```

## Specific generator

We have a specific generator for specs, you can use it for generate specs for a specific controller, example:

```shell
# rest_api_generator:spec:rswag or rest_api_generator:spec:rspec
rails g rest_api_generator:spec:rswag Car name:string color:string
```

## Customization

You can customize the output folder using config file, example:

```ruby
# config/initializers/rest_api_generator.rb 

RestApiGenerator.configure do |config|
  config.test_path = "custom_test_dir/requests" # default: spec/requests
  config.docs_path = "custom_docs_dir/rswag" # default: spec/docs
end
```