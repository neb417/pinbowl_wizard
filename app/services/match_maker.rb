class MatchMaker
  include Callable

  def initialize(round:)
    self.round = round
    self.season = round.season
    self.organization = season.organization
    self.machines = organization.machines
    self.accounts = organization.accounts
  end

  def call
    # Need to make flights in the db.
    # Each round has a series of flights
    # Each flight has a series of matches
    # Each player plays 1 match in each flight.

    player_matching = build_player_matching(accounts.to_a)
    player_matching.each do |player, matching|
      build_matches(player, matching, machines.to_a)
    end
  end

  private attr_accessor :round, :season, :organization, :machines, :accounts

  def build_player_matching(players, matchings ={})
    return matchings if players.empty? || players.count == 1

    player = players.shift
    matches = []
    players.each do |p|
      matches << p
    end
    matchings[player] = matches
    build_player_matching(players, matchings)
  end

  def build_matches(player, player_matching, machines)
    return if  machines.empty? || player_matching.empty?

    machine = machines.shift
    player_match = player_matching.shift
    match = Match.create(machine: machine, round: round)
    PlayerMatch.create(match: match, user: player)
    PlayerMatch.create(match: match, user: player_match)

    build_matches(player, player_matching, machines)
  end
end
