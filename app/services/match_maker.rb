class MatchMaker
  include Callable

  def initialize(round:, number_of_flights:)
    self.number_of_flights = number_of_flights
    self.round = round
    self.season = round.season
    self.organization = season.organization
    self.machines = organization.machines.to_a
    self.accounts = organization.accounts
    self.flights = []
    self.result = {}
    self.player_matches  = {}
  end

  def call
    build_flights
    build_player_matching(accounts.to_a)
  end

  private

  attr_accessor :round, :season, :organization, :machines,
                :accounts, :flights, :result, :player_matches, :number_of_flights

  def build_player_matching(players, matchings = {})
    return matchings if players.empty? || players.count == 1

    player = players.shift

    matches = []
    players.each do |p|
      matches << p
      build_matches(player, p)
    end
    matchings[player] = matches

    if players.count % 2 == 0
      build_player_matching(players, matchings)
    else
      build_player_matching(players.reverse, matchings)
    end
  end

  def build_flights
    number_of_flights.times do
      last_flight = Flight.where(round: round)&.order(:number)&.last
      flight = last_flight.present? ? Flight.create(round: round, number: last_flight.number + 1) : Flight.create(round: round)
      flights << flight
    end
  end

  def build_matches(player, player_match)
    flights.each_with_index do |flight|
      next if player_matches[player.id].present? && player_matches.dig(player.id, :flights).include?(flight.id)
      return if are_players_already_matched?(player, player_match)

      next if player.matches.where(flight_id: flight.id).present? ||
        player_match.matches.where(flight_id: flight.id).present? ||
        are_players_already_matched?(player, player_match)

      match = machines.each do |machine|
        next if Match.find_by(flight: flight, machine: machine).present?

        break Match.create!(machine: machine, flight: flight)
      end

      PlayerMatch.create(match: match, user: player)
      PlayerMatch.create(match: match, user: player_match)

      build_player_match_hash(player, player_match, flight)
      result[flight.id] = [] if result[flight.id].nil?
      result[flight.id] << {  'match': {  'id': match.id, 'machine': match.machine_id,  'player_1': player.id, 'player_2': player_match.id } }
    end
  end

  def are_players_already_matched?(player, player_match)
    return unless player_matches[player.id].present? && player_matches[player_match.id].present?

    player_matches.dig(player.id, :matched).include?(player_match.id) ||
      player_matches.dig(player_match.id, :matched).include?(player.id)
  end

  def build_player_match_hash(player, player_match, flight)
    build_hash_for_player(player, player_match, flight)
    build_hash_for_player(player_match, player, flight)
  end

  def build_hash_for_player(player, player_match, flight)
    if player_matches[player.id].present?
      player_matches[player.id][:flights] << flight.id
      player_matches[player.id][:matched] << player_match.id
    else
      player_matches[player.id] = { flights: [ flight.id ], matched: [ player_match.id ] }
    end
  end

  # def match_query
  #   Not used
  #   Match.
  #     joins(:player_matches, :flight).
  #     where(player_matches: { user_id: [ player.id, player_match.id ] }).
  #     where(flights: { round_id: round.id }).
  #     group('matches.id').
  #     having('COUNT(DISTINCT player_matches.user_id) = 2').
  #     exists?
  # end
end
