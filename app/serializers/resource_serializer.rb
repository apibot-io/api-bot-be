class ResourceSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :resource do |resource|
    FieldSerializer.new(resource.fields).as_json["data"]
  end

  has_many :fields
end
