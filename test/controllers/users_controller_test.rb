require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:tyler)
    @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { username: 'testusername', email: 'testemail@email.com', password: 'testpassword',
                            firstname: @user.firstname, lastname: @user.lastname, birthday: @user.birthday,
                            bio: @user.bio, major: @user.major, hometown: @user.hometown, age: @user.age,
                            gender: @user.gender, school: @user.school }
    end
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { username: @user.username,email: @user.email, password: @user.password,
                                      firstname: @user.firstname, lastname: @user.lastname, birthday: @user.birthday,
                                      bio: @user.bio, major: @user.major, hometown: @user.hometown, age: @user.age,
                                      gender: @user.gender, school: @user.school }
  end
end