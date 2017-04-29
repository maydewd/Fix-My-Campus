require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "should not save like without post" do
    initial_count = Like.count
    like = Like.new
    like.user = users(:normal1)
    assert_not like.save
    assert_equal Like.count, initial_count
  end
  
  test "should not save like without user" do
    initial_count = Like.count
    like = Like.new
    like.post = posts(:normal1)
    assert_not like.save
    assert_equal Like.count, initial_count
  end
  
  test "can't create duplicate like" do
    initial_count = Like.count
    like = Like.new
    like.user = users(:normal2)
    like.post = posts(:normal1)
    assert_not like.save
    assert_equal Like.count, initial_count
  end
  
  test "create new like" do
    initial_count = Like.count
    like = Like.new
    like.user = users(:normal1)
    like.post = posts(:normal1)
    assert like.save
    assert_equal Like.count, initial_count+1
  end
  
  test "delete like (unlike)" do
    initial_count = Like.count
    likes(:one).destroy
    assert_equal Like.count, initial_count-1
  end
end
