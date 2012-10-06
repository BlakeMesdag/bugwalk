require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:blake)
    @comment = comments(:first_comment)
    @event = events(:first)
  end

  test "creating a comment adds it to the database" do
    comment = @user.comments.new(:body => "This is an awesome content")
    comment.event = @event

    assert_difference "Comment.count", 1 do
      comment.save
    end
  end

  test "can't save comment without an event" do
    comment = @user.comments.new(:body => "This is some text")

    assert !comment.save
    assert comment.errors[:event_id].present?
  end

  test "can't save comment without a user" do
    comment = Comment.new(:body => "This is some text")
    comment.event = @event

    assert !comment.save
    assert comment.errors[:user_id].present?
  end

  test "destroying a comment removes it from the database" do
    assert_difference "Comment.count", -1 do
      @comment.destroy
    end
  end

  test "updating a comment doesn't update the user_id" do
    assert_raise do
      @comment.update_attributes(:user_id => 3, :body => "Some new body with awesome content")

      require 'debugger'; debugger
      assert @comment.errors
    end
  end
end
