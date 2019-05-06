class AttemptsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_quiz

    def show
        
    end

    def create
        # render json: params 
        @attempt = Attempt.new(
            user: current_user,
            quiz_id: @quiz.id,
            score: 0
        )   
        @attempt.save
        redirect_to quiz_path(@quiz, attempt: @attempt)
    end 

    private

    def find_quiz
        @quiz = Quiz.find(params[:quiz])
    end
end
