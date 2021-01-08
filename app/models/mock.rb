class Mock < ApplicationRecord
  # Validate
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :status_code, presence: true
  validates :request_method, presence: true
  validates :route_path, presence: true

  # Scope
  default_scope { order(mock_order: :asc) }
  scope :active, -> { where(active: true) }

  # Callback
  before_save :set_order
  before_save :set_content_type
  after_save :reload_routers

  # Association
  has_many :headers, dependent: :destroy, inverse_of: :mock

  protected

  def set_content_type
    self.content_type ||= 'application/json'
  end

  def set_order
    self.mock_order ||= (Mock.maximum(:mock_order) || 0) + 1
  end

  def reload_routers
    Apibot::Router.reload_routers
  end
end
