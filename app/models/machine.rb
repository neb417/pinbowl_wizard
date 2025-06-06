# == Schema Information
#
# Table name: machines
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Machine < ApplicationRecord
  has_many :matches

  validates :name, presence: true
end
