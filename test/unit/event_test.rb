require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event_attributes = { title: "Bugwalk Intro", 
      description: "This week we fix bugs",
      starts_at: Time.now + 3.days,
      ends_at: Time.now + 3.days + 1.hour }

    @event = Event.new(@event_attributes)
  end

  test "creating an event requires a starts_at date" do
    @event.starts_at = nil

    assert !@event.save
  end

  test "creating an event requires an ends_at date" do
    @event.ends_at = nil

    assert !@event.save
  end

  test "cannot save an event in the past" do
    @event.starts_at = Time.now - 1.day
    @event.ends_at = Time.now - 1.day + 1.hour

    assert !@event.save
  end

  test "cannot save an event without a title" do
    @event.title = ""

    assert !@event.save
  end

  test "cannot save an event without a description" do
    @event.description = ""

    assert !@event.save
  end

  test "events must end after it starts" do
    @event.ends_at = @event.starts_at - 1.hour

    assert !@event.save
  end

  test "creating an event with referenced issues creates bug links" do
    dummy_github_data
    @event.description = "This weeks bugs include: shopify#158"

    assert_difference "Bug.count", +1 do
      @event.save
    end
  end

  test "an event with referenced issues has links inserted" do
    dummy_github_data
    @event.description = "shopify#158"
    @event.save

    @event.reload

    anchor = "<a href=\"#{@event.bugs.first.github_link}\">#{@event.bugs.first.github_title}</a>"

    assert_equal anchor, @event.reload.description
  end

  private

  def dummy_github_data
    Bug.any_instance.stubs(:github_link).returns("https://github.com/Shopify/shopify/issues/158")
    Bug.any_instance.stubs(:github_title).returns("Some Bug")
  end
end
