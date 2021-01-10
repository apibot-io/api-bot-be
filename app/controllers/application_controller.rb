class ApplicationController < ActionController::API
  include RenderJsonapi

  def route_not_found
    render json: { "error": "Route can not found" },
           status: :not_found
  end
end
