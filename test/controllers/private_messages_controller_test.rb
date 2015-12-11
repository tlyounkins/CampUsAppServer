require 'test_helper'

class PrivateMessagesControllerTest < ActionController::TestCase
  def setup
    @message = private_messages(:one)
    @other_message = private_messages(:two)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
