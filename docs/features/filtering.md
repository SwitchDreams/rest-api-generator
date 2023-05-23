# Filtering

For filter is needed to add some scopes in Model file, example:

```ruby
# app/models/car.rb

class Car < ApplicationRecord
  include RestApiGenerator::Filterable

  filter_scope :filter_by_color, ->(color) { where(color: color) }
  filter_scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") }
end
```

And It's done, you can filter your index end-point:

- `GET /cars?color=blue or GET /cars?color=red&name=Ferrari`
