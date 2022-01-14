class ApplicationController < ActionController::Base
    helper_method :current_user


    def current_user
        User.find_by(params[:session_token])
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

end
