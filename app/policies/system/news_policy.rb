class System::NewsPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true if user && user.op? || user.admin? || user.netadmin?
  end
  def update?
    true if user && user.op? || user.admin? || user.netadmin?
  end
  def destroy?
    true if user && user.op? || user.admin? || user.netadmin?
  end

end
