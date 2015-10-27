require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:tyler)
    @other_user = users(:archer)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { username: @user.username, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { username: @user.username, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { username: 'testusername', email: 'testemail@email.com', password: 'testpassword',
                            firstname: @user.firstname, lastname: @user.lastname, birthday: @user.birthday,
                            bio: @user.bio, major: @user.major, hometown: @user.hometown, age: @user.age,
                            gender: @user.gender }
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
                                      gender: @user.gender }
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
  end

end
