require 'test_helper'
require 'renderable'

class RenderableTest < ActiveSupport::TestCase
  def setup
    @superman = Superman.new
  end

  test "superman renders html" do
    @superman.body = '## Test'
    assert_match /<h2>/, @superman.rendered_body
  end

  test "renderable renders github links" do
    @superman.body = "BlakeMesdag/bugwalk#123"

    assert_match /<a href="https:\/\/github\.com\/BlakeMesdag\/bugwalk\/issues\/123"/, @superman.rendered_body
  end
end

class Superman
  include Renderable
  renderable :body

  def body
    @body ||= '## Test'
  end

  def body=(value)
    @body = value
  end
end