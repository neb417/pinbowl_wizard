require 'rails_helper'

RSpec.describe CalculateMatchResults, type: :service do
  include CalculatePlayerMatchesHelper

  let(:organization) { create(:organization) }
  let(:season) { create(:season, organization:) }
  let(:machine) { create(:machine, organization:) }
  let(:match) { create(:match, machine:) }
  let(:player1) { create(:account_user, current_organization: organization, organization:) }
  let(:player2) { create(:account_user, current_organization: organization, organization:) }
  let(:player_match_1) { create(:player_match, user: player1, match:) }
  let(:player_match_2) { create(:player_match, user: player2, match:) }

  it 'is a draw' do
    player_match_1 = create(:player_match, user: player1, match:, score: 100)
    player_match_2 = create(:player_match, user: player2, match:, score: 100)
    player_matches = formatted_params(player_match_1, player_match_2)

    described_class.call(player_matches: player_matches)

    player_match_1.reload
    player_match_2.reload

    expect(player_match_1.result).to eq('draw')
    expect(player_match_2.result).to eq('draw')
  end

  it 'player_1 wins, player_2 loses' do
    player_match_1 = create(:player_match, user: player1, match:, score: 200)
    player_match_2 = create(:player_match, user: player2, match:, score: 100)
    player_matches = formatted_params(player_match_1, player_match_2)

    described_class.call(player_matches: player_matches)

    player_match_1.reload
    player_match_2.reload

    expect(player_match_1.result).to eq('win')
    expect(player_match_2.result).to eq('lose')
  end

  it 'player_1 loses, player_2 wins' do
    player_match_1 = create(:player_match, user: player1, match:, score: 100)
    player_match_2 = create(:player_match, user: player2, match:, score: 200)
    player_matches = formatted_params(player_match_1, player_match_2)

    described_class.call(player_matches: player_matches)

    player_match_1.reload
    player_match_2.reload

    expect(player_match_1.result).to eq('lose')
    expect(player_match_2.result).to eq('win')
  end
end
