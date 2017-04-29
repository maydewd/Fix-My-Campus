require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get all schools page" do
    get schools_path
    assert_response :success
  end
  
  ###
  
  test "should get individual school page" do
    get school_path(schools(:duke))
    assert_response :success
  end
  
  test "should not get invalid school page" do
    assert_raises ActionController::RoutingError do
      get school_path('nonexistent school name asdf')
    end
  end
  
  ###
  
   test "should get individual school stats page" do
    get stats_school_path(schools(:duke))
    assert_response :success
  end
  
  test "should not get invalid school stats page" do
    assert_raises ActionController::RoutingError do
      get stats_school_path('nonexistent school name asdf')
    end
  end
  
  
end
