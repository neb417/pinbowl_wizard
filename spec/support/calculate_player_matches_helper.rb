module CalculatePlayerMatchesHelper
  def formatted_params(player_match_1, player_match_2)
    {
      player_1: {
        id: player_match_1.id,
        user_id: player_match_1.user_id,
        score: player_match_1.score
      },
      player_2: {
        id: player_match_2.id,
        user_id: player_match_2.user_id,
        score: player_match_2.score
      }
    }
  end
end
