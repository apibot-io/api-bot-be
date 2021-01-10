class FieldSerializer
  include JSONAPI::Serializer
  belongs_to :resource

  attributes :name, :physical_type, :logical_type, :default_value
end
