# config = RestApiGenerator::Config.new
# config.test_path = "/test/requests"
# config.docs_path = "/docs/specs"

RestApiGenerator.configure do |config|
  config.test_path = "custom_test/requests"
  config.docs_path = "custom_docs/rswag"
end
