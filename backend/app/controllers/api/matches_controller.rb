module Api
  class MatchesController < ApplicationController
    include MatchRosterHelper
    include MatchesHelper
    def show
      @match_id = params[:id]
      @Match = Match.includes(:play_area).find_by_id(@match_id)

      render json: match_with_play_area_name(@Match)
    end

    def index
      @Matches = Match.includes(:play_area).all

      render json: @Matches.map { |match| match_with_play_area_name(match) }
    end

    def create
      player_id = session[:user_id]
      return render json: { message: 'Unauthorized. Not logged in.' }, status: :unauthorized if player_id.nil?

      winner_team_id = params[:winner_team_id]
      other_team_id = params[:other_team_id]
      play_area_id = params[:play_area_id]

      winner_team = Team.find_by_id(winner_team_id)
      other_team = Team.find_by_id(other_team_id)
      play_area = PlayArea.find_by_id(play_area_id)

      if winner_team.nil?
        render json: { message: 'Winner team not found.' }, status: :not_found
      elsif other_team.nil?
        render json: { message: 'Other team not found.' }, status: :not_found
      elsif play_area.nil?
        render json: { message: 'PlayArea not found. '}, status: :not_found
      elsif !authorized_to_create?(player_id, winner_team, other_team)
        render json: { message: 'Unauthorized. You must be a player of either team.'}, status: :unauthorized
      else
        match = Match.new(
          winner_team: winner_team,
          other_team: other_team,
          created_by: Player.find_by_id(session[:user_id]),
          play_area: play_area,
          is_validated: false
        )


        # Find active players for both teams
        winner_team_players = winner_team.players_current
        other_team_players = other_team.players_current

        unless authorized_to_create?(player_id, winner_team, other_team)
          render json: { message: 'Unauthorized. You must be a player of either team.'}, status: :unauthorized
        end

        match = Match.new(
          winner_team: winner_team,
          other_team: other_team,
          created_by: Player.find_by_id(session[:user_id]),
          play_area: play_area,
          is_validated: false
        )

        if match.save
          # Create MatchRoster records for winner_team players
          winner_team_players.each do |player|
            MatchRoster.create(match: match, team: winner_team, player: player)
          end

          # Create MatchRoster records for other_team players
          other_team_players.each do |player|
            MatchRoster.create(match: match, team: other_team, player: player)
          end
          render json: { message: 'Match created successfully.', match_id: match.id }
        else
          render json: { message: 'Failed to create match.' }, status: :unprocessable_entity
        end
      end
    end

    def validate
      return render json: { message: 'Unauthorized. Not logged in.' }, status: :unauthorized if session[:user_id].nil?

      match_id = params[:id]
      match = Match.find_by_id(match_id)

      return render json: { message: 'Match not found.' }, status: :not_found if match.nil?
      return render json: { message: 'Not authorized to validate this match.' }, status: :unauthorized unless authorized_to_validate?(match)

      match.update(is_validated: true)

      render json: { message: 'Match validated successfully.' }
    end

    def delete
      return render json: { message: 'Unauthorized. Not logged in.' }, status: :unauthorized if session[:user_id].nil?

      match_id = params[:id]
      match = Match.find_by_id(match_id)

      return render json: { message: 'Match not found.', match: match }, status: :not_found if match.nil?
      return render json: { message: 'Not authorized to delete this match.' }, status: :unauthorized unless authorized_to_delete?(match)

      match.destroy

      render json: { message: 'Match deleted successfully.' }
    end

    def playarea
      @match_id = params[:id]
      @Match = Match.find_by_id(@match_id)
      render json: PlayArea.find_by_id(@Match.play_area_id)
    end

    def teams
      @match_id = params[:id]
      @match = Match.find_by_id(@match_id)

      @winning_team = @match.winner_team
      @losing_team = @match.other_team

      response_data = {
        winner: {
          team: @winning_team,
          roster: match_roster_for_team(@match, @winning_team)
        },
        loser: {
          team: @losing_team,
          roster: match_roster_for_team(@match, @losing_team)
        }
      }

      render json: response_data
    end
  end
end
