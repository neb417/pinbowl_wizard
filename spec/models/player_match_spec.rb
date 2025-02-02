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

require 'rails_helper'

RSpec.describe PlayerMatch, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:user) }

  context "defaults with a draw result" do
    it { expect(described_class.new.result).to eq("draw") }
  end
end
