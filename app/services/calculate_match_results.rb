class CalculateMatchResults
  include Callable

  def initialize(player_matches:)
    @player_matches = player_matches
  end

  def call
    if player_1_score == player_2_score
      player_match_1.update(score: player_1_score, result: :draw)
      player_match_2.update(score: player_2_score, result: :draw)
    elsif player_1_score > player_2_score
      player_match_1.update(score: player_1_score, result: :win)
      player_match_2.update(score: player_2_score, result: :lose)
    else
      player_match_1.update(score: player_1_score, result: :lose)
      player_match_2.update(score: player_2_score, result: :win)
    end
  end

  private

  attr_reader :player_matches

  def player_match_1
    @player_match_1 ||= PlayerMatch.find(@player_matches.dig(:player_1, :id))
  end

  def player_match_2
    @player_match_2 ||= PlayerMatch.find(@player_matches.dig(:player_2, :id))
  end

  def player_1
    @player_1 ||= User.find(@player_matches.dig(:player_1, :user_id))
  end

  def player_2
    @player_2 ||= User.find(@player_matches.dig(:player_2, :user_id))
  end

  def player_1_score
    @player_score_1 ||= @player_matches.dig(:player_1, :score)
  end

  def player_2_score
    @player_score_2 ||= @player_matches.dig(:player_2, :score)
  end
end
