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

FactoryBot.define do
  factory :round do
    association :season
    number { Faker::Number.number(digits: 1) }
  end
end
