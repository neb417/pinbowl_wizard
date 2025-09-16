# == Schema Information
#
# Table name: machines
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_machines_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

class Machine < ApplicationRecord
  has_many :matches
  belongs_to :organization

  validates :name, presence: true
end
