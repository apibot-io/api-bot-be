class Api::V0::ResourcesController < Api::V0::ApiController
  before_action :set_resource, only: [:show]

  def index
    @resources = Resource.all.includes(:fields)
    render_jsonapi @resources, include: 'fields'
  end

  def show
    render_jsonapi @resource, include: 'fields'
  end

  def create
    @resource = Resources::Creator.call(resource_params)
    if @resource
      render json: ResourceSerializer.new(@resource),
             status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def delete
    @resource.destroy
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.permit(:resource_name,
                  fields: [:name, :physical_type, :logical_type,
                           :default_value])
  end
end
