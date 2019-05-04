class QuizzesController < ApplicationController
    before_action :find_quiz, only: [:show, :edit, :update, :destroy]
    def new
        @quiz = Quiz.new
    end

    def create

    end

    def show

    end

    def index

    end

    def edit
        
    end

    def update
        
    end

    def destroy
        @quiz.destroy
    end

    private

    # def quiz_params
    #   params.require(:quiz).permit(:title, :description, :tag_names)
    # end
  
    def find_quiz
      @quiz = Quiz.find(params[:id])
    end
  
    # def authorize
    #   redirect_to
    # end
end
