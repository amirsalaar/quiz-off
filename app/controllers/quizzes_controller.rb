class QuizzesController < ApplicationController
    before_action :find_quiz, only: [:show, :edit, :update, :destroy, :quiz]
    before_action :find_user, only: [:new, :edit, :update, :create]
    before_action :authorize, only: [:edit, :update, :destroy]

    def new
        if current_user && @user.role == 1
            @quiz = Quiz.new
        else
            redirect_to root_path, alert: 'Please sign in or sign up as an Instructor to create quizzes!'
        end
    end

    def create
            @quiz = Quiz.new quiz_params
            @quiz.user = current_user
            if can?(:crud, @quiz)
                if @quiz.save
                    redirect_to quiz_path(@quiz.id)
                else
                    render :new
                end
            else
                redirect_to root_path, alert: 'Not Authorized'
            end
    end

    def show
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

    def finish
        attempt = Attempt.find_by(quiz_id: @quiz.id, user_id: current_user.id)
        flash[:success] = "You got #{attempt.result}"
        redirect_to quizzes_path
    end

    private

    def quiz_params
      params.require(:quiz).permit(:title, :description, :level, :points)
    end
  
    def find_quiz
      @quiz = Quiz.find(params[:id])
    end

    def find_user
        @user = User.find(current_user.id)
      end
  
    def authorize
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @quiz)
    end

end
