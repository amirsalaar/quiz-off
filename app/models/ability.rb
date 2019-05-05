
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
      user ||= User.new # guest user (not logged in)
    
      alias_action :create, :read, :update, :destroy, to: :crud 
      #can :crud, Quiz, user_id: user.id

      #teacher
      can (:crud, Quiz) do |quiz|
        quiz.user == user && user.role == 1
      end

      #logic for not being able to take own quiz that the teacher created
      if Quiz.user != user
        can :create, Attempt, user_id: user.id && user.role == 2 
      end

      #admin
      can (:crud, Quiz) do |quiz|
        quiz.user == user && user.role == 3 
        can :create, Attempt, user_id: user.id && user.role == 3
      end
        
  end
end


 

  

