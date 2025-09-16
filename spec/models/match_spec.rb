# == Schema Information
#
# Table name: matches
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  flight_id  :bigint           not null
#  machine_id :bigint           not null
#
# Indexes
#
#  index_matches_on_flight_id   (flight_id)
#  index_matches_on_machine_id  (machine_id)
#
# Foreign Keys
#
#  fk_rails_...  (flight_id => flights.id)
#  fk_rails_...  (machine_id => machines.id)
#

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to belong_to(:flight) }
  it { is_expected.to belong_to(:machine) }
  it { is_expected.to have_many(:player_matches) }
end
