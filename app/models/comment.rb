class Comment < ActiveRecord::Base
  include Renderable
  attr_accessible :body, :event_id

  renderable :body

  belongs_to :event
  belongs_to :user

  private
  validates :user_id, :presence => true
  validates :event_id, :presence => true
end
