require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should not save comment without message" do
    comment = Comment.new
    comment.user = users(:normal1)
    comment.post = posts(:normal1)
    assert_not comment.save
  end
  
  test "should not save comment without user" do
    comment = Comment.new
    comment.message = 'random message content'
    comment.post = posts(:normal1)
    assert_not comment.save
  end
  
  test "should not save comment without post" do
    comment = Comment.new
    comment.message = 'random message content'
    comment.user = users(:normal1)
    assert_not comment.save
  end
  
  test "create new comment" do
    initial_count = Comment.count
    comment = Comment.new
    comment.user = users(:normal1)
    comment.post = posts(:normal1)
    comment.message = 'random message content'
    comment.save
    assert_equal Comment.count, initial_count+1
  end
  
  test "create new admin comment" do
    initial_count = Comment.count
    comment = Comment.new
    comment.user = users(:admin)
    comment.post = posts(:normal1)
    comment.message = 'admin comment message content'
    comment.save
    assert_equal Comment.count, initial_count+1
  end
  
  test "delete comment" do
    initial_count = Comment.count
    comments(:one).destroy
    assert_equal Comment.count, initial_count-1
  end
end
