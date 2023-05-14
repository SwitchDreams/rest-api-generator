# frozen_string_literal: true

class Serializers::Panko::CarsController < RestApiGenerator::ResourceController

  def serializer(resource)
    Panko::CarSerializer.new.serialize_to_json(resource)
  end

  def index_serializer(resources)
    Panko::ArraySerializer.new(resources, each_serializer: Panko::CarSerializer).to_json
  end
end
