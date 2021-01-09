class FieldSerializer
  include JSONAPI::Serializer
  attributes :name, :physical_type, :logical_type, :default_value
  belongs_to :resource
end
