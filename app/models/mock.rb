class Mock < ApplicationRecord
  # Validate
  validates :status, presence: true
  validates :request_method, presence: true
  validates :content_type, presence: true
  validates :route_path, presence: true, route: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
end
