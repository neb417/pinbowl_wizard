# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Season < ApplicationRecord
  validates_presence_of :title
end
