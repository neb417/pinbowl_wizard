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

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to belong_to(:round) }
  it { is_expected.to belong_to(:machine) }
end
