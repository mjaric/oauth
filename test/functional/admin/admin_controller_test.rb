require 'test_helper'

class Admin::AdminControllerTest < ActionController::TestCase
  test "should get current_ability" do
    get :current_ability
    assert_response :success
  end

end
