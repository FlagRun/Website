class User < ActiveRecord::Base
  extend  FriendlyId
  include Gravtastic

  # Devise
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  friendly_id :username
  gravtastic :email, size: 75, filetype: :png, default: 'retro'
  acts_as_reader
  acts_as_messageable
  acts_as_tagger

  # Status
  enum status: { banned: 0, member: 1, senior: 2, hidden: 3, contrib: 50, staff: 100 }

  # O:Line
  enum oline:  { user: 0, helper: 50, op:100, admin: 200, netadmin: 255 }

  # Forum
  has_many :topics, :class_name => 'Forum::Topic', :dependent => :destroy
  has_many :posts, :class_name => 'Forum::Post', :dependent => :destroy

  # News
  has_many :news_posts, :class_name => 'System::News'

  # Aliases
  alias_method :uid, :id
  def gid; group_id end
  def tagged; username end
  def level; 0 end
  def percent_level_complete; 0 end

  # Methods
  def can_bypass?
    true if self.admin? || self.netadmin?
  end


end
