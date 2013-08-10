require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "should get username:string" do
    get :username:string
    assert_response :success
  end

  test "should get password:string" do
    get :password:string
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
