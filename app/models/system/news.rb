class System::News < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :role

  friendly_id :title
  paginates_per 10

  def publish
    self.published_at = Time.now
  end
end
