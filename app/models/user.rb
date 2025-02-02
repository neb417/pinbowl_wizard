# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :player_matches
end
