require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should not save comment without sign in" do
    initial_count = posts(:normal1).comments.count
    post post_comments_path(posts(:normal1)), params: { comment: { message: 'random content' } }
    assert_redirected_to new_user_session_path
    assert_equal posts(:normal1).comments.count, initial_count
  end
  
  test "shouldn't save comment without message" do
    initial_count = posts(:normal1).comments.count
    sign_in users(:normal1)
    post post_comments_path(posts(:normal1)), params: { comment: { message: nil } }
    assert_redirected_to post_path(posts(:normal1))
    assert_equal posts(:normal1).comments.count, initial_count
  end
  
  test "should save comment with sign in" do
    initial_count = posts(:normal1).comments.count
    sign_in users(:normal1)
    post post_comments_path(posts(:normal1)), params: { comment: { message: 'random content' } }
    assert_redirected_to post_path(posts(:normal1))
    assert_equal posts(:normal1).comments.count, initial_count + 1
  end
  
  test "should not delete comment without sign in" do
    initial_count = Comment.count
    delete comment_path(comments(:one))
    assert_redirected_to new_user_session_path
    assert_equal Comment.count, initial_count
  end
  
  test "should not delete someone else's comment" do
    initial_count = Comment.count
    sign_in users(:normal1)
    delete comment_path(comments(:one))
    assert_redirected_to post_path(comments(:one).post)
    assert_equal Comment.count, initial_count
  end
  
  test "can delete own comment" do
    initial_count = Comment.count
    sign_in users(:normal1)
    delete comment_path(comments(:two))
    assert_redirected_to post_path(comments(:two).post)
    assert_equal Comment.count, initial_count-1
  end
  
end
