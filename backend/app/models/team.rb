class Team < ApplicationRecord
  validates :name, presence: true

  has_many :roster_records
  has_many :players, through: :roster_records
  has_many :matches_as_winner, foreign_key: 'winner_team_id', class_name: 'Match'
  has_many :matches_as_other_team, foreign_key: 'other_team_id', class_name: 'Match'
  belongs_to :captain, class_name: 'Player', foreign_key: 'captain_id', optional: true

  def players_current
    players.where(roster_records: { left_at: nil })
  end

  def players_history
    players.where.not(roster_records: {left_at: nil })
  end

  def matches_played
    Match.where('winner_team_id = ? OR other_team_id = ?', self.id, self.id)
  end

  def average_elo_rating
    active_players = players_current
    total_elo = active_players.sum(:elo_rating)

    return 0 if active_players.empty?    
    average_elo = total_elo.to_f / active_players.count
    truncated_average_elo = average_elo.truncate
    truncated_average_elo
  end
end
