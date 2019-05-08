class SessionsController < ApplicationController

    def create
          user = User.find_by_email(params[:email])
          if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, success: 'Logged In'
          else
            flash[:danger] = "Wrong email or password"
            render :new
          end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out"
        redirect_to root_path
    end
end

