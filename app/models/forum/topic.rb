class Forum::Topic < ActiveRecord::Base
  extend FriendlyId

  # Associations
  has_many :posts, :class_name => 'Forum::Post', :dependent => :destroy
  belongs_to :forum, :class_name => 'Forum::Forum', :counter_cache => true
  belongs_to :user, :class_name => 'User', :counter_cache => true

  acts_as_readable :on => :updated_at

  # Accessors
  attr_accessor :body

  # Friendly ID // ID-TITLE
  friendly_id :id
  def to_param
    "#{id} #{title}".parameterize
  end

  # Pagination
  paginates_per 50

  # Paranoia
  acts_as_paranoid

  # Validations
  validates :title,   :presence => true
  validates :body,    :presence => true, :on => :create
  validates :posts,   :presence => true, :allow_nil => false, :on => :update
  validates :user,    :presence => true

  # Scopes
  #default_scope :order => 'sticky DESC, updated_at DESC'
  default_scope -> { includes(:user).order('sticky DESC, updated_at DESC') }

  # Callbacks
  after_create :create_initial_post

  # Methods
  def hit!
    self.class.increment_counter :hits, id
  end

  def user_authorized?(user)
    true if user && self.oline >= User.olines[user.oline]
  end

  private
    def create_initial_post
      self.posts.build(:body => self.body).tap do |post|
        post.forum = self.forum
        post.user = self.user
        post.save
      end
    end
end
