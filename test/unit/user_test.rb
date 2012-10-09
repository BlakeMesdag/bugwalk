require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:blake)
    @event = events(:first)
  end

  test "user can create comments on an event" do
    assert_difference "@user.comments.count", 1 do
      @user.comments.create(:body => "Some comment goes here ya", :event_id => @event.id)
    end
  end

  test "user doesnt need a bio if they aren't a mentor" do
    @user.bio = ""

    assert @user.save!
  end

  test "user needs a bio to be a mentor" do
    @user.bio = ""
    @user.is_mentor = true

    assert !@user.save
    assert @user.errors[:bio].present?
  end

  test "user needs an email" do
    @user.email = ""

    assert !@user.save
    assert @user.errors[:email].present?
  end

  test "user needs a name" do
    @user.name = ""

    assert !@user.save
    assert @user.errors[:name].present?
  end
end
