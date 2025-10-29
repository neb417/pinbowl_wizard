class GenerateLeague
  include Callable

  # def initialize(season:, number_of_rounds:, number_of_flights:)
  def initialize(season:, number_of_rounds:)
    @season = season
    @number_of_rounds = number_of_rounds
    @game_number = 1
    self.machines = @season.organization.machines
    self.accounts = @season.organization.accounts
    self.player_ids = @season.organization.accounts.pluck(:id)
    self.number_of_flights= number_of_flights
    self.machine_ids = machines.pluck(:id).to_a
    self.evens = []
    self.odds = []
    self.group_1 = []
    self.group_2 = []
    self.result = {}
    self.player_match_ups = {}
    self.base_games = {}
    @player_player = {}
    @player_machine = {}
    @player_player_machine = {}
  end

  def call
    build_player_match_up_hash
    split_players_into_groups
    build_total_games
    rebuild_player_match_up
    create_seasons
    binding.pry
  end

  private

  attr_accessor :result, :machines, :accounts, :player_ids,
                :machine_ids, :player_match_ups, :evens, :odds,
                :number_of_flights, :group_1, :group_2, :base_games


  def split_players_into_groups
    player_ids.each_with_index do |id, index|
      index % 2 == 0 ? odds << id : evens << id
    end

    half = (player_ids.size / 2)
    (group_1 << player_ids[0..half - 1]).flatten!
    (group_2 << player_ids[half.. - 1]).flatten!
  end

  def create_season(group_1, group_2, round_number = 1)
    return if round_number > @number_of_rounds

    result["round_#{round_number}"] = {}
    if round_number % 2 == 0
      create_season(group_1, group_2, round_number + 1)
    else
      create_season(group_1.reverse, group_2.reverse, round_number + 1)
    end
  end

  def create_seasons
    round_number = 1
    machines_half_point = machine_ids.size / 2
    first_half_arenas = machine_ids[0..machines_half_point - 1]
    second_half_arenas = machine_ids[machines_half_point..-1]

    @number_of_rounds.times do
      arenas = round_number % 2 == 0 ? second_half_arenas : first_half_arenas

      if round_number != 2 && round_number % 2 == 0
        arenas.rotate!(-1)
      end

      result["round_#{round_number}"] = create_flights(arenas)
      round_number +=1
    end
  end

  def create_flights(arenas, player_matching = {}, flight_number = 1)
    return player_matching if flight_number > number_of_flights

    flight_arenas = arenas.shift(number_of_flights)
    player_matching["flight_#{flight_number}"] = []

    counter = 1
    until counter > number_of_flights
      reset_game_number if @game_number > last_game_number
      arena = flight_arenas.shift
      match = { "arena_#{arena}" => base_games[@game_number] }
      player_matching["flight_#{flight_number}"] << match

      player_1 = base_games[@game_number][0]
      player_2 = base_games[@game_number][1]
      player_match_ups[player_1][:opponents][player_2] += 1
      player_match_ups[player_2][:opponents][player_1] += 1
      player_match_ups[player_1][:arenas][arena] += 1
      player_match_ups[player_2][:arenas][arena] += 1

      arenas << arena
      @game_number += 1
      counter += 1
    end

    flight_number += 1

    create_flights(arenas, player_matching, flight_number)
  end

  def build_total_games
    # player_ids.combination(2)
    odds_half = odds.size / 2
    evens_half = evens.size / 2
    build_base_games(group_1, group_2)
    build_base_games(odds[0..odds_half  - 1], odds[odds_half..-1])
    build_base_games(evens[0..evens_half  - 1], evens[evens_half..-1])
  end

  def build_base_games(group_a, group_b)
    return if player_match_ups[group_a[0]][:opponents][group_b[0]] > 0

    index = 0

    until (index > group_a.count  - 1) || (index >  group_b.count - 1)
      base_games[@game_number] = [ group_a[index], group_b[index] ]
      player_match_ups[group_a[index]][:opponents][group_b[index]] +=1
      player_match_ups[group_b[index]][:opponents][group_a[index]] +=1
      index += 1
      @game_number += 1
    end

    new_group_a = group_b.shift
    new_group_b = group_a.pop
    group_a.unshift(new_group_a)
    group_b << new_group_b

    build_base_games(group_a, group_b)
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

  def rebuild_player_match_up
    player_match_ups.each do |_player, player_match|
      player_match[:opponents].keys.each do |opponent|
        player_match[:opponents][opponent] = 0
      end
    end
    reset_game_number
  end

  def number_of_flights
    @number_of_flights ||= player_ids.size / 2
  end

  def reset_game_number
    @game_number = 1
  end

  def last_game_number
    @last_game_number ||= base_games.keys.sort.last
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
