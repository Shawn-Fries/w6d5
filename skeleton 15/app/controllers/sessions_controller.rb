class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]


    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            session[:session_token] = @user.reset_session_token!
            redirect_to cats_url
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def destroy
        current_user.reset_session_token! if current_user # reset token
        session[:session_token] = nil # session_token to nil = blank it
    end
end