class Forum::Forum < ActiveRecord::Base
  extend FriendlyId

  # Associations
  has_many :topics, class_name: 'Forum::Topic', :dependent => :destroy
  has_many :posts,  class_name: 'Forum::Post',  :through => :topics

  belongs_to :category, :class_name => 'Forum::Category'

  # Scopes
  default_scope -> { order('position ASC') }

  # Pagination
  paginates_per 50

  # Validations
  validates :title,       :presence => true
  validates :description, :presence => true
  validates :category_id, :presence => true

  # Friendly ID
  friendly_id :id
  def to_param
    "#{id} #{title}".parameterize
  end

  def user_authorized?(user)
    true if user && self.oline >= User.olines[user.oline]
  end

end