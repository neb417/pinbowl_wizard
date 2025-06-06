# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_organizations_on_code  (code) UNIQUE
#  index_organizations_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    code { SecureRandom.hex(6) }
  end
end
