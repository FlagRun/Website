class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    user ||= User.new(id:0, username: 'Guest', status: 0, oline: 0)
    @user = user
    @record = record
  end

  # def index?; true end
  # def show?; true end
  # def create?; false end
  # def update?; false end
  # def destroy?; false end

  def new?
    create?
  end

  def edit?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

