module MatchRosterHelper
  private
  
  def match_roster_for_team(match, team)
    match.match_rosters.includes(player: [:teams]).where(team: team).map(&:player)
  end
end