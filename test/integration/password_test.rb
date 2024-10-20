require "test_helper"

class PasswordTest < ActionDispatch::IntegrationTest

  def setup
    @user = create_user
  end

  # ========================
  #   パスワードを忘れた場合
  # ========================
  test "「パスワードを忘れた場合」へのアクセス確認" do
    get new_user_password_path
    assert_response :success
    assert_template 'devise/passwords/new'
    assert_select 'input[name="user[email]"][type="email"]', count: 1
    assert_select 'input[type="submit"][value=?]', 'パスワードを再設定する', count: 1
  end

end
