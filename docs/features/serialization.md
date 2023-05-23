# Serialization

If you are working with [ams](https://github.com/rails-api/active_model_serializers), the serializer will work without
any extra configuration.
But if you need to customize you can override the serializer method in the controller:

```ruby
# Example with panko serializer: https://github.com/panko-serializer/panko_serializer
class CarsController < RestApiGenerator::ResourceController

  # serializer used in show, create, update.
  def serializer(resource)
    Panko::CarSerializer.new.serialize_to_json(resource)
  end

  # serializer used in index.
  def index_serializer(resources)
    Panko::ArraySerializer.new(resources, each_serializer: Panko::CarSerializer).to_json
  end
end
```

```ruby
# Example with ams
class CarsController < RestApiGenerator::ResourceController
  def serializer(resource)
    ActiveModelSerializers::SerializableResource.new(resource, each_serializer: Ams::CarSerializer).to_json
  end
end
```

The gem is tested with [panko serializer](https://github.com/panko-serializer/panko_serializer)
and [ams](https://github.com/rails-api/active_model_serializers). But should works with any serializer, feel free to add
tests for your favorite serializer.
