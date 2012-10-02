class Mentorship < ActiveRecord::Base
  attr_accessible :mentee_id, :mentor_id

  def mentor
    User.find(mentor_id)
  end

  def mentee
    User.find(mentee_id)
  end

  private
  validates :mentor_id, :mentee_id, :presence => :true
end
