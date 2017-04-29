require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  test "should not save school without name" do
    school = School.new
    school.nickname = 'fun'
    school.email_suffix = 'fun.edu'
    assert_not school.save
  end
  
  test "should not save school without nickname" do
    school = School.new
    school.name = 'fun university'
    school.email_suffix = 'fun.edu'
    assert_not school.save
  end
  
  test "should not save school without email_suffix" do
    school = School.new
    school.name = 'fun university'
    school.nickname = 'fun'
    assert_not school.save
  end
  
  test "should save school with name, nickname, email_suffix" do
    school = School.new
    school.name = 'fun university'
    school.nickname = 'fun'
    school.email_suffix = 'fun.edu'
    assert school.save
  end
end
