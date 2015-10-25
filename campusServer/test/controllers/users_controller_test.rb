require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:tyler)
    @other_user = users(:archer)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
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
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should create user" do #TODO: Verify count zero?
    assert_difference('User.count',0) do
      post :create, user: { email: @user.email, name: @user.name, password: @user.password }
    end

  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end
  #TODO: do we need this test?
  #test "should get edit" do
    #get :edit, id: @user
   # assert_response :success
  #end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
  end

end
