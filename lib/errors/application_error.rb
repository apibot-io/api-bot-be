class Errors::ApplicationError < StandardError
  attr_reader :message

  def initialize(message)
    error_log = Rainbow('[App Error] ').red
    error_log += "#{Rainbow('Message:').pink} #{Rainbow(message).green}"
    Rails.logger.error(error_log)
  end

  def to_hash
    { message: "Invalid Paramater!" }
  end
end
