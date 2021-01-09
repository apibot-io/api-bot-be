class Field < ApplicationRecord
  belongs_to :resource, inverse_of: :fields

  PHYSICAL_TYPES = {
    auto_inc_id: 0,
    uuid: 1,
    string: 2,
    number: 3,
    boolean: 4,
    object: 5,
    array: 6,
    date: 7
  }.freeze

  LOGICAL_TYPES = {
    first_name: 0,
    last_name: 1,
    full_name: 2,
    email: 3,
    address: 4,
    phone: 5
  }.freeze

  enum physical_type: PHYSICAL_TYPES
  enum logical_type: LOGICAL_TYPES

  class << self
    def physical_type_val(physical_type_str)
      return nil unless physical_type_str

      PHYSICAL_TYPES[physical_type_str.to_sym]
    end

    def logical_type_val(logical_type_str)
      return nil unless logical_type_str

      LOGICAL_TYPES[logical_type_str.to_sym]
    end

    def valid?(field_params)
      name          = field_params['name']
      physical_type = field_params['physical_type']
      logical_type  = field_params['logical_type']

      if name.nil? ||
         physical_type.nil? ||
         physical_type_val(physical_type).nil? ||
         (logical_type.present? && logical_type_val(logical_type).nil?)
        return false
      end

      true
    end
  end
end
