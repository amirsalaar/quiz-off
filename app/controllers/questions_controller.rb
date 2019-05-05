class QuestionsController < ApplicationController
    before_action :find_question, only: [ :edit, :update, :destroy]

    def new
        @question = Question.new
    end

    def create
        # render json: params
        @question = Question.new question_params
        @question.user = current_user
        if @question.save
            # redirect somewhere
        else
            render :new 
        end
    end
    
    def edit
        @answer_count = 1
        # ability to edit
    end
    
    def update
        if @question.update question_params
            # redirect somewhere
        else
            render :edit
        end
    end

    def destroy
        @question.destroy
        # redirect somewhere
    end

    private

    def question_params
        params.require(:question).permit(:body)
    end

    def find_question
        @question = Question.find(params[:id])
    end

end
