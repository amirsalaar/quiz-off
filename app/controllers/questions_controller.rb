class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :find_question, only: [ :edit, :update, :destroy]
    before_action :find_quiz, only: [:create, :edit, :update]

    def new
        @question = Question.new
    end

    def create
        @question = Question.new question_params
        @question.quiz = @quiz
        @question.quiz.user = current_user
        if @question.save
            redirect_to quiz_path(@quiz)	
        else
            flash[:danger] = @question.errors.full_messages.join(', ')
            render :new 
        end
    end
    
    def edit
        @answer_count = 1
        # ability to edit
    end

    def show
        @quiz = Quiz.find(params[:quiz_id]) # .questions.find(params[:id])
        @question = @quiz.questions.find(params[:id])# Question.new question_params
    end

    def update
        if @question.update question_params
            redirect_to quiz_question_path(@question)
        else
            render :edit
        end
    end

    def destroy
        @question.destroy
        redirect_to quiz_path(@question.quiz_id)
    end

    private

    def question_params
        params.require(:question).permit(:body, answers_attributes: [:body, is_correct: true])
    end

    def find_quiz
        @quiz = Quiz.find(params[:quiz_id])
    end

    def find_question
        @question = Question.find(params[:id])
    end

end
