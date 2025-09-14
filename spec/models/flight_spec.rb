# == Schema Information
#
# Table name: flights
#
#  id         :bigint           not null, primary key
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
require 'rails_helper'

RSpec.describe Flight, type: :model do
  it { is_expected.to belong_to(:round) }
  it { is_expected.to have_many(:matches) }
end
