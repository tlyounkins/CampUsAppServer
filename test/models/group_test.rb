require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(groupname: "Example Group", description: "Example Description")
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "name should be present" do
    @group.groupname = "     "
    assert_not @group.valid?
  end

  test "name should not be too long" do
    @group.groupname = "a" * 51
    assert_not @group.valid?
  end
end
