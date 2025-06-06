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
class Organization < ApplicationRecord
  resourcify
  has_many :seasons
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def accounts
    User.with_role(:account, self)
  end

  def admins
    User.with_role(:admin, self)
  end
end
