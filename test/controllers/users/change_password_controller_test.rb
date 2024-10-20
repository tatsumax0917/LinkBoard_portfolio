require "test_helper"

class Users::ChangePasswordControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
    login @user
  end

  test "パスワード変更ページへアクセス" do
    get edit_change_password_path
    assert_response :success
    assert_template 'users/change_password/edit'
  end
end
