class Panko::CarSerializer < Panko::Serializer
  attributes :name, :color, :panko_field

  def panko_field
    "panko_field"
  end
end
