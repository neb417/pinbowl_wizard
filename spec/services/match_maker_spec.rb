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
  let!(:machine1) { create(:machine, organization:) }
  let!(:machine2) { create(:machine, organization:) }
  let!(:machine3) { create(:machine, organization:) }
  let!(:machine4) { create(:machine, organization:) }

  it 'creates flights' do
    expect do
      subject
    end.to change(Flight, :count).from(0).to(5)
  end

  it 'creates matches' do
    expect do
      subject
    end.to change(Match, :count).from(0).to(13)
  end

  it 'creates player matches' do
    expect do
      subject
    end.to change(PlayerMatch, :count).from(0).to(26)
  end

  it 'assigns last_flight as nil when no flights exist for the round' do
    expect(Flight.where(round: round).order(:number).last).to be_nil
    described_class.call(round: round, number_of_flights: 1)
    expect(Flight.where(round: round).count).to eq(1)
  end

  it 'assigns last_flight to the last flight when flights exist for the round' do
    existing_flight = Flight.create!(round: round, number: 1)
    expect(Flight.where(round: round).order(:number).last).to eq(existing_flight)
    described_class.call(round: round, number_of_flights: 1)
    expect(Flight.where(round: round).count).to eq(2)
  end

  it 'does not create a match if players are already matched' do
    round.save!
    flight = FactoryBot.create(:flight)
    machine = FactoryBot.create(:machine, organization: organization)
    match = FactoryBot.create(:match, flight: flight, machine: machine)
    PlayerMatch.create!(match: match, user: player1)
    PlayerMatch.create!(match: match, user: player2)

    expect {
      described_class.call(round: round, number_of_flights: 1)
    }.not_to change { Match.where(flight: flight, machine: machine).count }
  end
end
