class AttemptsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_quiz

    def show
        
    end

    def create
        # render json: params 
        attempt = Attempt.new(
            user: current_user,
            quiz_id: @quiz
            # score: score
        )
        redirect_to quiz_path(@quiz)
    end 

    private

    def find_quiz
        @quiz = Quiz.find(params[:quiz])
    end
end
