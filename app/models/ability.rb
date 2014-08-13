class Ability
	include CanCan::Ability

	def initialize(user)
		can :read, :all
  		can :manage, Article, user_id: user.id
		#can :destroy, Comment, {:user_id => user.id}
		can :destroy, Comment do |comment|  
        	comment.try(:user) == user  
     	end  
		can :manage, User, :id => user.id

	end
end
