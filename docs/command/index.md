# Usage

## Generate Resource

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

## Example

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

## Options

| Option | Goal                                                         | Default | Usage Example   |
|--------|--------------------------------------------------------------|---------|-----------------|
| father | Generate nested resource                                     | nil     | --father Users  |
| scope  | Scope the resource for other route or namespace organization | nil     | --scope Api::V1 |
| eject  | Eject the controller to high customization                   | false   | true            |
| spec   | Choose the spec format. Current options: "rspec" or "rswag"  | rspec   | --spec rswag    |
