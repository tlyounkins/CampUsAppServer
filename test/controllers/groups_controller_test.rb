require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  def setup
    @group = groups(:one)
    @other_group = groups(:two)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { groupname: 'testgroupname', description: 'testgroupdescription', school: 'testgroupschool'}
    end
  end
end
