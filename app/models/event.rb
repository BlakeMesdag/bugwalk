# t.string   "title"
# t.text     "description"
# t.datetime "starts_at"
# t.datetime "ends_at"
# t.datetime "created_at",  :null => false
# t.datetime "updated_at",  :null => false

class Event < ActiveRecord::Base
  include Renderable
  attr_accessible :description, :ends_at, :starts_at, :title

  has_many :comments

  renderable :description

  def starts_at=(value)
    self.ends_at = value + 1.hour if value
    super
  end

  private
  def event_date_passed?
    return false if starts_at.blank? || ends_at.blank?
    
    if starts_at < Time.now.utc
      errors.add(:starts_at, "Event must start in the future")
    end

    if ends_at < Time.now.utc
      errors.add(:ends_at, "Event must end in the future")
    end
  end

  def ends_after_event_starts
    return false if starts_at.blank? || ends_at.blank?
    
    if starts_at > ends_at
      errors.add(:ends_at, "Event must end after it starts")
    end
  end

  def set_ends_at
    return unless ends_at.nil?
    self.ends_at = starts_at + 1.hour
  end

  validates :title, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  validates :description, :presence => true

  validate :event_date_passed?, :ends_after_event_starts

  before_save :set_ends_at
end