class Forum::CategoryPolicy < ApplicationPolicy
  attr_reader :user, :record
  class Scope < Struct.new(:user, :scope)
    def resolve
      if !user.nil? && user.netadmin?
        scope.all
      elsif !user.nil? && user.admin?
        scope.where('oline >= ?', User.olines[:admin])
      elsif !user.nil? && user.op?
        scope.where('oline >= ?', User.olines[:op])
      elsif !user.nil? && user.helper?
        scope.where('oline >= ?', User.olines[:helper])
      else
        scope.where(oline: 0)
      end
    end
  end

  def index?; true end

  def show?
    ## Netadmin Overide
    return true if user && user.netadmin?

    ## Oline > Status
    if record && record.oline == 0
      if record.status == 1
        true
      elsif record.status <= User.statuses[user.status]
        true
      end
    elsif (record && user) && (record.oline <= User.olines[user.oline])
      if record.status == 1
        true
      elsif record.status <= User.statuses[user.status]
        true
      end
    else
      false
    end

  end

  def create?
    true if user.admin? || user.netadmin?
  end
  def update?
    true if user.admin? || user.netadmin?
  end
  def destroy?
    true if user.admin? || user.netadmin?
  end
end
