class Api::V0::ApiController < ApplicationController
  rescue_from Errors::ApplicationError, with: :render_runtime_error_response

  protected

  def render_runtime_error_response(exception)
    render json: exception.to_hash,
           status: :bad_request
  end
end
