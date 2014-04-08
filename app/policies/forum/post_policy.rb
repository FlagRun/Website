class Forum::PostPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  # Methods
  def index?; true end

  def show?
    ## Netadmin Overide
    return true if user && user.netadmin?

    ## Oline > Status
    if record && record.forum.oline == 0
      if record.forum.status == 1
        true
      elsif record.forum.status <= User.statuses[user.status]
        true
      end
    elsif (record && user) && (record.forum.oline <= User.olines[user.oline])
      if record.forum.status == 1
        true
      elsif record.forum.status <= User.statuses[user.status]
        true
      end
    else
      false
    end

  end

  def create?
    return false if user.banned?
    true
  end
  def update?
    return true if user && user.admin? || user.netadmin?
    return false if user.banned?
    true if user.id == record.user_id
  end
  def destroy?
    return true if user && user.admin? || user.netadmin?
    return false if user.banned?
    true if user.id == record.user_id
  end
end
