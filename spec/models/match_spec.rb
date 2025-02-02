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

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to belong_to(:round) }
  it { is_expected.to belong_to(:machine) }
  it { is_expected.to have_many(:player_matches) }
end
