require 'test_helper'

class MentorshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:blake)
  end

  test "user cannot mentor themselves" do
    mentorship = Mentorship.new(:mentor_id => @user.id, :mentee_id => @user.id)

    assert !mentorship.save
    assert mentorship.errors[:mentee_id].present?
  end

  test "cannot mentor someone twice" do
    @user
  end
end
