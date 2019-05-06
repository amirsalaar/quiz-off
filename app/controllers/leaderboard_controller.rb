class LeaderboardController < ApplicationController

    before_action :authenticate_user!, :current_user

    def index
        @users = User.order(total_points: :desc).limit(10)
        @user = current_user
    end

end
