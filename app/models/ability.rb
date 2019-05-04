# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
      user ||= User.new # guest user (not logged in)
    
      alias_action :create, :read, :update, :destroy, to: :crud 
      #can :crud, Quiz, user_id: user.id

      if user.role == 1 
        can (:crud, Quiz) do |quiz|
          quiz.user = user
        end
      end 

      can :create, Attempt, user_id: user.id

  end
end


 

  

