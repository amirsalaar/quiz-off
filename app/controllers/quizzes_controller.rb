class QuizzesController < ApplicationController
    before_action :find_quiz, only: [:show, :edit, :update, :destroy]
    def new
        @quiz = Quiz.new
    end

    def create
        @quiz = Quiz.new quiz_params
        @quiz.user = current_user
        if @quiz.save
            redirect_to quiz_path(@quiz.id)
        else
            render :new
        end
    end

    def show
        @question = Question.new
        @questions = @quiz.questions.order(created_at: :desc)
    end

    def index
        @quizzes = Quiz.all.order(created_at: :desc)
    end

    def edit
        
    end

    def update
        if @quiz.update quiz_params
            redirect_to quiz_path(@quiz.id)
        else
            render :edit
        end        
    end

    def destroy
        @quiz.destroy
        redirect_to root_path
    end

    private

    def quiz_params
      params.require(:quiz).permit(:title, :description, :level, :points)
    end
  
    def find_quiz
      @quiz = Quiz.find(params[:id])
    end
  
    def authorize
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @quiz)
    end
end
