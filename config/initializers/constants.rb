FAKER_CLASS_GROUPS = {
  "Faker::Name" => %w[
    first_name
    last_name
    name
  ],
  "Faker::Internet" => %w[
    email
  ],
  "Faker::Address" => %w[
    full_address
  ]
}.freeze

PHYSICAL_DEFAULT_VAL_EXP = {
  uuid: "SecureRandom.uuid",
  string: "Faker::Name.name",
  number: "rand(1000)",
  boolean: "[true, false].sample",
  object: "{}",
  array: "[]",
  date: "Date.today.strftime('%FT')"
}.freeze
