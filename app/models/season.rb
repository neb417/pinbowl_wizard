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

  def ordered_rounds
    rounds.order(:number)
  end

  def form_round_number
    ordered_rounds.blank? ? 1 : ordered_rounds.last.number + 1
  end
end
