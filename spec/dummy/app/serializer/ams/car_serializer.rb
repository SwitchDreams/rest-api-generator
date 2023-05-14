class Ams::CarSerializer < ActiveModel::Serializer
  attributes :name, :color, :ams_field

  def ams_field
    "ams_field"
  end
end
