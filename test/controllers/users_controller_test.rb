require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  test "index, showアクションのアクセスチェック" do
    get users_path
    assert_response :success
    assert_template 'users/index'
    get user_profile_path(@user.unique_user_id)
    assert_response :success
    assert_template 'users/show'
  end

end
