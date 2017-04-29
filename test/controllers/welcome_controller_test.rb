require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get index" do
    get root_path
    assert_response :success
  end
  
  test "should redirect logged in user" do
    sign_in users(:normal1)
    get root_path
    assert_redirected_to school_path(users(:normal1).school)
  end

end
