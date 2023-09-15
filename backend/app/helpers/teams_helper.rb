module TeamsHelper
  private

  def add_play_area_name(matches)
    matches.includes(:play_area, match_rosters: { player: :teams }).map do |match|
      winner_team_average_elo = match.winner_team.average_elo_rating
      other_team_average_elo = match.other_team.average_elo_rating

      match.as_json.merge(
        play_area: match.play_area,
        winner_team: match.winner_team.as_json.merge(average_elo_rating: winner_team_average_elo),
        other_team: match.other_team.as_json.merge(average_elo_rating: other_team_average_elo)
      )
    end
  end
end
