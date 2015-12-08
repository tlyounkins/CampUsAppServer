require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

  setup do
    @micropost = microposts(:orange)
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:tyler))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: micropost
    end
    assert_redirected_to root_url
  end
end
