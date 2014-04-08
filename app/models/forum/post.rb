class Forum::Post < ActiveRecord::Base

  # Associations
  belongs_to :forum, :class_name => 'Forum::Forum', :counter_cache => true
  belongs_to :topic, :class_name => 'Forum::Topic', :counter_cache => true, :touch => true
  belongs_to :user, :class_name => 'User', :counter_cache => true

  # Validations
  validates :body, :presence => true
  validates :user, :presence => true

  # Pagination
  paginates_per 50

  # Paranoia
  acts_as_paranoid

  # Default Scope
  #default_scope :order => 'created_at ASC'
  default_scope -> { order('created_at ASC') }

  # Scope to display only the last n posts. Used for "Recent Posts" display
  scope :recent, lambda {
    |c| reorder('created_at desc').limit(c)
  }

  # Callbacks
  before_save :topic_locked?

  #
  def to_s
    'Post'
  end

  # Methods
  def user_authorized?(user)
    true if user && self.oline >= User.olines[user.oline]
  end

  private
    def topic_locked?
      if topic.locked?
        errors.add(:base, "That topic is locked")
        false
      end
    end
end
