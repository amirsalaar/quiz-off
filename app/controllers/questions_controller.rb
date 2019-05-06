class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :find_question, only: [ :edit, :update, :destroy, :answer]
    before_action :find_quiz, only: [:new, :create, :edit, :update, :answer]
    before_action :authorize, only: [:create, :update, :destroy]



    def new
        # byebug
        if @quiz.user_id == current_user.id
        @question = Question.new
        else
            redirect_to root_path
            flash[:danger] = 'Not Authorized'
        end
    end

    def create
            @question = Question.new question_params
            @question.quiz = @quiz
            @question.quiz.user = current_user
            @question.generate_fake_answer
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
        @answers = Answer.where({question_id: @question.id})
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
    
    def answer
        # questions = @quiz.questions.order(created_at: :desc)
        attempt = Attempt.find_by(quiz_id: @quiz.id, user_id: current_user.id)
        if params[:answer_id]
            answer = Answer.find(params[:answer_id])
            if answer[:is_correct] == true
                attempt.answer_tracks +=1
                attempt.save
            end
            # redirect_to quiz_question_path(@quiz.id, questions[:id])
        end 
        redirect_to quiz_path(@quiz)
        # render json: params
    end

    private

    def question_params
        params.require(:question).permit(:body, answers_attributes: [:body, :is_correct])
    end

    def find_quiz
        @quiz = Quiz.find(params[:quiz_id])
    end

    def find_question
        @question = Question.find(params[:id])
    end

    def authorize
        redirect_to root_path unless can?(:crud, @quiz)
    end

end
