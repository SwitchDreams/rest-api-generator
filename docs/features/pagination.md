# Pagination

For pagination, you need to create pagy initialializer file (pagy.rb) in the config directory of your project.
Follow [pagy's example](https://ddnexus.github.io/pagy/quick-start/) for more information.

Next, you should add some lines on top of the previously created pagy file:

```ruby
# config/initializers/pagy.rb
require "pagy"
require "pagy/extras/headers"

# If you need limit the number of items per page dynamically
require "pagy/extras/limit"
```

At last, change the pagination variable on RestApiGenerator initializer to true;

```rb
# config/initializers/rest_api_generator.rb 
config.pagination = true # default: false
```

Note, if the parent controller is changed, it is necessary to include Pagy::Backend in the new parent.

```rb
# new_parent_controller.rb 
class NewParentController < ActionController::Base
  include Pagy::Backend
end
```

## Usage

This API uses pagination in compliance with [RFC-8288](https://www.rfc-editor.org/rfc/rfc8288), which allows for clear
navigation through paginated data using response headers.

### Response Headers

The pagination details are included in the response headers, which may look like the following example:

```http
link: <https://example.com:8080/foo?page=1>; rel="first", 
      <https://example.com:8080/foo?page=2>; rel="prev", 
      <https://example.com:8080/foo?page=4>; rel="next", 
      <https://example.com:8080/foo?page=50>; rel="last"
current-page: 3
page-items: 20
total-pages: 50
total-count: 1000
```

- **`link`**: Contains URLs for navigation, indicating the first, previous, next, and last pages.
- **`current-page`**: The current page number.
- **`page-items`**: The number of items displayed per page.
- **`total-pages`**: The total number of pages available.
- **`total-count`**: The total number of items in the collection.

For additional details, refer to the [Pagy headers documentation](https://ddnexus.github.io/pagy/docs/extras/headers/).

---

### Limiting the Number of Items Per Page

> **Note:** To use the dynamic limit feature, you need to configure Pagy as per the [Pagy limit documentation](https://ddnexus.github.io/pagy/docs/extras/limit/).

You can dynamically control the number of items displayed per page by using the **limit extra** feature.

#### Example:

```http
GET /cars?limit=10
```

In the above example, the API will return up to 10 items per page.
