class ApplicationController < ActionController::Base
    helper_method :current_user


    def current_user
        User.find_by(params[:session_token])
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def logged_in?
        !!current_user
    end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end

    def require_owned
        redirect_to cats_url unless 
    end

end
