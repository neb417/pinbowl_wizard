# == Schema Information
#
# Table name: seasons
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
# Indexes
#
#  index_seasons_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#

require 'rails_helper'

RSpec.describe Season, type: :model do
  it { is_expected.to have_many(:rounds) }
  it { is_expected.to belong_to(:organization) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'instance methods' do
    let(:season1) { create(:season) }
    let(:season2) { create(:season) }
    let(:season3) { create(:season) }
    let!(:round1) { create(:round, season: season1, number: 1) }
    let!(:round2) { create(:round, season: season1, number: 2) }
    let!(:round3) { create(:round, season: season1, number: 3) }
    let!(:round4) { create(:round, season: season2, number: 1) }
    let!(:round5) { create(:round, season: season2, number: 2) }
    let!(:round6) { create(:round, season: season2, number: 3) }

    describe '#ordered_rounds' do
      it { expect(season1.ordered_rounds).to eq([ round1, round2, round3 ]) }
      it { expect(season1.ordered_rounds).not_to include([ round4, round5, round6 ]) }
      it { expect(season2.ordered_rounds).to eq([ round4, round5, round6 ]) }
      it { expect(season2.ordered_rounds).not_to include([ round1, round2, round3 ]) }
    end

    describe '#form_round_number' do
      it { expect(season1.form_round_number).to eq(4) }
      it { expect(season2.form_round_number).to eq(4) }
      it { expect(season3.form_round_number).to eq(1) }
    end
  end
end
