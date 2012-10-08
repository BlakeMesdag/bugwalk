require 'test_helper'
require 'renderable'

class RenderableTest < ActiveSupport::TestCase
  def setup
    @superman = Superman.new
  end

  test "superman renders html" do
    assert_match /<h2>/, @superman.rendered_body
  end
end

class Superman
  include Renderable
  renderable :body

  def id
    0
  end

  def updated_at
    Time.now.utc
  end

  def body
    '## Test'
  end
end