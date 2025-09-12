class MatchMaker
  include Callable

  def initialize(round:)
    self.round = round
    self.season = round.season
    self.organization = season.organization
    self.machines = organization.machines
    self.players = organization.accounts
  end

  def call
    # Need to create matches between 2 players and 1 machine
    # No player should play the same player within the same round
    # No machine should host any of the same players
    # If there is an odd number of players,a 'bye' must be present
  end

  private attr_accessor :round, :season, :organization, :machines, :players
end
