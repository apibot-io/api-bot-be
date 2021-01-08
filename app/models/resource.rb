class Resource < ApplicationRecord
  # Validation
  validates :name, presence: true, uniqueness: true

  # Association
  has_many :fields, dependent: :destroy, inverse_of: :resource
end
