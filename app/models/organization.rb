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
#
class Organization < ApplicationRecord
  resourcify
  has_many :seasons
  validates :code, presence: true, uniqueness: true
end
