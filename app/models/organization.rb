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
  has_many :memberships
  has_many :users, through: :memberships
  has_many :machines

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true,
            format: { with: /\A[\w\-]+\z/, message: "can only contain letters, numbers, - and _" },
            length: { minimum: 4 }

  def accounts
    User.with_role(:account, self)
  end

  def owners
    User.with_role(:owner, self)
  end
end
