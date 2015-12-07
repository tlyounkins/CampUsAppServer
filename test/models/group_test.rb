require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = Group.new(groupname: "Example Group", description: "Example Description")
  end
end
