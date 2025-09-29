class GenerateLeague
  include Callable

  # def initialize(season:, number_of_rounds:, number_of_flights:)
  def initialize(season:, number_of_rounds:)
    @season = season
    @number_of_rounds = number_of_rounds
    self.machines = @season.organization.machines
    self.accounts = @season.organization.accounts
    self.player_ids = @season.organization.accounts.pluck(:id)
    self.number_of_flights= number_of_flights
    self.machine_ids = machines.pluck(:id).to_a
    self.evens = []
    self.odds = []
    self.result = {}
    self.player_match_ups = {}
  end

  def call
    build_player_match_up_hash
    split_players_into_groups
    create_season(odds, evens)
    result.each do |round, _value|
      result[round] = create_flights(odds.dup.shuffle, evens.dup.shuffle)
    end
    binding.pry
  end

  private

  attr_accessor :result, :machines, :accounts, :player_ids, :machine_ids, :player_match_ups, :evens, :odds, :number_of_flights

  def split_players_into_groups
    player_ids.each_with_index do |id, index|
      index % 2 == 0 ? evens << id : odds << id
    end
  end

  def create_season(group_1, group_2, round_number = 1)
    return if round_number > @number_of_rounds

    result["round_#{round_number}"] = create_flights(group_1.clone, group_2.clone)
    if round_number % 2 == 0
      create_season(group_1.clone, group_2.clone, round_number + 1)
    else
      create_season(group_1.reverse.clone, group_2.reverse.clone, round_number + 1)
    end
  end

  def create_flights(group_1, group_2, flight_number = 1, player_matching = {}, arenas = machine_ids.shuffle[0..group_1.count - 1])
    return player_matching if flight_number > number_of_flights

    player_matching["flight_#{flight_number}"] = []
    group_1.each_with_index do |player, index|
      arena = arenas.shift
      player_match_ups[player][:opponents][group_2[index]] += 1
      player_match_ups[group_2[index]][:opponents][player] += 1
      player_match_ups[player][:arenas][arena] += 1
      player_match_ups[group_2[index]][:arenas][arena] += 1

      match = { "arena_#{arena}" => [ player, group_2[index] ] }
      player_matching["flight_#{flight_number}"] << match
      arenas << arena
    end

    new_group_1 = group_2.shift
    new_group_2 = group_1.pop
    group_1.unshift(new_group_1)
    group_2 << new_group_2
    create_flights(group_1, group_2, flight_number += 1, player_matching, arenas)
  end

  def build_player_match_up_hash
    ids = player_ids.clone
    until ids.blank?
      id = ids.shift
      player_match_ups[id] = { opponents: {}, arenas: {} } if player_match_ups[id].blank?
      ids.each do |i|
        player_match_ups[i] = { opponents: {}, arenas: {} } if player_match_ups[i].blank?

        player_match_ups[id][:opponents][i] = 0
        player_match_ups[i][:opponents][id] = 0
      end

      machine_ids.each do |m_id|
        player_match_ups[id][:arenas][m_id] = 0
      end
    end
  end

  def number_of_flights
    @number_of_flights ||= player_ids.size / 2
  end

  # def final_hash
  #   {
  #     rounds: [ {
  #       round.id =>  {
  #         flights: [ {
  #           flight.id => {
  #             matches: [ {
  #               id: match.id,
  #               machine_id: match.machine_id,
  #               player_1_id: player_match_1.player,
  #               player_2_id: player_match_2.player
  #             } ]
  #           }
  #         } ]
  #       }
  #     } ]
  #   }
  # end
end
