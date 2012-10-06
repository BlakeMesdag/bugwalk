require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event_attributes = { title: "Bugwalk Intro", 
      description: "This week we fix bugs",
      starts_at: Time.now + 3.days,
      ends_at: Time.now + 3.days + 1.hour }

    @event = Event.new(@event_attributes)
  end

  test "creating an events adds it to the database" do
    event = Event.new(@event_attributes)

    assert_difference "Event.count", 1 do
      event.save
    end
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

  test "an event with referenced issues has links inserted" do
    @event.description = "Shopify/shopify#158"
    @event.save

    assert_match /<a /i, @event.reload.rendered_description
  end
end
