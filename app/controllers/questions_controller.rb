class QuestionsController < ApplicationController
    before_action :find_question, only: [ :edit, :update, :destroy]

    def new
        @question = Question.new
    end

    def create
        @question = Question.new question_params
        @question.user = current_user
        if @question.save
            redirect_to quiz_path(@question.quiz)
        else
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
        params.require(:question).permit(:body)
    end

    def find_question
        @question = Question.find(params[:id])
    end

end
