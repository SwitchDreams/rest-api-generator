# frozen_string_literal: true

class Serializers::Ams::CarsController < RestApiGenerator::ResourceController
  def serializer(resource)
    ActiveModelSerializers::SerializableResource.new(resource, each_serializer: Ams::CarSerializer).to_json
  end
end
