# == Schema Information
#
# Table name: seasons
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
# Indexes
#
#  index_seasons_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

class Season < ApplicationRecord
  has_many :rounds
  belongs_to :organization
  validates_presence_of :title
end
