class User < ActiveRecord::Base
  attr_accessible :bio, :email, :name

  def mentors
    User.joins('JOIN mentorships ON users.id = mentorships.mentor_id').where('mentorships.mentee_id = users.id')
  end

  def mentees
    User.joins('JOIN mentorships ON users.id = mentorships.mentee_id').where('mentorships.mentor_id = users.id')
  end

  def rendered_bio
    Rails.cache.fetch("bio:#{updated_at}:#{email}") do
      @rendered_bio ||= Github::Markdown.new.render(bio, :mode => :gfm)
    end

    @rendered_bio.html_safe
  end

  private
  validates :bio, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
