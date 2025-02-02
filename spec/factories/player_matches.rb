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
FactoryBot.define do
  factory :player_match do
    association :user
    association :match
    score { Faker::Number.rand_in_range(0, 1_000) }
    result { Faker::Number.rand_in_range(0, 2) }
  end
end
