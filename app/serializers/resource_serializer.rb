class ResourceSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  # attribute :fields do |resource|
  #   FieldSerializer.new(resource.fields).as_json["data"]
  # end

  has_many :fields, serializer: FieldSerializer
end
