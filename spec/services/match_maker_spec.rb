require "rails_helper"

RSpec.describe MatchMaker, type: :service do
  subject { described_class.call(round: round, number_of_flights: 5) }

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
  let!(:player7) { create(:account_user, current_organization: organization, organization:) }
  let!(:player8) { create(:account_user, current_organization: organization, organization:) }
  let!(:player9) { create(:account_user, current_organization: organization, organization:) }
  let!(:player10) { create(:account_user, current_organization: organization, organization:) }
  let!(:player11) { create(:account_user, current_organization: organization, organization:) }
  let!(:player12) { create(:account_user, current_organization: organization, organization:) }
  let!(:machine1) { create(:machine, organization:) }
  let!(:machine2) { create(:machine, organization:) }
  let!(:machine3) { create(:machine, organization:) }
  let!(:machine4) { create(:machine, organization:) }
  let!(:machine5) { create(:machine, organization:) }
  let!(:machine6) { create(:machine, organization:) }
  let!(:machine7) { create(:machine, organization:) }
  let!(:machine8) { create(:machine, organization:) }
  let!(:machine9) { create(:machine, organization:) }
  let!(:machine10) { create(:machine, organization:) }
  let!(:machine11) { create(:machine, organization:) }
  let!(:machine12) { create(:machine, organization:) }
  let!(:machine13) { create(:machine, organization:) }
  let!(:machine14) { create(:machine, organization:) }
  let!(:machine15) { create(:machine, organization:) }

  it 'does a thing' do
    subject
  end
end
