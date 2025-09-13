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
    player_matching = build_player_matching(accounts.to_a)
    player_matching.each do |player, matching|
      build_matches(player, matching, machines.to_a)
      # machine = match_machines.shift
      # match = Match.create(machine: machine, round: round)
      # PlayerMatch.create(match: match, user: player)
      # matchings.each do |matching|
      #   PlayerMatch.create(match: match, user: matching)
      # end
    end
    binding.pry
    # players.each do |player|
    #   players.shift
    #   matchings[player] = players
    # end
    # Need to create matches between 2 players and 1 machine
    # No player should play the same player within the same round
    # No machine should host any of the same players
    # If there is an odd number of players,a 'bye' must be present
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
