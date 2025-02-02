# == Schema Information
#
# Table name: seasons
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Season < ApplicationRecord
  has_many :rounds
  validates_presence_of :title
end
