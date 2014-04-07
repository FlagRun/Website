class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def index?
    true
  end

  def update?
    return true if user.admin? || user.netadmin?
    true if user.id === record.id
  end
end
