class Mock < ApplicationRecord
  # Validate
  # validates :status_code, presence: true
  # validates :request_method, presence: true
  # validates :content_type, presence: true
  # validates :route_path, presence: true
  # validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Scope
  default_scope { order(mock_order: :asc) }
  scope :active, -> { where(active: true) }

  # Callback
  before_save :set_order
  before_save :set_content_type

  protected

  def set_content_type
    self.content_type ||= 'application/json'
  end

  def set_order
    self.mock_order ||= (Mock.maximum(:mock_order) || 0) + 1
  end
end
