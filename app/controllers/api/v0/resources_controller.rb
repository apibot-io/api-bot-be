class Api::V0::ResourcesController < Api::V0::ApiController
  def index
    render json: Resource.all
  end

  def show
    render json: @resource
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      render json: @resource, status: :created
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
    params.permit(:name)
  end
end
