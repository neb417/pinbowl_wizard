# == Schema Information
#
# Table name: player_matches
#
#  id         :bigint           not null, primary key
#  result     :integer          default("draw")
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_player_matches_on_match_id  (match_id)
#  index_player_matches_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (user_id => users.id)
#

class PlayerMatch < ApplicationRecord
  belongs_to :user
  belongs_to :match

  enum :result, { draw: 0, win: 1, lose: 2 }, default: :draw
end
