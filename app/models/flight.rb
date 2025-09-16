# == Schema Information
#
# Table name: flights
#
#  id         :bigint           not null, primary key
#  number     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  round_id   :bigint           not null
#
# Indexes
#
#  index_flights_on_round_id  (round_id)
#
# Foreign Keys
#
#  fk_rails_...  (round_id => rounds.id)
#
class Flight < ApplicationRecord
  belongs_to :round
  has_many :matches
end
