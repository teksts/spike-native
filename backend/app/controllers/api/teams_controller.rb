module Api
  class TeamsController < ApplicationController
    include TeamsHelper

    def show
      @team_id = params[:id]
      @Team = Team.find_by_id(@team_id)

      render json: @Team.as_json(methods: :average_elo_rating)
    end

    def index
      @Teams = Team.all
      render json: @Teams
    end

    def add_player
      captain_id = session[:user_id]
      return render json: { message: 'Unauthorized. Not logged in.' }, status: :unauthorized if captain_id.nil?

      @team = Team.find_by_id(params[:id])
      return render json: { message: 'Team not found. '}, status: :not_found if @team.id.nil?
      return render json: { message: 'Unauthorized. Not the captain of the team.' }, status: :unauthorized if @team.captain_id != captain_id

      @player = Player.find_by_id(params[:user_id])
      return render json: { message: 'Player not found.' }, status: :not_found if @player.id.nil?

      RosterRecord.create(team: @team, player: @player, joined_at: Time.now)
      render json: { message: 'Player added to the team.', statusCode: 200 }
    end

    def remove_player
      captain_id = session[:user_id]
      return render json: { message: 'Unauthorized. Not logged in.' }, status: :unauthorized if captain_id.nil?

      @team = Team.find_by_id(params[:id])
      return render json: { message: 'Team not found. '}, status: :not_found if @team.id.nil?
      return render json: { message: 'Unauthorized. Not the captain of the team.' }, status: :unauthorized if @team.captain_id != captain_id

      @player = Player.find_by_id(params[:user_id])
      return render json: { message: 'Player not found.' }, status: :not_found if @player.id.nil?

      roster_record = RosterRecord.where(team: @team, player: @player, left_at: nil).order(created_at: :desc).first
      return render json: { message: 'Player is not in the team. '}, status: :not_found if roster_record.nil?

      roster_record.udpate(left_at: Time.now)
      render json: { message: 'Player removed from the team.', statusCode: 200 }
    end

    def team_matches
      @team_id = params[:id]
      @Team = Team.find_by_id(@team_id)
      @matches_played = @Team.matches_played
      @matches_won = @Team.matches_as_winner
      @matches_lost = @Team.matches_as_other_team

      response_data = {
        matches: add_play_area_name(@matches_played),
        wins: add_play_area_name(@matches_won),
        losses: add_play_area_name(@matches_lost)
      }

      render json: response_data
    end

    def players_current
      @team_id = params[:id]
      @Team = Team.find_by_id(@team_id)
      @players_current = @Team.players_current

      render json: @players_current
    end

    def players_history
      @team_id = params[:id]
      @Team = Team.find_by_id(@team_id)
      @players_history = @Team.players_history
      render json: @players_history
    end

    def teams_rankings
      @Teams = Team.all.sort_by { |team| -team.average_elo_rating }
      teams_ranked = @Teams.map do |team|
        team.as_json.merge(
          elo_rating: team.average_elo_rating
        )
      end
      render json: teams_ranked
    end
  end
end
