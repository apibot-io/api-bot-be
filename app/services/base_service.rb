class BaseService
  protected

  def raise_app_error(msg)
    raise Errors::ApplicationError.new(msg)
  end
end
