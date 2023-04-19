class ApplicationController < ActionController::Base
    #current user, require logged in loggged out, login, logout, logged_in? helper method
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def login!
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        current_user.reset_session_token! if logged_in?
        session[session_token] = nil
        current_user = nil
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

end
