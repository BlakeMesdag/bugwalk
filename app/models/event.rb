# t.string   "title"
# t.text     "description"
# t.datetime "starts_at"
# t.datetime "ends_at"
# t.datetime "created_at",  :null => false
# t.datetime "updated_at",  :null => false

class Event < ActiveRecord::Base
  attr_accessible :description, :ends_at, :starts_at, :title

  has_many :bugs

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

  def create_bugs_from_hashtags
    hashtags = description.scan(/[a-z]+#[0-9]+/)
    issues = {}

    hashtags.each do |tag|
      parts = tag.split("#")
      issues[parts[0]] = parts[1]
    end

    issues.each do |repo, number|
      bugs.create(owner: "Shopify", repo: repo, number: number)
    end
  end

  after_create :create_bugs_from_hashtags

  validates :title, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  validates :description, :presence => true

  validate :event_date_passed?, :ends_after_event_starts
end
