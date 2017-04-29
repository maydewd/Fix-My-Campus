require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "should get show page" do
    get post_path(posts(:normal1))
    assert_response :success
  end
  
  ####
  
  test "should redirect guest user from new post page" do
    get new_post_path
    assert_redirected_to new_user_session_path
  end
  
  test "should get new post page" do
    sign_in users(:normal1)
    get new_post_path
    assert_response :success
  end
  
  ###
  
  test "should redirect guest user away from edit post page" do
    get edit_post_path(posts(:normal1))
    assert_redirected_to new_user_session_path
  end
  
  test "should redirect wrong user away from edit post page" do
    sign_in users(:normal2)
    get edit_post_path(posts(:normal1))
    assert_redirected_to post_path(posts(:normal1))
  end
  
  test "should get edit post page" do
    sign_in users(:normal1)
    get edit_post_path(posts(:normal1))
    assert_response :success
  end
  
  ###
  
  test "should redirect guest user away from post create" do
    initial_count = Post.count
    post posts_path
    assert_redirected_to new_user_session_path
    assert_equal Post.count, initial_count
  end
  
  test "should not create new post without message" do
    initial_count = Post.count
    sign_in users(:normal1)
    post posts_path, params: { post: { message: nil } }
    assert_equal Post.count, initial_count
  end
  
  test "should create new post" do
    initial_count = Post.count
    sign_in users(:normal1)
    post posts_path, params: { post: { message: 'random content' } }
    assert_response :redirect
    assert_equal Post.count, initial_count + 1
  end
  
  ###
  
  test "should redirect guest user away from post update" do
    put post_path(posts(:normal1))
    assert_redirected_to new_user_session_path
  end
  
  test "should redirect wrong user away from update post" do
    sign_in users(:normal2)
    put post_path(posts(:normal1)), params: { post: { message: 'new random content' } }
    assert_redirected_to post_path(posts(:normal1))
  end
  
  test "should update post" do
    sign_in users(:normal1)
    put post_path(posts(:normal1)), params: { post: { message: 'new random content' } }
    assert_response :redirect
  end
  
  ###
  
  test "should redirect guest user away from post delete" do
    initial_count = Post.count
    delete post_path(posts(:normal1))
    assert_redirected_to new_user_session_path
    assert_equal Post.count, initial_count
  end
  
  test "should redirect wrong user away from delete post" do
    initial_count = Post.count
    sign_in users(:normal2)
    delete post_path(posts(:normal1))
    assert_redirected_to post_path(posts(:normal1))
    assert_equal Post.count, initial_count
  end
  
  test "should delete post" do
    initial_count = Post.count
    sign_in users(:normal1)
    delete post_path(posts(:normal1))
    assert_redirected_to users(:normal1).school
    assert_equal Post.count, initial_count - 1
  end
  
  ###
  
  test "should redirect guest user away from post like" do
    initial_count = posts(:normal1).likes.count
    post like_post_path(posts(:normal1))
    assert_redirected_to new_user_session_path
    assert_equal posts(:normal1).likes.count, initial_count
  end
  
  test "should like post" do
    initial_count = posts(:normal1).likes.count
    sign_in users(:normal1)
    post like_post_path(posts(:normal1))
    assert_equal posts(:normal1).likes.count, initial_count + 1
  end
  
  ###
  
  test "should redirect guest user away from post unlike" do
    initial_count = posts(:normal1).likes.count
    post unlike_post_path(posts(:normal1))
    assert_redirected_to new_user_session_path
    assert_equal posts(:normal1).likes.count, initial_count
  end
  
  test "should not unlike post if user didn't previously like" do
    initial_count = posts(:normal1).likes.count
    sign_in users(:normal1)
    post unlike_post_path(posts(:normal1))
    assert_equal posts(:normal1).likes.count, initial_count
  end
  
  test "should unlike post" do
    initial_count = posts(:normal1).likes.count
    sign_in users(:normal2)
    post unlike_post_path(posts(:normal1))
    assert_equal posts(:normal1).likes.count, initial_count-1
  end
  
  ###
  
  test "should redirect guest user away from post update status" do
    initial_status = posts(:normal1).status
    post set_status_post_path(posts(:normal1), 'completed')
    assert_redirected_to new_user_session_path
    assert_equal posts(:normal1).status, initial_status
  end
  
  test "should not change post status for normal user" do
    sign_in users(:normal1)
    post set_status_post_path(posts(:normal1), 'completed')
    assert_redirected_to post_path(posts(:normal1))
    posts(:normal1).reload
    assert_equal posts(:normal1).status, 'unreviewed'
  end
  
  test "should not change post status to arbitary thing" do
    sign_in users(:admin)
    post set_status_post_path(posts(:normal1), 'arbitrary')
    assert_redirected_to post_path(posts(:normal1))
    posts(:normal1).reload
    assert_equal posts(:normal1).status, 'unreviewed'
  end
  
  test "should change post status" do
    sign_in users(:admin)
    post set_status_post_path(posts(:normal1), 'completed')
    assert_redirected_to post_path(posts(:normal1))
    posts(:normal1).reload
    assert_equal posts(:normal1).status, 'completed'
  end
  
  ###
  
  test "should get individual user page" do
    get posts_for_user_path(users(:normal1))
    assert_response :success
  end
  
  test "should not get invalid user page" do
    assert_raises ActionController::RoutingError do
      get posts_for_user_path(-1)
    end
  end
  
end
