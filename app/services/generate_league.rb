class GenerateLeague
  include Callable

  # def initialize(season:, number_of_rounds:, number_of_flights:)
  def initialize(season:, number_of_rounds:, number_of_flights:)
    @season = season
    @number_of_rounds = number_of_rounds
    @number_of_flights= number_of_flights
    self.machines = @season.organization.machines
    self.accounts = @season.organization.accounts
    self.player_ids = @season.organization.accounts.pluck(:id)
    self.machine_ids = machines.pluck(:id).to_a
    self.result = {}
    self.player_match_ups = {}
  end

  def call
    build_player_match_up_hash
    group_1, group_2 = split_players_into_groups
    create_season(group_1, group_2)
    result.each do |round, _value|
      result[round] = create_flights(group_1.dup.shuffle, group_2.dup.shuffle)
    end
    binding.pry
  end

  private

  attr_accessor :result, :machines, :accounts, :player_ids, :machine_ids, :player_match_ups

  def split_players_into_groups
    half = (player_ids.count  / 2.0).round
    player_ids.each_slice(half).to_a
  end

  def create_season(group_1, group_2, round_number = 1)
    return if round_number > @number_of_rounds

    flights = create_flights(group_1.clone, group_2.clone)
    result["round_#{round_number}"] = flights
    create_season(group_1.shuffle.clone, group_2.shuffle.clone, round_number + 1)
  end

  def create_flights(group_1, group_2, flight_number = 1, player_matching = {}, arenas = machine_ids.shuffle[0..group_1.count - 1])
    return player_matching if flight_number > @number_of_flights

    player_matching["flight_#{flight_number}"] = []
    group_1.each_with_index do |player, index|
      player_match_ups[player][:opponents][group_2[index]] += 1
      player_match_ups[group_2[index]][:opponents][player] += 1
      player_match_ups[player][:arenas][arenas[index]] += 1
      player_match_ups[group_2[index]][:arenas][arenas[index]] += 1

      match = { "arena_#{arenas[index]}" => [ player, group_2[index] ] }
      player_matching["flight_#{flight_number}"] << match
    end

    new_group_1 = group_2.shift
    new_group_2 = group_1.pop
    group_1.unshift(new_group_1)
    group_2 << new_group_2
    create_flights(group_1, group_2, flight_number += 1, player_matching)
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
