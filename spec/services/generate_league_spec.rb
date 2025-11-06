require "rails_helper"

RSpec.describe GenerateLeague, type: :service do
  subject { described_class.call(season:, number_of_rounds: 5) }

  let(:organization) { create(:organization) }
  let(:season) { create(:season, organization:) }

  let(:owner) { create(:owner_user, current_organization: organization, organization:) }
  let!(:player1) { create(:account_user, current_organization: organization, organization:) }
  let!(:player2) { create(:account_user, current_organization: organization, organization:) }
  let!(:player3) { create(:account_user, current_organization: organization, organization:) }
  let!(:player4) { create(:account_user, current_organization: organization, organization:) }
  let!(:player5) { create(:account_user, current_organization: organization, organization:) }

  let!(:machine1) { create(:machine, organization:) }
  let!(:machine2) { create(:machine, organization:) }
  let!(:machine3) { create(:machine, organization:) }
  let!(:machine4) { create(:machine, organization:) }
  let!(:machine5) { create(:machine, organization:) }

  it 'creates rounds' do
    expect do
      subject
    end.to change(Round, :count)
  end

  it 'creates flights' do
    expect do
      subject
    end.to change(Flight, :count)
  end

  it 'creates matches' do
    expect do
      subject
    end.to change(Match, :count)
  end

  it 'creates player_matches' do
    expect do
      subject
    end.to change(PlayerMatch, :count)
  end
end
