class User < ActiveRecord::Base
  include Renderable
  attr_accessible :bio, :email, :name, :is_mentor

  has_many :comments

  renderable :bio

  def admin?
    (ENV['ADMINS'] || "").split(",").include?(email)
  end

  def self.all_mentors
    User.where(:is_mentor => true)
  end

  def mentors
    @mentors ||= User.joins('JOIN mentorships ON users.id = mentorships.mentor_id').where('mentorships.mentee_id = ?', id)
  end

  def mentees
    @mentees ||= User.joins('JOIN mentorships ON users.id = mentorships.mentee_id').where('mentorships.mentor_id = ?', id)
  end

  def mentor?
    is_mentor
  end

  def gravatar_url(size = 120)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip)}?s=#{size}"
  end

  private
  validates :bio, :presence => true, :if => :mentor?
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
