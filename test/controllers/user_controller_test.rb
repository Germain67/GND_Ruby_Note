require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get f1" do
    get :f1
    assert_response :success
  end

  test "should get f2" do
    get :f2
    assert_response :success
  end

  test "should get f3" do
    get :f3
    assert_response :success
  end

end
