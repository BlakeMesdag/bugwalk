class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :event
  belongs_to :user

  private
  validates :user_id, :presence => true
  validates :event_id, :presence => true
end
