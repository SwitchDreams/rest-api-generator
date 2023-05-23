# Configuration

You can override this gem configuration using the initializer or any other method
from [anyway_config](https://github.com/palkan/anyway_config):

```rb
# config/initializers/rest_api_generator.rb 

RestApiGenerator.configure do |config|
  config.test_path = "custom_test_dir/requests" # default: spec/requests
  config.docs_path = "custom_docs_dir/rswag" # default: spec/docs
  config.parent_class = "ApplicationController" # default: RestApiGenerator::ResourceController
  config.pagination = true # default: false
end
```
