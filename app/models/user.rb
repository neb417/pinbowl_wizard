# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  first_name              :string
#  last_name               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_organization_id :integer
#

class User < ApplicationRecord
  has_many :player_matches
  belongs_to :current_organization, class_name: "Organization", optional: true
end
