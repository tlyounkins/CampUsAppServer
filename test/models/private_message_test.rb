require 'test_helper'

class PrivateMessageTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:tyler)
    @private_message = @user.private_messages.build(body: "Lorem ipsum")
  end

  test "should be valid" do
    assert @private_message.valid?
  end

  test "user id should be present" do
    @private_message.user_id = nil
    assert_not @private_message.valid?
  end

  test "body should be present" do
    @private_message.body = "   "
    assert_not @private_message.valid?
  end

  test "body should be at most 140 characters" do
    @private_message.body = "a" * 141
    assert_not @private_message.valid?
  end
end
