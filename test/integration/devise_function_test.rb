require "test_helper"

class DeviseFunctionTest < ActionDispatch::IntegrationTest

  # ========================================
  # ログアウト
  # ========================================

  test "ログアウトの動作" do
    @user = create_user
    login @user
    delete destroy_user_session_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
    assert_nil controller.current_user # ログインしていないのを確認
    assert @user.session_token.nil?
  end



  # ========================================
  # 有効化メールの再送
  # ========================================

  test "有効化メールの再送ページへのアクセス確認" do
    get resend_confirmation_email_path
    assert_response :success
    assert_template 'devise/confirmations/new'
    assert_select 'input[name="user[email]"][type="email"]', count: 1
    assert_select 'input[type="submit"][value=?]', 'アカウント有効化のメールを再送', count: 1
  end

end
