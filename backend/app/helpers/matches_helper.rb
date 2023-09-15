module MatchesHelper
  include MatchRosterHelper
  private

  def authorized_to_create?(player_id, winner_team, other_team)
    winner_team.players_current.exists?(id: player_id) ||
    other_team.players_current.exists?(id: player_id)
  end

  def authorized_to_validate?(match)
    player_id = session[:user_id]
    MatchRoster.exists?(match: match, player_id: player_id)
  end

  def authorized_to_delete?(match)
    player_id = session[:user_id]
    match.created_by_id == player_id && !match.is_validated
  end

  def match_with_play_area_name(match)
    winner_team_average_elo = match.winner_team.average_elo_rating
    other_team_average_elo = match.other_team.average_elo_rating
    match.as_json.merge(
      play_area: match.play_area,
      winner_team: match.winner_team.as_json.merge(average_elo_rating: winner_team_average_elo, roster: match_roster_for_team(match, match.winner_team)),
      other_team: match.other_team.as_json.merge(average_elo_rating: other_team_average_elo, roster: match_roster_for_team(match, match.other_team))
    )
  end
end
