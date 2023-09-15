module Api
  class PlayersController < ApplicationController
    def show
      @player_id = params[:id]
      @Player = Player.find_by_id(@player_id)

      render json: @Player
    end

    def index
      @Players = Player.all
      render json: @Players
    end

    def create
      player = Player.new(player_params)
      player.elo_rating = 1500

      if player.save
        session[:user_id] = player.id
        render json: { statusCode: 200, message: 'Player created successfully.' }
      else
        render json: { errors: players.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def edit
      user_id = session[:user_id]
      if user_id.nil?
        render json: { statusCode: 401, message: 'Unauthorized. Not logged in. '}
        return
      end

      player = Player.find_by_id(user_id)
      player.update(player_params)

      render json: { statusCode: 200, message: 'Player profile updated successfully. '}
    end

    def my_profile
      if session[:user_id].nil?
        render json: { message: 'User not logged in', player: nil }
      else
        render json: { player: Player.find_by_id(session[:user_id]) }
      end
    end

    def player_matches
      @player_id = params[:id]
      @Player = Player.find_by_id(@player_id)
      @match_history = @Player.matches_played

      render json: @match_history
    end

    def player_teams
      @player_id = params[:id]
      @Player = Player.find_by_id(@player_id)
      @teams_current = @Player.teams_current
      @teams_current_with_rosters = @teams_current.map do |team|
      team = team.as_json.merge(roster: team.roster_records.where(left_at: nil).map(&:player), elo_rating: team.average_elo_rating, created_at: team.created_at.strftime('%Y-%m-%d'))
      end
      @teams_history = @Player.teams_history
      teams_history_with_elo = @teams_history.map do |team|
        team = team.as_json.merge(elo_rating: team.average_elo_rating)
      end
      response_data = {
        teams_current: @teams_current_with_rosters,
        teams_history: teams_history_with_elo
      }

      render json: response_data
    end

    def player_teams_matches
      @player_id = params[:id]
      @Player = Player.find_by_id(@player_id)
      @matches_history = @Player.teams.flat_map(&:matches_played).uniq
      matches_with_team_names = @matches_history.map do |match|
        match.as_json.merge(
          winner_team_name: match.winner_team.name,
          other_team_name: match.other_team.name,
          created_at: match.created_at.strftime('%Y-%m-%d'),
          play_area_name: match.play_area.name
        )
      end
      # response_data = {
      #   matches_played: matches_with_team_names
      # }

      render json: matches_with_team_names
    end

    def player_playarea_favorite
      @player_id = params[:id]
      @Player = Player.find_by_id(@player_id)
      @favorite_playarea = @Player.most_played_play_area_with_count

      render json: @favorite_playarea
    end

    def players_rankings
      @Players = Player.all.order(elo_rating: :desc)
      render json: @Players
    end

    private

    def player_params
      params.permit(:first_name, :last_name, :description, :avatar_image)
    end
  end
end
