class Api::V0::ResourcesController < Api::V0::ApiController
  def index
    render json: Resource.all
  end

  def show
    render json: @resource
  end

  def create
    @resource = Resources::Creator.call(resource_params)
    if @resource
      render json: ResourceSerializer.new(@resource).serializable_hash.to_json,
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
