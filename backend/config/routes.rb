Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    resources :players do
      member do
        get 'matches', to: 'players#player_matches'
        get 'teams', to: 'players#player_teams'
        get 'teams/matches', to: 'players#player_teams_matches'
        get 'playarea/favorite', to: 'players#player_playarea_favorite'
      end
      collection do
        post 'edit'
        get 'rankings', to: 'players#players_rankings'
      end
    end

    resources :teams do
      member do
        post 'add_player/:user_id', to: 'teams#add_player'
        post 'remove_player/:user_id', to: 'teams#remove_player'
        get 'matches', to: 'teams#team_matches'
        get 'players/current', to: 'teams#players_current'
        get 'players/history', to: 'teams#players_history'
      end
      collection do
        get 'rankings', to: "teams#teams_rankings"
      end
    end

    resources :play_areas do
      member do
        get 'matches', to: 'play_areas#matches_history'
      end
    end

    resources :matches do
      member do
        get 'teams', to: 'matches#teams'
        get 'playarea', to: 'matches#playarea'
        get 'validate', to: 'matches#validate'
        get 'delete', to: 'matches#delete'
      end
      collection do
        get 'create/:winner_team_id/:other_team_id/:play_area_id', to: 'matches#create'
      end
    end

    get 'my-profile', to: 'players#my_profile'
    get 'login(/:user_id)', to: 'sessions#login'
    get 'logout', to: 'sessions#logout'
    get 'testlogin', to: 'sessions#testlogin'
  end
end
