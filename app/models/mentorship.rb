class Mentorship < ActiveRecord::Base
  attr_accessible :mentee_id, :mentor_id

  MAX_PROTEGES = 5

  def mentor
    User.find(mentor_id)
  end

  def mentee
    User.find(mentee_id)
  end

  private

  def check_max_proteges
    if Mentorship.where(:mentor_id => mentor_id).count >= MAX_PROTEGES
      errors.add(:mentor_id, "has reached max proteges")
    end
  end

  def not_mentoring_self
    errors.add(:mentee_id, "cannot mentor yourself") if mentor_id == mentee_id
  end

  validates :mentor_id, :mentee_id, :presence => :true
  validate :check_max_proteges, :not_mentoring_self
end
