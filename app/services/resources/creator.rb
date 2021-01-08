class Resources::Creator
  def initialize(resource_params)
    @fields = resource_params['fields']
    @resource_name = resource_params['resource_name']
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    raise Errors::ApplicationError if @fields.blank?

    resource = Resource.create!(name: @resource_name)

    raise Errors::ApplicationError unless Field.valid?(@fields)

    
  end
end
