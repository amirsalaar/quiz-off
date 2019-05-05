# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
      user ||= User.new # guest user (not logged in)
    
      alias_action :create, :read, :update, :destroy, to: :crud 
      #can :crud, Quiz, user_id: user.id

      if user.role == 1 #teacher
        can (:crud, Quiz) do |quiz|
          quiz.user = user
        end
      end 

      if user.role == 2 || user.role == 1 #student
        #logic for not being able to take own quiz that the teacher created
        if Quiz.user != user
          can :create, Attempt, user_id: user.id
        end
      end
      

      if user.role == 3 #admin
        can (:crud, Quiz) do |quiz|
          quiz.user = user
        end
        can :create, Attempt, user_id: user.id
      end
  end
end


 

  

