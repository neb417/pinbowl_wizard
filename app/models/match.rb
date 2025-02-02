# == Schema Information
#
# Table name: matches
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  machine_id :bigint           not null
#  round_id   :bigint           not null
#
# Indexes
#
#  index_matches_on_machine_id  (machine_id)
#  index_matches_on_round_id    (round_id)
#
# Foreign Keys
#
#  fk_rails_...  (machine_id => machines.id)
#  fk_rails_...  (round_id => rounds.id)
#

class Match < ApplicationRecord
  belongs_to :round
  belongs_to :machine
  has_many :player_matches
end
