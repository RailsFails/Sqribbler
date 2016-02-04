require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get show' do
    get :show
    assert_response :success
  end

  test 'should get followers' do
    get :followers, {username: users(:one).username}
    assert_response :success
  end

  test 'should get following' do
    get :following, {username: users(:one).username}
    assert_response :success
  end
end
