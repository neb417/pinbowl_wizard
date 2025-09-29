class GenerateLeague
  include Callable

  def initialize(season:, number_of_rounds:, number_of_flights:)
    @season = season
    @number_of_rounds = number_of_rounds
    @number_of_flights = number_of_flights
    self.machines = @season.organization.machines.to_a
    self.rounds = []
    self.flights = []
    # self.players = @season.organization.accounts.to_a
    self.accounts = @season.organization.accounts
    self.player_matching = {}
    self.season_setup = { @season.id => { rounds: [], flights: [] } }
    self.result = {}
    self.final_result = { rounds: {} }
  end

  def call
    build_rounds
    build_flights
    build_the_thang
  end

  private

  attr_accessor :rounds, :flights, :player_matching, :season_setup, :result, :machines, :accounts, :final_result

  def build_rounds
    round_number = 1
    @number_of_rounds.times do
      round = Round.create(season: @season, number: round_number)
      season_setup[@season.id][:rounds] << round
      final_result[:rounds][round.id] = { flights: {} }
      round_number += 1
    end
  end

  def build_flights
    season_setup.dig(@season.id, :rounds) .each do |round|
      flight_number = 1
      @number_of_flights.times do
        flight = Flight.create!(round: round, number: flight_number)
        season_setup[@season.id][:flights] << flight
        final_result[:rounds][round.id][:flights][flight.id] = { matches: {} }
        flight_number += 1
      end
    end
  end

  def build_the_thang
    season_setup.dig(@season.id, :rounds).each do |round|
      players = accounts.to_a
      build_player_matching(round, players)
    end
  end

  def build_player_matching(round, players, matchings = {})
    return matchings if players.empty? || players.count == 1

    player = players.shift

    matches = []
    players.each do |p|
      matches << p
      build_matches(round, player, p)
    end
    matchings[player] = matches

    if players.count % 2 == 0
      build_player_matching(round, players, matchings)
    else
      build_player_matching(round, players.reverse, matchings)
    end
  end

  def build_matches(round, player, player_match)
    round.flights.each do |flight|
      next if player_matching[player.id].present? && player_matching.dig(player.id, :flights).include?(flight.id)
      return if are_players_already_matched?(player, player_match)

      next if player.matches.where(flight_id: flight.id).present? ||
        player_match.matches.where(flight_id: flight.id).present? ||
        are_players_already_matched?(player, player_match)

      match = machines.each do |machine|
        next if Match.find_by(flight: flight, machine: machine).present?

        break Match.create!(machine: machine, flight: flight)
      end

      player_1_match = PlayerMatch.create(match: match, user: player)
      player_2_match = PlayerMatch.create(match: match, user: player_match)

      # result_flight = final_result[:rounds][flight.round_id][:flights].find { |f| f[:id] = flight.id }
      result_flight = final_result[:rounds][flight.round_id][:flights][flight.id]
      result_flight[:matches][match.id] = { match.id => { machine_id: match.machine_id, player_match_1_id: player_1_match.id, player_2_match_id: player_2_match.id } }

      build_player_match_hash(player, player_match, flight)
      result[flight.id] = [] if result[flight.id].nil?
      result[flight.id] << {  'match': {  'id': match.id, 'machine': match.machine_id,  'player_1': player.id, 'player_2': player_match.id } }
    end
  end

  def build_player_match_hash(player, player_match, flight)
    build_hash_for_player(player, player_match, flight)
    build_hash_for_player(player_match, player, flight)
  end

  def build_hash_for_player(player, player_match, flight)
    if player_matching[player.id].present?
      player_matching[player.id][:flights] << flight.id
      player_matching[player.id][:matched] << player_match.id
    else
      player_matching[player.id] = { flights: [ flight.id ], matched: [ player_match.id ] }
    end
  end

  def are_players_already_matched?(player, player_match)
    return unless player_matching[player.id].present? && player_matching[player_match.id].present?

    player_matching.dig(player.id, :matched).include?(player_match.id) ||
      player_matching.dig(player_match.id, :matched).include?(player.id)
  end

  def final_hash
    {
      rounds: [ {
        round.id =>  {
          flights: [ {
            flight.id => {
              matches: [ {
                id: match.id,
                machine_id: match.machine_id,
                player_1_id: player_match_1.player,
                player_2_id: player_match_2.player
              } ]
            }
          } ]
        }
      } ]
    }
  end

  # def build_player_matches
  #   player = players.shift
  #   player_matching[player.id] = []
  #   build_matches_for_player(player, players)
  # end

  #   # def build_matches_for_player(player, player_matches)
  #   #   return if player_matches.empty?
  #   #
  #   #   player_matches.each do |player_match|
  #   #     player_matching[player.id] << player_match.id
  #   #     player_matching[player_match.id] = [] unless player_matching[player_match.id].present?
  #   #     player_matching[player_match.id] << player.id
  #   #   end
  #   #
  #   #   build_matches_for_player(player_matches.shift, player_matches)
  #   # end
end
