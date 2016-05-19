require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get manage_pending" do
    get :manage_pending
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
