# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  machine_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_matches_on_machine_id  (machine_id)
#  index_matches_on_round_id    (round_id)
#

class Match < ApplicationRecord
  belongs_to :round
  belongs_to :machine
end
