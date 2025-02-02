# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  season_id  :integer          not null
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rounds_on_season_id  (season_id)
#

class Round < ApplicationRecord
  belongs_to :season
end
