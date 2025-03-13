class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here
    return unless user.present?

    # Users can manage (create, read, update, delete) their own projects
    can :manage, Project, user_id: user.id
  end
end
