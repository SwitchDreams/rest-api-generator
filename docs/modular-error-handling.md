# Modular Error Handler

The goal of this module is to provide a modular error handler for your application. This module will rescue
from some default errors and return a json with the following format:

```json
{
  "status": 422,
  "error": "",
  "message": ""
}
```

This errors will be rescue`ActiveRecord::RecordNotFound`
, `ActiveRecord::ActiveRecordError`, `ActiveRecord::RecordInvalid`, `ActiveModel::ValidationError`
, `RestApiGenerator::CustomError`

## Setup

Include in your `ApplicationController` the following module:

```ruby

class ApplicationController < ActionController::API
  include RestApiGenerator::ErrorHandler
end
```

## Advantages for using this pattern

- easier to maintain
- easier to code controller
- easier to handle in frontend

