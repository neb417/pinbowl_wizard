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

    matchings = match_hash(accounts.to_a)
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

  def match_hash(players, matchings ={})
    return matchings if players.empty? || players.count == 1

    player = players.shift
    matches = []
    players.each do |p|
      matches << p
    end
    matchings[player] = matches
    match_hash(players, matchings)
  end
end
