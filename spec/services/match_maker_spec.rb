require "rails_helper"

RSpec.describe MatchMaker, type: :service do
  subject { described_class.call(round: round) }

  let(:organization) { create(:organization) }
  let(:season) { create(:season, organization:) }
  let(:round) { build(:round, season: season) }
  let(:owner) { create(:owner_user, current_organization: organization, organization:) }
  let!(:player1) { create(:account_user, current_organization: organization, organization:) }
  let!(:player2) { create(:account_user, current_organization: organization, organization:) }
  let!(:player3) { create(:account_user, current_organization: organization, organization:) }
  let!(:player4) { create(:account_user, current_organization: organization, organization:) }
  let!(:player5) { create(:account_user, current_organization: organization, organization:) }
  let!(:player6) { create(:account_user, current_organization: organization, organization:) }
  let!(:machine1) { create(:machine, organization:) }
  let!(:machine2) { create(:machine, organization:) }
  let!(:machine3) { create(:machine, organization:) }
  let!(:machine4) { create(:machine, organization:) }

  it 'does a thing' do
    subject
  end
end
