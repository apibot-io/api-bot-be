class Resources::Creator < BaseService
  def initialize(resource_params)
    @fields        = resource_params['fields']
    @resource_name = resource_params['resource_name']
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    raise_app_error("Resource fields can't be blank") if @fields.blank?

    Resource.transaction do
      resource    = Resource.create!(name: @resource_name)
      field_attrs = build_field_attrs(resource.id)
      Field.import(field_attrs, validate: false)
      resource
    end
  end

  private

  def build_field_attrs(resource_id)
    @fields.inject([]) do |result, item|
      raise_app_error("Resource fields are invalid") unless Field.valid?(item)

      result << {
        name: item['name'],
        physical_type: Field.physical_type_val(item['physical_type']),
        logical_type: Field.logical_type_val(item['logical_type']),
        default_value: item['default_value'],
        resource_id: resource_id
      }
    end
  end
end
