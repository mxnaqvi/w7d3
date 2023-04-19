class SessionController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    def new
        @user = User.new
        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]
        @user = User.find_by_credentials(username, password)
        if @user
            login! @user 
            redirect_to user_url(@user)
        else
            @user = User.new(username: username)

            flash.now[:errors] =['Invalid credentials']
        end
        render :new
    end

    def destroy
       if logged_in?
        logout!
        flash[:messages] = ['Successfully logged out']
    end

end
