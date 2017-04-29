require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save post without message" do
    post = Post.new
    post.user = users(:normal1)
    post.school = schools(:duke)
    assert_not post.save
  end
  
  test "should save legacy post without user" do
    post = Post.new
    post.legacy = true
    post.message = 'random content'
    post.school = schools(:duke)
    assert post.save
  end
  
  test "should not save post with blank message" do
    post = Post.new
    post.message = ''
    post.user = users(:normal1)
    post.school = schools(:duke)
    assert_not post.save
  end
  
  test "should not save post with too long of message" do
    post = Post.new
    post.message = 'Long string'*10000
    post.user = users(:normal1)
    post.school = schools(:duke)
    assert_not post.save
  end
  
  test "should save post with message" do
    post = Post.new
    post.message = 'random content'
    post.user = users(:normal1)
    post.school = schools(:duke)
    assert post.save
  end
  
  test "delete post" do
    initial_count = Post.count
    posts(:normal1).destroy
    assert_equal Post.count, initial_count-1
  end
end
