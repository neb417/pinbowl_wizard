# == Schema Information
#
# Table name: rounds
#
#  id         :bigint           not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#
# Indexes
#
#  index_rounds_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#

class Round < ApplicationRecord
  belongs_to :season
  has_many :flights

  scope :last_round_for_season, ->(season_id)  { where(season: season_id).order(:number).last }

  validates :number, presence: true
end
