class Player < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :elo_rating, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :roster_records
  has_many :teams, through: :roster_records
  has_many :match_rosters
  has_many :matches, through: :match_rosters
  has_many :matched_teams, through: :match_rosters, source: :team

  def teams_current
    teams.where(roster_records: { left_at: nil })
  end

  def teams_history
    teams.where.not(roster_records: { left_at: nil })
  end

  def matches_played
    # matches.distinct
    matches.distinct.order(created_at: :desc).map do |match|
      match.as_json.merge(
        winner_team_name: match.winner_team.name,
        other_team_name: match.other_team.name,
        play_area_name: match.play_area.name,
        created_at: match.created_at.strftime('%Y-%m-%d'),
        play_area: match.play_area,
        winner_team: match.winner_team,
        other_team: match.other_team
      )
    end
  end

  def most_played_play_area_with_count
    play_area_counts = matches.group(:play_area_id).count
    most_played_play_area_id, count = play_area_counts.max_by { |_, count| count }

    most_played_play_area = PlayArea.find_by_id(most_played_play_area_id)

    {
      play_area: most_played_play_area,
      count: count
    }
  end
end
