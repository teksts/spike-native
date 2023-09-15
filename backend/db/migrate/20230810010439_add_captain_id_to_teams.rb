class AddCaptainIdToTeams < ActiveRecord::Migration[7.0]
  def up
    add_reference :teams, :captain, foreign_key: { to_table: :players }
    
    # Update captain_id for existing teams
    Team.all.each do |team|
      # Set captain_id for each team. Just using the first player of a team.
      captain = team.players.first
      team.update(captain: captain) if captain
    end
  end
  
  def down
    remove_reference :teams, :captain
  end
end
