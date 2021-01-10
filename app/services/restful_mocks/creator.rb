class RestfulMocks::Creator < BaseService
  def initialize(resource)
    @mocks = []
    @resource = resource
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    # API Get List
    resource_name_plural = resource.name.pluralize
    obj = build_resource_obj
    list_objs = gen_list_obj(obj)
    mocks = [
      {
        name: 'Get list',
        route_path: "/#{resource_name_plural}",
        method: "get",
        body_content: list_objs.to_json
      },
      {
        name: 'Get detail list',
        route_path: "/#{resource_name_plural}",
        method: "get",
        body_content: obj.to_json
      }
    ]
  end

  private

  def build_resource_obj
    resource_obj = {}
    @resource.fields.each do |field|
      resource_obj[field.name] = gen_fake_data(physical_type, logical_type)
    end

    resource_obj
  end

  def gen_fake_data(physical_type, logical_type)
    if logical_type
      faker_class = FAKER_CLASS_GROUPS.find { |_, v| v.include?(field.name) }.first
      faker_class.constantize.send(field.logical_type)
    else
      expression = PHYSICAL_DEFAULT_VAL_EXP[physical_type]
      eval(expression)
    end
  end

  def gen_list_obj(obj)
    20.times.inject([]) do |result, _|
      result << obj
    end
  end
end
