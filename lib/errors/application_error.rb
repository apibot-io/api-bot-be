class Errors::ApplicationError < StandardError
  attr_reader :message

  def initialize(message: nil)
    @message = message || 'Invalid Paramater!'
  end

  def to_hash
    { message: message }
  end
end
