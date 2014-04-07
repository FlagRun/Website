class Forum::Category < ActiveRecord::Base
  # Associations
  has_many :forums, class_name:'Forum::Forum', :dependent => :destroy

  # Scopes
  default_scope -> { order('position ASC') }

  # Validations
  validates :title,       :presence => true

  def user_authorized?(user)
    true if user && self.oline >= User.olines[user.oline]
  end

end
