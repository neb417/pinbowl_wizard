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

require 'rails_helper'

RSpec.describe Round, type: :model do
  it { is_expected.to belong_to(:season) }
  it { is_expected.to have_many(:flights) }

  context "validations" do
    it { is_expected.to validate_presence_of(:number) }
  end
end
