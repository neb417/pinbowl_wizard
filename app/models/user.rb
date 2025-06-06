# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email_address           :string           not null
#  first_name              :string
#  last_name               :string
#  password_digest         :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_organization_id :integer
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
class User < ApplicationRecord
  rolify
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :player_matches
  has_many :memberships
  has_many :organizations, through: :memberships
  belongs_to :current_organization, class_name: "Organization", optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
