
class Ability
  include CanCan::Ability

  def initialize(user)
    
      user ||= User.new # guest user (not logged in)
    
      alias_action :create, :read, :update, :destroy, to: :crud 

      #teacher
      can(:crud, Quiz) do |quiz|
        user.role == 1
      end
        
      #logic for not being able to take own quiz that the teacher created
      can(:create, Attempt) do |attempt|
        user != quiz.user_id
      end

      # teacher is the owner of the quiz?
      can(:change, Quiz) do |quiz|
        user.role == 1 && quiz.user == user
      end

      # #admin
      # can(:crud, Quiz) do |quiz|
      #   quiz.user_id == user && user.role == 3 
      #   can :create, Attempt, user_id: user.id && user.role == 3
      # end
        
  end
end


 

  

