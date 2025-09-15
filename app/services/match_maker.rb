class MatchMaker
  include Callable

  def initialize(round:)
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
    # Need to make flights in the db.
    # Each round has a series of flights
    # Each flight has a series of matches
    # Each player plays 1 match in each flight.
    accounts.size.times do
      build_flight
    end
    player_matching = build_player_matching(accounts.to_a)
    binding.pry
    # player_matching.each do |player, matching|
    #   build_matches(player, matching, machines.to_a)
    # end
  end

  private attr_accessor :round, :season, :organization, :machines, :accounts, :flights, :result, :player_matches

  def build_player_matching(players, matchings ={})
    return matchings if players.empty? || players.count == 1

    player = players.shift
    matching_count = matchings[player].present? ? matchings[player].size : 0

    matches = []
    players.each do |p|
      matches << p
      # build_flight if (players.count + matching_count + 1) == accounts.size
      build_matches(player, p)
    end
    matchings[player] = matches
    # flights.shift
    # machines.shift
    if player.id % 2 == 0
      build_player_matching(players, matchings)
    else
      build_player_matching(players.reverse, matchings)
    end
    # build_player_matching(players, matchings)
  end

  def build_flight
    last_flight = Flight.where(round: round)&.order(:number)&.last
    flight = last_flight.present? ? Flight.create(round: round, number: last_flight.number + 1) : Flight.create(round: round)
    flights << flight
  end

  def build_matches(player, player_match)
    flights.each_with_index do |flight|
      next if player_matches[player.id].present? && player_matches.dig(player.id, :flights).include?(flight.id)
      return if are_players_already_matched?(player, player_match)
      # binding.pry if player.id == 3

      # build_flight if Flight.where(id: flights.pluck(:id)).where.not(id: [ player_matches[player_match.id][:flights], player_matches[player.id][:flights] ].flatten).empty?

      next if player.matches.where(flight_id: flight.id).present? ||
        player_match.matches.where(flight_id: flight.id).present? ||
        are_players_already_matched?(player, player_match)

      match = machines.each do |machine|
        next if Match.find_by(flight: flight, machine: machine).present?

        break Match.create!(machine: machine, flight: flight)
      end

      PlayerMatch.create(match: match, user: player)
      PlayerMatch.create(match: match, user: player_match)
      # player_matches[player.id].present?  ? player_matches[player.id] << player_match.id  : player_matches[player.id] = [ player_match.id ]
      # player_matches[player_match.id].present?  ? player_matches[player_match.id] << player.id  : player_matches[player_match.id] = [ player.id ]
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

  # def build_matches(player, player_match, machines)
  #   return if  machines.empty? || player_match.nil?
  #
  #   machine = machines.shift
  #   match = Match.create(machine: machine, flight: flights[index])
  #   PlayerMatch.create(match: match, user: player)
  #   PlayerMatch.create(match: match, user: player_match)
  #
  #   build_matches(player, player_matching, machines)
  # end
  def match_query
    Match.
      joins(:player_matches, :flight).
      where(player_matches: { user_id: [ player.id, player_match.id ] }).
      where(flights: { round_id: round.id }).
      group('matches.id').
      having('COUNT(DISTINCT player_matches.user_id) = 2').
      exists?
  end
end
