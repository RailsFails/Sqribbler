require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    @my_comment = comments(:one)
  end

    test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { body: @comment.body, image_id: @comment.image_id, user_id: @comment.user_id }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    #get :show, id: @comment, image_id: @comment.image_id
    get :show, {image_id: @comment.id, id: @comment.id}
    assert_response :success
  end

  test "should update comment" do
    patch :update, id: @comment, comment: { body: @comment.body, image_id: @comment.image_id, user_id: @comment.user_id }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to comments_path
  end
end
