require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:tyler)
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

  test "should create user" do #TODO: Verify count zero?
    assert_difference('User.count',0) do
      post :create, user: { email: @user.email, name: @user.name, password: @user.password }
    end

  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
  end
end
