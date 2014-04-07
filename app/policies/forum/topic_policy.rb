class Forum::TopicPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
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
    true
  end

  def update?
    return true if (user.admin? || user.netadmin?)
    true if user.id == record.user_id
  end

  def destroy?
    true if (user.admin? || user.netadmin?)
  end

  def moderate?
    true if (user.admin? || user.netadmin?)
  end

end
