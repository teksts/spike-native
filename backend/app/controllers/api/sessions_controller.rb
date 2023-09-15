module Api
  class SessionsController < ApplicationController
    def login
      if params[:user_id].nil?
      session[:user_id] = 1
      else
        session[:user_id] = params[:user_id]
      end
      render json: { statusCode: 200, message: 'User logged in', action: 'login' }
    end

    def logout
      session[:user_id] = nil
      render json: { statusCode: 200, message: 'User logged out', action: 'logout' }
    end

    def testlogin
      if session[:user_id].nil?
        render json: { user_id: nil, message: 'not logged in' }
      else
        render json: { user_id: session[:user_id], message: 'logged in' }
      end
    end
  end
end