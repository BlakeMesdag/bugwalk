require 'test_helper'

class BugTest < ActiveSupport::TestCase
  def setup
    @event = events(:first)
    @bug = bugs(:awesome_bug)
  end

  test "cannot save a bug without a repo" do
    @bug.repo = nil

    assert !@bug.save
  end

  test "cannot save a bug without an owner" do
    @bug.owner = nil

    assert !@bug.save
  end

  test "cannot save a bug without a number" do
    @bug.number = nil

    assert !@bug.save
  end
end
