class Ability
	include CanCan::Ability

	def initialize(user)
		can :read, :all
		return unless user
		can [:update, :destroy, :read, :create], Article, user_id: user.id
		can [:update, :destroy, :read, :create], Comment, user_id: user.id
		
	end

end

