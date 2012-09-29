# t.integer  "number"
# t.string   "owner"
# t.string   "repo"
# t.integer  "event_id"
# t.datetime "created_at", :null => false
# t.datetime "updated_at", :null => false

class Bug < ActiveRecord::Base
  attr_accessible :number, :owner, :repo, :event_id

  belongs_to :event

  def github_issue
    @issue ||= Github::Issues.new.get(owner, repo, number)
  end

  def github_link
    github_issue[:html_url]
  end

  def github_title
    github_issue[:title]
  end

  def github_description
    github_issue[:description]
  end

  private
  validates :number, :presence => true
  validates :repo, :presence => true
  validates :owner, :presence => true
end
